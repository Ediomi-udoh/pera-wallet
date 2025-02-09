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

package com.algorand.android.ui.settings

import android.content.SharedPreferences
import androidx.hilt.lifecycle.ViewModelInject
import androidx.lifecycle.ViewModel
import com.algorand.android.utils.preference.isBiometricActive
import com.algorand.android.utils.preference.setBiometricRegistrationPreference

class SecurityViewModel @ViewModelInject constructor(
    private val sharedPref: SharedPreferences
) : ViewModel() {

    fun isBiometricActive(): Boolean {
        return sharedPref.isBiometricActive()
    }

    fun setBiometricRegistrationPreference(isChecked: Boolean) {
        sharedPref.setBiometricRegistrationPreference(isChecked)
    }
}
