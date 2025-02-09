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
//   ResultView.swift

import Foundation
import MacaroonUIKit
import UIKit

final class ResultView:
    View,
    ViewModelBindable {
    private lazy var iconView = ImageView()
    private lazy var titleView = Label()
    private lazy var bodyView = Label()

    func customize(
        _ theme: ResultViewTheme
    ) {
        addIcon(theme)
        addTitle(theme)
        addBody(theme)
    }

    func customizeAppearance(
        _ styleSheet: NoStyleSheet
    ) {}

    func prepareLayout(
        _ layoutSheet: NoLayoutSheet
    ) {}

    func bindData(
        _ viewModel: ResultViewModel?
    ) {
        if let icon = viewModel?.icon?.uiImage {
            iconView.image = icon
        } else {
            iconView.removeFromSuperview()
        }

        titleView.editText = viewModel?.title
        bodyView.editText = viewModel?.body
    }

    class func calculatePreferredSize(
        _ viewModel: ResultViewModel?,
        for theme: ResultViewTheme,
        fittingIn size: CGSize
    ) -> CGSize {
        guard let viewModel = viewModel else {
            return CGSize((size.width, 0))
        }

        let iconSize = viewModel.icon?.uiImage.size ?? .zero
        let titleSize =
            viewModel.title.boundingSize(
                fittingSize: CGSize((size.width, .greatestFiniteMagnitude))
            )
        let bodySize =
            viewModel.body.boundingSize(
                fittingSize: CGSize((size.width, .greatestFiniteMagnitude))
            )
        let preferredHeight =
            iconSize.height +
            titleSize.height +
            theme.bodyTopMargin +
            bodySize.height

        return CGSize((size.width, min(preferredHeight.ceil(), size.height)))
    }
}

extension ResultView {
    private func addIcon(
        _ theme: ResultViewTheme
    ) {
        iconView.customizeAppearance(theme.icon)

        addSubview(iconView)
        iconView.fitToHorizontalIntrinsicSize()
        iconView.fitToVerticalIntrinsicSize()
        iconView.snp.makeConstraints {
            $0.centerHorizontally(
                offset: 0,
                verticalPaddings: (0, .noMetric)
            )
        }
    }

    private func addTitle(
        _ theme: ResultViewTheme
    ) {
        titleView.customizeAppearance(theme.title)

        addSubview(titleView)
        titleView.fitToVerticalIntrinsicSize()
        titleView.snp.makeConstraints {
            $0.top == iconView.snp.bottom + theme.titleTopMargin
            $0.top.equalToSuperview().priority(.low)

            $0.setPaddings((.noMetric, 0, .noMetric, 0))
        }
    }

    private func addBody(
        _ theme: ResultViewTheme
    ) {
        bodyView.customizeAppearance(theme.body)

        addSubview(bodyView)
        bodyView.fitToVerticalIntrinsicSize()
        bodyView.snp.makeConstraints {
            $0.top == titleView.snp.bottom + theme.bodyTopMargin

            $0.setPaddings((.noMetric, 0, 0, 0))
        }
    }
}
