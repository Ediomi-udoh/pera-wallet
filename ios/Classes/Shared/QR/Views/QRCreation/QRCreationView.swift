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
//  QRCreationView.swift

import UIKit
import MacaroonUIKit

final class QRCreationView: View {
    weak var delegate: QRCreationViewDelegate?
    
    private lazy var labelTapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(notifyToCopyText(_:))
    )

    private lazy var theme = QRCreationViewTheme()
    
    private lazy var qrView = QRView(qrText: QRText(mode: draft.mode, address: draft.address, mnemonic: draft.mnemonic))
    private lazy var addressView = QRAddressLabel()
    private lazy var copyButton = Button(.imageAtLeft(spacing: theme.buttonTitleInset))
    private lazy var shareButton = Button(.imageAtLeft(spacing: theme.buttonTitleInset))
    private lazy var copyFeedbackLabel = Label()
    private var copyFeedbackLabelTopConstraint: NSLayoutConstraint?

    private let draft: QRCreationDraft
    
    init(draft: QRCreationDraft) {
        self.draft = draft
        super.init(frame: .zero)

        customize(theme)
    }
    
    func customize(_ theme: QRCreationViewTheme) {
        customizeBaseAppearance(backgroundColor: theme.backgroundColor)
        
        addQRView(theme)
        addLabel(theme)
        addCopyButton(theme)
        addShareButton(theme)
        addCopyFeedbackLabel(theme)
    }
    
    func customizeAppearance(_ styleSheet: NoStyleSheet) {}

    func prepareLayout(_ layoutSheet: NoLayoutSheet) {}
    
    func setListeners() {
        shareButton.addTarget(self, action: #selector(notifyDelegateToShareQR), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(notifyToCopyText), for: .touchUpInside)
        addressView.addGestureRecognizer(labelTapGestureRecognizer)
    }
}

extension QRCreationView {
    @objc
    private func notifyDelegateToShareQR() {
        delegate?.qrCreationViewDidShare(self)
    }
    
    @objc
    private func notifyToCopyText(_ gestureRecognizer: UITapGestureRecognizer) {
        showCopyFeedbackLabel(theme)
        delegate?.qrCreationView(self, didSelect: addressView.getAddress())
    }
}

extension QRCreationView {
    private func addCopyFeedbackLabel(_ theme: QRCreationViewTheme) {
        copyFeedbackLabel.customizeAppearance(theme.copyFeedbackLabel)
        copyFeedbackLabel.draw(corner: theme.copyFeedbackLabelCorner)
        copyFeedbackLabel.contentEdgeInsets = theme.copyFeedBackInsets

        addSubview(copyFeedbackLabel)
        copyFeedbackLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }
        copyFeedbackLabelTopConstraint = copyFeedbackLabel.topAnchor.constraint(
            equalTo: topAnchor,
            constant: -theme.copyFeedbackLabelTopInset
        )

        copyFeedbackLabelTopConstraint?.isActive = true
        copyFeedbackLabel.alpha = 0
    }
    
    private func addQRView(_ theme: QRCreationViewTheme) {
        addSubview(qrView)
        qrView.snp.makeConstraints {
            $0.top.equalToSuperview().priority(.low)
            $0.top.greaterThanOrEqualToSuperview().inset(theme.topInset)
            $0.centerX.equalToSuperview()
        }
    }

    private func addLabel(_ theme: QRCreationViewTheme) {
        addressView.customize(theme.addressTheme)
        
        addSubview(addressView)
        addressView.snp.makeConstraints {
            $0.top.equalTo(qrView.snp.bottom).offset(theme.labelTopInset)
            $0.leading.trailing.equalToSuperview().inset(theme.labelHorizontalInset)
        }
    }

    private func addCopyButton(_ theme: QRCreationViewTheme) {
        copyButton.customize(theme.copyButtonTheme)
        copyButton.bindData(
            ButtonCommonViewModel(
                title: "qr-creation-copy-address".localized,
                iconSet: [.normal("icon-qr-copy")])
        )

        addSubview(copyButton)
        copyButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(addressView.snp.bottom).offset(theme.copyButtonTopInset).priority(.medium)
            $0.leading.trailing.equalToSuperview().inset(theme.buttonHorizontalInset)
        }
    }

    private func addShareButton(_ theme: QRCreationViewTheme) {
        shareButton.customize(theme.shareButtonTheme)
        shareButton.bindData(
            ButtonCommonViewModel(
                title: "title-share-qr".localized,
                iconSet: [.normal("icon-qr-share")])
        )

        addSubview(shareButton)
        shareButton.snp.makeConstraints {
            $0.top.equalTo(copyButton.snp.bottom).offset(theme.shareButtonTopInset)
            $0.leading.trailing.equalToSuperview().inset(theme.buttonHorizontalInset)
            $0.bottom.equalToSuperview().inset(safeAreaBottom + theme.bottomInset)
        }
    }
}

extension QRCreationView {
    func bindData(_ viewModel: QRAddressLabelViewModel) {
        addressView.bindData(viewModel)
    }
}

extension QRCreationView {
    func getQRImage() -> UIImage? {
        return qrView.imageView.image
    }
}

extension QRCreationView {
    private func showCopyFeedbackLabel(_ theme: QRCreationViewTheme) {
        guard copyFeedbackLabel.alpha == 0 else { return }

        copyFeedbackLabel.alpha = 1
        copyFeedbackLabelTopConstraint?.constant = theme.copyFeedbackLabelTopInset

        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 1,
            animations: {
                self.layoutIfNeeded()
            }) { _ in
                UIView.animate(
                    withDuration: 1.0,
                    delay: 0.0,
                    usingSpringWithDamping: 0.6,
                    initialSpringVelocity: 1,
                    animations: {
                        self.copyFeedbackLabelTopConstraint?.constant = -theme.copyFeedbackLabelTopInset
                        self.copyFeedbackLabel.alpha = 0
                        self.layoutIfNeeded()
                    })
            }
    }
}

protocol QRCreationViewDelegate: AnyObject {
    func qrCreationViewDidShare(_ qrCreationView: QRCreationView)
    func qrCreationView(_ qrCreationView: QRCreationView, didSelect text: String)
}
