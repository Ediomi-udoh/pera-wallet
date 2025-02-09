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
//   TransactionHistoryContextViewTheme.swift

import Foundation
import MacaroonUIKit
import UIKit

struct TransactionHistoryContextViewTheme: StyleSheet, LayoutSheet {
    let backgroundColor: Color
    let titleLabel: TextStyle
    let subtitleLabel: TextStyle
    let secondaryAmountLabel: TextStyle

    let horizontalInset: LayoutMetric
    let verticalInset: LayoutMetric
    let subtitleTopInset: LayoutMetric

    init(_ family: LayoutFamily) {
        self.backgroundColor = AppColors.Shared.System.background
        self.titleLabel = [
            .textAlignment(.left),
            .textOverflow(SingleLineFittingText()),
            .textColor(AppColors.Components.Text.main),
            .font(Fonts.DMSans.regular.make(15)),
        ]
        self.subtitleLabel = [
            .textAlignment(.left),
            .textOverflow(SingleLineFittingText()),
            .textColor(AppColors.Components.Text.grayLighter),
            .font(Fonts.DMSans.regular.make(13)),
        ]
        self.secondaryAmountLabel = [
            .textAlignment(.left),
            .textOverflow(SingleLineFittingText()),
            .textColor(AppColors.Components.Text.grayLighter),
            .font(Fonts.DMSans.regular.make(13)),
        ]
        self.horizontalInset = 24
        self.verticalInset = 14
        self.subtitleTopInset = 7
    }
}
