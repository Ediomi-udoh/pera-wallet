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

package com.algorand.android.utils

import android.graphics.drawable.Drawable
import android.net.Uri
import android.widget.ImageView
import androidx.annotation.DrawableRes
import androidx.appcompat.content.res.AppCompatResources
import com.algorand.android.R
import com.algorand.android.utils.walletconnect.getRandomPeerMetaIconResId
import com.bumptech.glide.Glide
import com.bumptech.glide.load.DataSource
import com.bumptech.glide.load.engine.GlideException
import com.bumptech.glide.request.RequestListener
import com.bumptech.glide.request.target.Target

fun ImageView.loadContactProfileImage(uri: Uri?, shouldUsePlaceHolder: Boolean = true) {
    if (uri == null) {
        if (shouldUsePlaceHolder.not()) return
        setBackgroundResource(R.drawable.bg_layer_gray_lighter_oval)
        Glide.with(this)
            .load(R.drawable.ic_user_placeholder)
            .into(this)
    } else {
        Glide.with(this)
            .load(uri)
            .circleCrop()
            .into(this)
    }
}

fun ImageView.loadImage(@DrawableRes drawableResId: Int) {
    Glide.with(this)
        .load(drawableResId)
        .into(this)
}

fun ImageView.loadPeerMetaIcon(url: String?) {
    Glide.with(this)
        .load(url)
        .listener(object : RequestListener<Drawable> {
            override fun onLoadFailed(
                e: GlideException?,
                model: Any?,
                target: Target<Drawable>?,
                isFirstResource: Boolean
            ): Boolean {
                val errorDrawable = AppCompatResources.getDrawable(context, getRandomPeerMetaIconResId())
                setImageDrawable(errorDrawable)
                return true
            }

            override fun onResourceReady(
                resource: Drawable?,
                model: Any?,
                target: Target<Drawable>?,
                dataSource: DataSource?,
                isFirstResource: Boolean
            ): Boolean {
                return false
            }
        })
        .circleCrop()
        .into(this)
}

fun ImageView.loadCircularImage(uri: Uri) {
    Glide.with(this)
        .load(uri)
        .circleCrop()
        .into(this)
}
