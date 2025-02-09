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
//  AccountCellViewModel.swift

import UIKit

final class AccountCellViewModel {
    private(set) var accountImageTypeImage: UIImage?
    private(set) var name: String?
    private(set) var detail: String?
    private(set) var attributedDetail: NSAttributedString?

    /// Shows checkmark image if `isSelected` is `true` in `AccountCheckmarkSelectionViewCell`
    private(set) lazy var isSelected: Bool = {
        if case let .walletConnect(selectedAccount) = mode {
           return selectedAccount == account
        }
        return false
    }()

    private let mode: AccountListViewController.Mode
    private let account: Account

    init(account: Account, mode: AccountListViewController.Mode) {
        self.mode = mode
        self.account = account
        bindAccountImageTypeImage(account)
        bindName(account)
        bindDetail(account, for: mode)
    }
}

extension AccountCellViewModel {
    private func bindName(_ account: Account) {
        name = account.name ?? "title-unknown".localized
    }

    private func bindDetail(_ account: Account, for mode: AccountListViewController.Mode) {
        switch mode {
        case .walletConnect:
            detail = account.amount.toAlgos.toAlgosStringForLabel
        case let .transactionSender(assetDetail),
            let .transactionReceiver(assetDetail),
            let .contact(assetDetail):
            if let assetDetail = assetDetail {
                guard let assetAmount = account.amount(for: assetDetail) else {
                    return
                }

                let amountText = "\(assetAmount.toFractionStringForLabel(fraction: assetDetail.decimals) ?? "")".attributed(
                    [
                        .textColor(AppColors.Components.Text.main.uiColor),
                        .font(Fonts.DMMono.regular.make(15).uiFont)
                    ]
                )

                let codeText = " (\(assetDetail.unitNameRepresentation))".attributed(
                    [
                        .textColor(AppColors.Components.Text.grayLighter.uiColor),
                        .font(Fonts.DMSans.regular.make(13).uiFont)
                    ]
                )
                attributedDetail = amountText + codeText
            } else {
                detail = account.amount.toAlgos.toAlgosStringForLabel
            }
        }
    }

    private func bindAccountImageTypeImage(_ account: Account) {
        accountImageTypeImage = account.image
    }
}
