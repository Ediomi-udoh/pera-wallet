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
//   NoContentViewCommonTheme.swift

import Foundation
import MacaroonUIKit
import UIKit

struct NoContentViewCommonTheme: NoContentViewTheme {
    let icon: ImageStyle
    let title: TextStyle
    let titleTopMargin: LayoutMetric
    let body: TextStyle
    let bodyTopMargin: LayoutMetric
    let contentHorizontalPaddings: LayoutHorizontalPaddings
    let contentVerticalPadding: LayoutMetric
    let resultTopInset: LayoutMetric?

    init(
        _ family: LayoutFamily
    ) {
        let resultTheme = ResultViewCommonTheme()

        self.icon = resultTheme.icon
        self.title = resultTheme.title
        self.body = resultTheme.body
        self.titleTopMargin = resultTheme.titleTopMargin
        self.bodyTopMargin = resultTheme.bodyTopMargin
        self.contentHorizontalPaddings = (24, 24)
        self.contentVerticalPadding = 16
        self.resultTopInset = nil
    }
}
