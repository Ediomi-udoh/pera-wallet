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
//  TutorialViewModel.swift

import UIKit
import MacaroonUIKit
import Foundation

final class TutorialViewModel: PairedViewModel {
    private(set) var image: UIImage?
    private(set) var title: String?
    private(set) var description: String?
    private(set) var primaryActionButtonTitle: String?
    private(set) var secondaryActionButtonTitle: String?
    private(set) var warningDescription: String?

    init(_ model: Tutorial) {
        bindImage(model)
        bindTitle(model)
        bindDescription(model)
        bindPrimaryActionButtonTitle(model)
        bindSecondaryActionButtonTitle(model)
        bindWarningTitle(model)
    }
}

extension TutorialViewModel {
    private func bindImage(_ tutorial: Tutorial) {
        switch tutorial {
        case .backUp:
            image = img("shield")
        case .recoverWithPassphrase:
            image = img("key")
        case .watchAccount:
            image = img("eye")
        case .writePassphrase:
            image = img("pen")
        case .passcode:
            image = img("locked")
        case .localAuthentication:
            image = img("faceid")
        case .biometricAuthenticationEnabled, .accountVerified, .ledgerSuccessfullyConnected, .accountSuccessfullyRekeyed:
            image = img("check")
        case .passphraseVerified:
            image = img("shield-check")
        case .recoverWithLedger:
            image = img("ledger")
        }
    }

    private func bindTitle(_ tutorial: Tutorial) {
        switch tutorial {
        case .backUp:
            title = "tutorial-title-back-up".localized
        case .recoverWithPassphrase:
            title = "tutorial-title-recover".localized
        case .watchAccount:
            title = "title-watch-account".localized
        case .writePassphrase:
            title = "tutorial-title-write".localized
        case .passcode:
            title = "tutorial-title-passcode".localized
        case .localAuthentication:
            title = "local-authentication-preference-title".localized
        case .biometricAuthenticationEnabled:
            title = "local-authentication-enabled-title".localized
        case .passphraseVerified:
            title = "pass-phrase-verify-pop-up-title".localized
        case .accountVerified:
            title = "recover-from-seed-verify-pop-up-title".localized
        case .recoverWithLedger:
            title = "ledger-tutorial-title-text".localized
        case .ledgerSuccessfullyConnected:
            title = "tutorial-title-ledger-connected".localized
        case .accountSuccessfullyRekeyed:
            title = "ledger-rekey-success-title".localized
        }
    }

    private func bindDescription(_ tutorial: Tutorial) {
        switch tutorial {
        case .backUp:
            description = "tutorial-description-back-up".localized
        case .recoverWithPassphrase:
            description = "tutorial-description-recover".localized
        case .watchAccount:
            description = "tutorial-description-watch".localized
        case .writePassphrase:
            description = "tutorial-description-write".localized
        case .passcode:
            description = "tutorial-description-passcode".localized
        case .localAuthentication:
            description = "tutorial-description-local".localized
        case .biometricAuthenticationEnabled:
            description = "local-authentication-enabled-subtitle".localized
        case .passphraseVerified:
            description = "pass-phrase-verify-pop-up-explanation".localized
        case .accountVerified:
            description = "recover-from-seed-verify-pop-up-explanation".localized
        case .recoverWithLedger:
            description = "tutorial-description-ledger".localized
        case .ledgerSuccessfullyConnected:
            description = "tutorial-description-ledger-connected".localized
        case .accountSuccessfullyRekeyed(let accountName):
            description = "ledger-rekey-success-message".localized(params: accountName)
        }
    }

    private func bindPrimaryActionButtonTitle(_ tutorial: Tutorial) {
        switch tutorial {
        case .backUp:
            primaryActionButtonTitle = "tutorial-main-title-back-up".localized
        case .recoverWithPassphrase:
            primaryActionButtonTitle = "tutorial-main-title-recover".localized
        case .watchAccount:
            primaryActionButtonTitle = "watch-account-button".localized
        case .writePassphrase:
            primaryActionButtonTitle = "tutorial-main-title-write".localized
        case .passcode:
            primaryActionButtonTitle = "tutorial-main-title-passcode".localized
        case .localAuthentication:
            primaryActionButtonTitle = "local-authentication-enable".localized
        case .biometricAuthenticationEnabled:
            primaryActionButtonTitle = "title-go-to-accounts".localized
        case .passphraseVerified:
            primaryActionButtonTitle = "title-next".localized
        case .accountVerified:
            primaryActionButtonTitle = "title-start-using-pera-wallet".localized
        case .recoverWithLedger:
            primaryActionButtonTitle = "ledger-tutorial-title-text".localized
        case .ledgerSuccessfullyConnected:
            primaryActionButtonTitle = "tutorial-main-title-ledger-connected".localized
        case .accountSuccessfullyRekeyed:
            primaryActionButtonTitle = "title-start-using-pera-wallet".localized
        }
    }

    private func bindWarningTitle(_ tutorial: Tutorial) {
        switch tutorial {
        case .watchAccount:
            warningDescription = "tutorial-description-watch-warning".localized
        case .writePassphrase:
            warningDescription = "tutorial-description-write-warning".localized
        default:
            break
        }
    }

    private func bindSecondaryActionButtonTitle(_ tutorial: Tutorial) {
        switch tutorial {
        case .passcode:
            secondaryActionButtonTitle = "tutorial-action-title-passcode".localized
        case .localAuthentication:
            secondaryActionButtonTitle = "local-authentication-no".localized
        case .recoverWithLedger:
            secondaryActionButtonTitle = "tutorial-action-title-ledger".localized
        default:
            break
        }
    }
}
