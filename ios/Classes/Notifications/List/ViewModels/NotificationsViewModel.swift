// Copyright 2022 Pera Wallet, LDA

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//    http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  NotificationsViewModel.swift

import UIKit
import SwiftDate

final class NotificationsViewModel: Hashable {
    private(set) var notificationImage: UIImage?
    private(set) var title: NSAttributedString?
    private(set) var time: String?
    private(set) var isRead: Bool = true

    private let notificationMessage: NotificationMessage
    
    init(
        notification: NotificationMessage,
        senderAccount: Account? = nil,
        receiverAccount: Account? = nil,
        contact: Contact? = nil,
        latestReadTimestamp: TimeInterval? = nil
    ) {
        self.notificationMessage = notification

        bindImage(notification: notification, contact: contact)
        bindTitle(notification: notification, senderAccount: senderAccount, receiverAccount: receiverAccount, contact: contact)
        bindTime(notification: notification)
        bindIsRead(notification: notification, latestReadTimestamp: latestReadTimestamp)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(notificationMessage.id)
    }

    static func == (lhs: NotificationsViewModel, rhs: NotificationsViewModel) -> Bool {
        lhs.notificationMessage.id == rhs.notificationMessage.id
    }
}

extension NotificationsViewModel {
    private func bindImage(notification: NotificationMessage, contact: Contact?) {
        if let contact = contact {
            if let imageData = contact.image,
                let image = UIImage(data: imageData) {
                let resizedImage = image.convert(to: CGSize(width: 40, height: 40))
                notificationImage = resizedImage
            } else {
                notificationImage = img("icon-user-placeholder")
            }
            return
        }

        if notification.notificationType == .transactionFailed || notification.notificationType == .assetTransactionFailed {
            notificationImage = img("img-nc-failed")
        } else {
            notificationImage = img("img-nc-success")
        }
    }

    private func bindTitle(notification: NotificationMessage, senderAccount: Account?, receiverAccount: Account?, contact: Contact?) {
        guard let notificationDetail = notification.detail,
            let notificationType = notification.notificationType else {
            title = NSAttributedString(string: notification.message ?? "")
            return
        }

        let sender = getSenderInformationFromLocalValues(in: notificationDetail, account: senderAccount, contact: contact) ?? ""
        let receiver = getReceiverInformationFromLocalValues(in: notificationDetail, account: receiverAccount, contact: contact) ?? ""
        let assetDisplayName = getAssetDisplayName(from: notificationDetail) ?? ""
        let amount = getAmount(from: notificationDetail) ?? ""
        let assetWithAmount = "\(amount) \(assetDisplayName)"

        switch notificationType {
        case .transactionSent,
            .assetTransactionSent:
            let message = "notification-sent-success".localized(params: assetWithAmount, sender, receiver)
            title = getAttributedMessage(message, for: assetWithAmount, sender, receiver)
        case .transactionReceived,
             .assetTransactionReceived:
            let message = "notification-received".localized(params: assetWithAmount, receiver, sender)
            title = getAttributedMessage(message, for: assetWithAmount, receiver, sender)
        case .transactionFailed,
             .assetTransactionFailed:
            let message = "notification-sent-failed".localized(params: assetWithAmount, sender, receiver)
            title = getAttributedMessage(message, for: assetWithAmount, sender, receiver)
        case .assetSupportRequest:
            let message = "notification-support-request".localized(params: sender, assetDisplayName)
            title = getAttributedMessage(message, for: sender, assetDisplayName)
        case .assetSupportSuccess:
            let message = "notification-support-success".localized(params: sender, assetDisplayName)
            title = getAttributedMessage(message, for: sender, assetDisplayName)
        case .broadcast:
            title = notification.message?.attributed()
        }
    }

    private func bindTime(notification: NotificationMessage) {
        if let notificationDate = notification.date {
            time = (Date() - notificationDate).ago.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.autoUpdating)
        }
    }

    private func bindIsRead(notification: NotificationMessage, latestReadTimestamp: TimeInterval?) {
        guard let notificationLatestFetchTimestamp = latestReadTimestamp,
            let notificationDate = notification.date else {
            isRead = false
            return
        }

        isRead = notificationDate.timeIntervalSince1970 < notificationLatestFetchTimestamp
    }
}

extension NotificationsViewModel {
    private func getSenderInformationFromLocalValues(
        in notificationDetail: NotificationDetail,
        account: Account?,
        contact: Contact?
    ) -> String? {
        if let account = account,
            let accountName = account.name,
            let senderAddress = notificationDetail.senderAddress,
            account.address == senderAddress {
            return accountName
        } else if let contact = contact,
            let contactAddress = contact.address,
            let contactName = contact.name,
            let senderAddress = notificationDetail.senderAddress,
            contactAddress == senderAddress {
            return contactName
        } else {
            return notificationDetail.senderAddress?.shortAddressDisplay()
        }
    }
    
    private func getReceiverInformationFromLocalValues(
        in notificationDetail: NotificationDetail,
        account: Account?,
        contact: Contact?
    ) -> String? {
        if let account = account,
            let accountName = account.name,
            let receiverAddress = notificationDetail.receiverAddress,
            account.address == receiverAddress {
            return accountName
        } else if let contact = contact,
            let contactAddress = contact.address,
            let contactName = contact.name,
            let receiverAddress = notificationDetail.receiverAddress,
            contactAddress == receiverAddress {
            return contactName
        } else {
            return notificationDetail.receiverAddress?.shortAddressDisplay()
        }
    }
    
    private func getAmount(from notificationDetail: NotificationDetail) -> String? {
        let amount = notificationDetail.amount
        if let asset = notificationDetail.asset {
            let fraction = asset.fractionDecimals ?? 0
            return amount.assetAmount(fromFraction: fraction).toFractionStringForLabel(fraction: fraction)
        }
        return amount.toAlgos.toAlgosStringForLabel
    }
    
    private func getAssetDisplayName(from notificationDetail: NotificationDetail) -> String? {
        if let asset = notificationDetail.asset {
            let isUnknown = asset.name.isNilOrEmpty && asset.code.isNilOrEmpty
            let assetDisplayName = isUnknown ? "title-unknown".localized : "\(asset.name ?? "") (\(asset.code ?? ""))"
            return assetDisplayName
        }
        return "Algo"
    }
    
    private func getAttributedMessage(_ message: String, for parameters: String...) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(
            string: message,
            attributes: [
                .font: Fonts.DMSans.regular.make(15).uiFont,
                .foregroundColor: AppColors.Components.Text.main.uiColor
            ]
        )
        parameters.forEach { parameter in
            let parameterRange = (message as NSString).range(of: parameter)
            attributedText.addAttributes([.font: Fonts.DMSans.medium.make(15).uiFont], range: parameterRange)
        }
        return attributedText
    }
}
