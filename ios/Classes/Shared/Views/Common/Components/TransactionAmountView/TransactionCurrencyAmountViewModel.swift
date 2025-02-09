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
//   TransactionCurrencyAmountViewModel.swift

import Foundation
import MacaroonUIKit
import UIKit

struct TransactionCurrencyAmountViewModel:
    PairedViewModel,
    Hashable {
    private(set) var amountLabelText: EditText?
    private(set) var amountLabelColor: UIColor?
    private(set) var currencyLabelText: EditText?

    init(
        _ mode: TransactionAmountView.Mode
    ) {
        bindMode(mode)
    }
}

extension TransactionCurrencyAmountViewModel {
    private mutating func bindMode(
        _ mode: TransactionAmountView.Mode
    ) {
        switch mode {
        case let .normal(amount, isAlgos, assetFraction, assetSymbol, currency):
            bindAmount(amount, with: assetFraction, isAlgos: isAlgos, assetSymbol: assetSymbol, currency: currency)
        case let .positive(amount, isAlgos, assetFraction, assetSymbol, currency):
            bindAmount(amount, with: assetFraction, isAlgos: isAlgos, assetSymbol: assetSymbol, currency: currency)
        case let .negative(amount, isAlgos, assetFraction, assetSymbol, currency):
            bindAmount(amount, with: assetFraction, isAlgos: isAlgos, assetSymbol: assetSymbol, currency: currency)
        }
    }

    private mutating func bindAmount(
        _ amount: Decimal,
        with assetFraction: Int?,
        isAlgos: Bool,
        assetSymbol: String? = nil,
        currency: String? = nil
    ) {
        if let fraction = assetFraction {
            amountLabelText = .string(amount.toFractionStringForLabel(fraction: fraction))
        } else {
            amountLabelText = .string(amount.toAlgosStringForLabel)
        }

        if isAlgos {
            amountLabelText = .string("\(amountLabelText?.string ?? "") ALGO")
        } else {
            if let assetSymbol = assetSymbol {
                amountLabelText = .string("\(amountLabelText?.string ?? "") \(assetSymbol)")
            }
        }
        amountLabelColor = AppColors.Components.Text.main.uiColor
        currencyLabelText = .string(currency)
    }
}
