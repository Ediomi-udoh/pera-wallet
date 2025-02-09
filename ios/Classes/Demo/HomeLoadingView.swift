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
//   HomeLoadingView.swift

import Foundation
import MacaroonUIKit
import UIKit

final class HomeLoadingView:
    View,
    ListReusable {
    private lazy var theme = HomeLoadingViewTheme()

    private lazy var portfolioLabel = Label()
    private lazy var portfoliloLoading = GradientView(
        gradientStartColor: AppColors.Shared.Layer.gray.uiColor,
        gradientEndColor: AppColors.Shared.Layer.grayLighter.uiColor.withAlphaComponent(0.5)
    )
    private lazy var holdingsContainer = UIView()
    private lazy var algoHoldingsContainer = UIView()
    private lazy var algoHoldingsLabel = Label()
    private lazy var algoImageView = UIView()
    private lazy var algoHoldingLoading = GradientView(
        gradientStartColor: AppColors.Shared.Layer.gray.uiColor,
        gradientEndColor: AppColors.Shared.Layer.grayLighter.uiColor.withAlphaComponent(0.5)
    )

    private lazy var assetHoldingsContainer = UIView()
    private lazy var assetHoldingsLabel = Label()
    private lazy var assetHoldingLoading = GradientView(
        gradientStartColor: AppColors.Shared.Layer.gray.uiColor,
        gradientEndColor: AppColors.Shared.Layer.grayLighter.uiColor.withAlphaComponent(0.5)
    )

    private lazy var accountsLabel = Label()
    private lazy var firstAccountPreviewLoading = AssetPreviewLoadingView()
    private lazy var secondAccountPreviewLoading = AssetPreviewLoadingView()
    
    override init(
        frame: CGRect
    ) {
        super.init(frame: frame)
        addPortfolioView()
        addAccountCells()
    }
    
    func customizeAppearance(
        _ styleSheet: NoStyleSheet
    ) {}

    func prepareLayout(
        _ layoutSheet: NoLayoutSheet
    ) {}
}

extension HomeLoadingView {
    func startAnimating() {
    }
    
    func stopAnimating() {
    }
}

extension HomeLoadingView {
    private func addPortfolioView() {
        portfolioLabel.editText = theme.portfolioText
        algoHoldingsLabel.editText = theme.algoHoldingText
        assetHoldingsLabel.editText = theme.assetHoldingText

        addSubview(portfolioLabel)
        portfolioLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(theme.portfolioMargin.top)
            make.leading.equalToSuperview()
        }

        portfoliloLoading.draw(corner: theme.loadingCorner)

        addSubview(portfoliloLoading)
        portfoliloLoading.snp.makeConstraints { make in
            make.top.equalTo(portfolioLabel.snp.bottom).offset(theme.portfolioLoadingMargin.top)
            make.leading.equalTo(portfolioLabel)
            make.size.equalTo(
                CGSize(width: theme.portfolioLoadingSize.w,
                       height: theme.portfolioLoadingSize.h)
            )
        }

        addSubview(holdingsContainer)
        holdingsContainer.snp.makeConstraints {
            $0.top.equalTo(portfolioLabel.snp.bottom).offset(theme.holdingsContainerMargin.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(theme.holdingsContainerHeight)
        }

        addAlgoHoldings()
        addAssetHoldings()
    }

    private func addAlgoHoldings() {
        holdingsContainer.addSubview(algoHoldingsContainer)
        algoHoldingsContainer.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }

        algoHoldingsContainer.addSubview(algoHoldingsLabel)
        algoHoldingsLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        algoImageView.backgroundColor = theme.algoImageBackground
        algoImageView.layer.cornerRadius = theme.algoImageCornerRadius

        algoHoldingsContainer.addSubview(algoImageView)
        algoImageView.snp.makeConstraints {
            $0.top.equalTo(algoHoldingsLabel.snp.bottom).offset(theme.algoImageTopInset)
            $0.leading.equalToSuperview()
            $0.size.equalTo(
                CGSize(width: theme.algoImageSize.w, height: theme.algoImageSize.h)
            )
        }

        algoHoldingLoading.draw(corner: theme.loadingCorner)

        algoHoldingsContainer.addSubview(algoHoldingLoading)
        algoHoldingLoading.snp.makeConstraints {
            $0.centerY.equalTo(algoImageView)
            $0.leading.equalTo(algoImageView.snp.trailing).offset(theme.algoHoldingLoadingLeadingInset)
            $0.size.equalTo(
                CGSize(width: theme.algoHoldingLoadingSize.w, height: theme.algoHoldingLoadingSize.h)
            )
        }
    }

    private func addAssetHoldings() {
        holdingsContainer.addSubview(assetHoldingsContainer)
        assetHoldingsContainer.snp.makeConstraints {
            $0.width.equalTo(algoHoldingsContainer)
            $0.top.equalToSuperview()
            $0.leading.equalTo(algoHoldingsContainer.snp.trailing)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        assetHoldingsContainer.addSubview(assetHoldingsLabel)
        assetHoldingsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
        }

        assetHoldingLoading.draw(corner:theme.loadingCorner)
        assetHoldingsContainer.addSubview(assetHoldingLoading)
        assetHoldingLoading.snp.makeConstraints {
            $0.centerY.equalTo(algoHoldingLoading)
            $0.leading.equalTo(assetHoldingsLabel.snp.leading)
            $0.size.equalTo(
                CGSize(width: theme.algoHoldingLoadingSize.w, height: theme.algoHoldingLoadingSize.h)
            )
        }
    }

    private func addAccountCells() {
        accountsLabel.customizeAppearance(theme.accountsLabelStyle)

        addSubview(accountsLabel)
        accountsLabel.snp.makeConstraints {
            $0.top.equalTo(holdingsContainer.snp.bottom).offset(theme.accountsLabelMargin.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        firstAccountPreviewLoading.customize(AssetPreviewLoadingViewCommonTheme())
        secondAccountPreviewLoading.customize(AssetPreviewLoadingViewCommonTheme())

        addSubview(firstAccountPreviewLoading)
        firstAccountPreviewLoading.snp.makeConstraints {
            $0.top.equalTo(accountsLabel.snp.bottom).offset(theme.accountLoadingMargin.top)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(theme.accountLoadingHeight)
        }
        
        addSubview(secondAccountPreviewLoading)
        secondAccountPreviewLoading.snp.makeConstraints {
            $0.top.equalTo(firstAccountPreviewLoading.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(theme.accountLoadingHeight)
        }
    }
}
