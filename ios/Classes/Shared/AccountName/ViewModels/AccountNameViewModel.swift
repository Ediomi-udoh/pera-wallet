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
//  AccountNameViewModel.swift

import UIKit

final class AccountNameViewModel {
    private(set) var accountType: AccountType
    private(set) var image: UIImage?
    private(set) var name: String?
    
    init(account: Account, hasImage: Bool = true) {
        accountType = account.type
        bindImage(from: account, with: hasImage)
        bindName(from: account, with: hasImage)
    }

    init(contact: Contact, hasImage: Bool = true) {
        accountType = .standard
        bindImage(from: contact, with: hasImage)
        bindName(from: contact, with: hasImage)
    }
}

extension AccountNameViewModel {
    private func bindImage(from account: Account, with hasImage: Bool) {
        if !hasImage {
            return
        }

        image = account.image ?? accountType.image(for: AccountImageType.getRandomImage(for: accountType))
    }

    private func bindImage(from contact: Contact, with hasImage: Bool) {
        if !hasImage {
            return
        }

        if let imageData = contact.image,
           let image = UIImage(data: imageData) {
            self.image = image
        } else {
            self.image = "icon-user-placeholder".uiImage
        }
    }

    private func bindName(from account: Account, with hasImage: Bool) {
        if !hasImage {
            name = account.address
            return
        }

        name = account.name.unwrap(or: account.address.shortAddressDisplay())
    }

    private func bindName(from contact: Contact, with hasImage: Bool) {
        if !hasImage {
            name = contact.address
            return
        }

        guard let contactAddress = contact.address else {
            return
        }

        name = contact.name.unwrap(or: contactAddress.shortAddressDisplay())
    }
}
