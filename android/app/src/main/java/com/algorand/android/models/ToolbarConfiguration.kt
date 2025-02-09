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

package com.algorand.android.models

import androidx.annotation.ColorRes
import androidx.annotation.DrawableRes
import androidx.annotation.StringRes

data class ToolbarConfiguration(
    @StringRes
    val titleResId: Int? = null,
    @DrawableRes
    val startIconResId: Int? = null,
    @ColorRes
    val backgroundColor: Int? = null,
    val startIconClick: (() -> Unit)? = null,
    val showNodeStatus: Boolean = false,
    val showAvatarImage: Boolean = false,
    val showAccountImage: Boolean = false
)
