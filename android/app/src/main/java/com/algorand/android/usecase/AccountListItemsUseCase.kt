/*
 * Copyright 2022 Pera Wallet, LDA
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License
 */

package com.algorand.android.usecase

import com.algorand.android.mapper.AccountListItemMapper
import com.algorand.android.models.Account
import com.algorand.android.models.AccountBalance
import com.algorand.android.models.AccountDetail
import com.algorand.android.models.CurrencyValue
import com.algorand.android.ui.common.listhelper.BaseAccountListItem
import com.algorand.android.utils.CacheResult
import com.algorand.android.utils.formatAsCurrency
import javax.inject.Inject

class AccountListItemsUseCase @Inject constructor(
    private val accountListItemMapper: AccountListItemMapper,
    private val accountTotalBalanceUseCase: AccountTotalBalanceUseCase
) {

    fun createAccountListItems(
        algoPriceCache: CacheResult<CurrencyValue>?,
        accountList: List<CacheResult<AccountDetail>>,
        sortedLocalAccounts: List<Account>,
        onAccountBalanceCalculated: ((AccountBalance) -> Unit)? = null
    ): List<BaseAccountListItem.BaseAccountItem> {
        val selectedCurrencySymbol = algoPriceCache?.data?.symbol.orEmpty()
        return sortedLocalAccounts.map { localAccount ->
            accountList.firstOrNull { cachedAccount ->
                cachedAccount.data?.account?.address == localAccount.address
            }?.data?.run {
                val accountBalance = accountTotalBalanceUseCase.getAccountBalance(this).also {
                    onAccountBalanceCalculated?.invoke(it)
                }
                val accountTotalHoldings = with(accountBalance) {
                    algoHoldingsInSelectedCurrency.add(assetHoldingsInSelectedCurrency)
                }
                accountListItemMapper.mapToAccountItem(
                    this,
                    accountTotalHoldings.formatAsCurrency(selectedCurrencySymbol),
                    accountBalance.assetCount
                )
            } ?: accountListItemMapper.mapToErrorAccountItem(localAccount, true)
        }
    }
}
