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
//   SendTransactionScreen+Theme.swift


import Foundation
import MacaroonUIKit
import UIKit

extension SendTransactionScreen {
    struct Theme: LayoutSheet, StyleSheet {
        let backgroundColor: UIColor
        let nextButtonStyle: ButtonTheme
        let disabledValueLabelStyle: TextStyle
        let valueLabelStyle: TextStyle
        let usdValueLabelStyle: TextStyle
        let accountContainerCorner: Corner
        let accountContainerBorder: Border
        let accountContainerFirstShadow: MacaroonUIKit.Shadow
        let accountContainerSecondShadow: MacaroonUIKit.Shadow
        let accountContainerThirdShadow: MacaroonUIKit.Shadow

        let accountContainerHeight: LayoutMetric
        let defaultLeadingInset: LayoutMetric
        let defaultBottomInset: LayoutMetric
        let accountLeadingInset: LayoutMetric
        let nextButtonHeight: LayoutMetric
        let numpadBottomInset: LayoutMetric
        let buttonsSpacing: LayoutMetric
        let buttonsBottomInset: LayoutMetric
        let buttonsLeadingInset: LayoutMetric
        let buttonsHeight: LayoutMetric
        let labelsContainerHeight: LayoutMetric
        let labelsContainerBottomInset: LayoutMetric

        init(_ family: LayoutFamily) {
            backgroundColor = AppColors.Shared.System.background.uiColor
            nextButtonStyle = ButtonPrimaryTheme(family)
            valueLabelStyle = [
                .textColor(AppColors.Components.Text.main),
                .font(Fonts.DMMono.regular.make(36)),
                .textAlignment(.center),
                .textOverflow(SingleLineFittingText())
            ]
            usdValueLabelStyle = [
                .textColor(AppColors.Components.Button.TransactionShadow.text),
                .font(Fonts.DMMono.regular.make(15)),
                .textAlignment(.center),
                .textOverflow(SingleLineFittingText())
            ]
            disabledValueLabelStyle = [
                .textColor(AppColors.Components.Text.grayLighter),
                .font(Fonts.DMMono.regular.make(36)),
                .textAlignment(.center),
                .textOverflow(SingleLineFittingText())
            ]

            accountContainerCorner = Corner(radius: 4)
            accountContainerBorder = Border(color: AppColors.SendTransaction.Shadow.first.uiColor, width: 1)

            accountContainerFirstShadow = MacaroonUIKit.Shadow(
                color: AppColors.SendTransaction.Shadow.first.uiColor,
                opacity: 1,
                offset: (0, 2),
                radius: 4,
                fillColor: AppColors.Shared.System.background.uiColor,
                cornerRadii: (4, 4),
                corners: .allCorners
            )

            accountContainerSecondShadow = MacaroonUIKit.Shadow(
                color: AppColors.SendTransaction.Shadow.second.uiColor,
                opacity: 1,
                offset: (0, 2),
                radius: 4,
                fillColor: AppColors.Shared.System.background.uiColor,
                cornerRadii: (4, 4),
                corners: .allCorners
            )

            accountContainerThirdShadow = MacaroonUIKit.Shadow(
                color: AppColors.SendTransaction.Shadow.third.uiColor,
                opacity: 1,
                offset: (0, 0),
                radius: 0,
                fillColor: AppColors.Shared.System.background.uiColor,
                cornerRadii: (4, 4),
                corners: .allCorners
            )

            accountContainerHeight = 72
            defaultLeadingInset = 24
            defaultBottomInset = -24 * verticalScale
            accountLeadingInset = 20
            nextButtonHeight = 52 * verticalScale
            numpadBottomInset = -16
            buttonsSpacing = 10
            buttonsBottomInset = -42 * verticalScale
            buttonsLeadingInset = 110
            buttonsHeight = 28
            labelsContainerHeight = 80
            labelsContainerBottomInset = -20
        }
    }
}
