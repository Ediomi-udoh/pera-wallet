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
//   AssetDetailTitleView.swift

import UIKit
import MacaroonUIKit

final class AssetDetailTitleView: View {
    private lazy var imageView = AssetImageView()
    private lazy var titleLabel = UILabel()

    func customize(_ theme: AssetDetailTitleViewTheme) {
        addImageView(theme)
        addTitleLabel(theme)
    }

    func customizeAppearance(_ styleSheet: StyleSheet) {}

    func prepareLayout(_ layoutSheet: LayoutSheet) {}
}

extension AssetDetailTitleView {
    private func addImageView(_ theme: AssetDetailTitleViewTheme) {
        imageView.theme = theme.assetImageViewSmallerTheme

        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
            $0.fitToSize(theme.imageSize)
        }
    }

    private func addTitleLabel(_ theme: AssetDetailTitleViewTheme) {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(theme.horizontalPadding)
            $0.centerY.trailing.equalToSuperview()
        }
    }
}

extension AssetDetailTitleView {
    func bindData(_ viewModel: AssetDetailTitleViewModel?) {
        imageView.bindData(
            AssetImageViewModel(
                image: viewModel?.image,
                assetAbbreviationForImage: viewModel?.assetAbbreviationForImage
            )
        )
        titleLabel.text = viewModel?.title
    }
}
