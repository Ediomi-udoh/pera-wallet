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

import android.content.Context
import android.graphics.Typeface
import android.graphics.Typeface.BOLD
import android.text.Annotation
import android.text.SpannableStringBuilder
import android.text.Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
import android.text.SpannedString
import android.text.style.AbsoluteSizeSpan
import android.text.style.CharacterStyle
import android.text.style.ForegroundColorSpan
import android.text.style.StyleSpan
import android.text.style.UnderlineSpan
import android.widget.TextView
import androidx.annotation.ColorRes
import androidx.annotation.StringRes
import androidx.core.content.ContextCompat
import androidx.core.content.res.ResourcesCompat
import androidx.core.text.color
import androidx.core.text.inSpans
import com.algorand.android.R
import com.algorand.android.customviews.CenteredImageSpan
import com.algorand.android.models.AnnotatedString
import com.algorand.android.models.AssetInformation
import com.algorand.android.utils.exceptions.InvalidAnnotationException
import com.google.firebase.crashlytics.FirebaseCrashlytics
import java.util.Locale

fun SpannableStringBuilder.addSpace() {
    append(" ")
}

fun SpannableStringBuilder.addAssetName(
    context: Context,
    fullName: String?,
    shortName: String?,
    showTickerWithFullName: Boolean = true
) {
    val isFullNameNullOrBlank = fullName.isNullOrBlank()
    val isShortNameNullOrBlank = shortName.isNullOrBlank()
    if (!isFullNameNullOrBlank) {
        append(fullName)
        if (showTickerWithFullName.not()) {
            return
        }
    }
    if (!isShortNameNullOrBlank) {
        if (!isFullNameNullOrBlank) {
            addSpace()
        }
        color(ContextCompat.getColor(context, R.color.gray_71)) {
            append(context.getString(R.string.ticker_asset_format, shortName?.toUpperCase(Locale.ENGLISH)))
        }
    }
    if (isFullNameNullOrBlank && isShortNameNullOrBlank) {
        addUnnamedAssetName(context)
    }
}

fun SpannableStringBuilder.addAssetId(context: Context, assetId: Long?, textColor: Int? = null) {
    if (assetId != null && assetId != AssetInformation.ALGORAND_ID) {
        append("  ") // Tried to put \t but it's broken for SpannedString.
        color(ContextCompat.getColor(context, textColor ?: R.color.gray_71)) {
            append(assetId.toString())
        }
    }
}

fun SpannableStringBuilder.addVerifiedIcon(
    context: Context,
    iconRes: Int = R.drawable.ic_verified_asset
) {
    inSpans(CenteredImageSpan(context, iconRes)) {
        addSpace()
    }
    addSpace()
}

fun SpannableStringBuilder.addUnnamedAssetName(context: Context) {
    color(ContextCompat.getColor(context, R.color.orange_E0)) {
        inSpans(CustomTypefaceSpan(ResourcesCompat.getFont(context, R.font.dmsans_medium_italic))) {
            append(context.getString(R.string.unnamed))
        }
    }
}

fun SpannableStringBuilder.addAlgorandIcon(context: Context) {
    inSpans(CenteredImageSpan(context, R.drawable.ic_algo_sign)) {
        addSpace()
    }
    addSpace()
}

fun TextView.setXmlStyledString(
    @StringRes stringResId: Int,
    @ColorRes colorResId: Int = R.color.black,
    onUrlClick: ((String) -> Unit)? = null
) {
    val xmlText = context.resources.getText(stringResId)
    if (xmlText !is SpannedString) {
        text = xmlText
        return
    }

    val spannableString = SpannableStringBuilder(xmlText)
    xmlText.getSpans(0, xmlText.length, Annotation::class.java).forEach { annotation ->
        when (annotation.key) {
            "type" -> {
                val span: CharacterStyle? = when (annotation.value) {
                    "bold" -> StyleSpan(BOLD)
                    "color" -> ForegroundColorSpan(ContextCompat.getColor(context, colorResId))
                    "underline" -> UnderlineSpan()
                    "verified-icon" -> CenteredImageSpan(context, R.drawable.ic_shield_check_small)
                    else -> null
                }
                if (span != null) {
                    // This is an empty annotation tag body check. Annotation must contain at least one character.
                    val spanStartIndex = spannableString.getSpanStart(annotation)
                    val spanEndIndex = spannableString.getSpanEnd(annotation)
                    if (spanStartIndex in 0..spannableString.length && spanEndIndex in 0..spannableString.length) {
                        spannableString.setSpan(span, spanStartIndex, spanEndIndex, SPAN_EXCLUSIVE_EXCLUSIVE)
                    } else {
                        FirebaseCrashlytics.getInstance().recordException(
                            InvalidAnnotationException(xmlText.toString(), annotation.value)
                        )
                    }
                }
            }
            "url" -> {
                setOnClickListener { onUrlClick?.invoke(annotation.value) }
            }
        }
    }
    text = spannableString
}

fun Context.getXmlStyledString(annotatedString: AnnotatedString): CharSequence {
    with(annotatedString) {
        return getXmlStyledString(stringResId, replacementList, customAnnotationList)
    }
}

fun Context.getXmlStyledString(
    @StringRes stringResId: Int,
    replacementList: List<Pair<CharSequence, CharSequence>> = emptyList(),
    customAnnotations: List<Pair<CharSequence, Any>> = emptyList()
): CharSequence {
    val xmlText = resources.getText(stringResId)
    if (xmlText !is SpannedString) {
        return xmlText
    }

    val spannableString = SpannableStringBuilder(xmlText)
    xmlText.getSpans(0, xmlText.length, Annotation::class.java).forEach { annotation ->
        when (annotation.key) {
            "type" -> {
                when (annotation.value) {
                    "bold" -> StyleSpan(BOLD)
                    "underline" -> UnderlineSpan()
                    else -> null
                }?.let { span ->
                    spannableString.applySpan(span, annotation)
                }
            }
            "font" -> {
                spannableString.applyFontAnnotation(this, annotation)
            }
            "default-font" -> {
                spannableString.applyDefaultFontAnnotation(annotation)
            }
            "replacement" -> {
                replacementList.find { (key, _) ->
                    key == annotation.value
                }?.let { (_, replacementValue) ->
                    spannableString.replaceAnnotation(annotation, replacementValue)
                }
            }
            "custom" -> {
                val customAnnotation = customAnnotations.find { it.first == annotation.value }
                if (customAnnotation != null) {
                    spannableString.applySpan(customAnnotation.second, annotation)
                }
            }
        }
    }
    return spannableString
}

private fun SpannableStringBuilder.replaceAnnotation(
    annotation: Annotation,
    replacementValue: CharSequence
) {
    replace(
        getSpanStart(annotation),
        getSpanEnd(annotation),
        replacementValue
    )
}

private fun SpannableStringBuilder.applySpan(span: Any, annotation: Annotation) {
    setSpan(span, getSpanStart(annotation), getSpanEnd(annotation), SPAN_EXCLUSIVE_EXCLUSIVE)
}

private fun SpannableStringBuilder.applyFontAnnotation(context: Context, annotation: Annotation) {
    val fontName = annotation.value
    val typeface = ResourcesCompat.getFont(
        context,
        context.resources.getIdentifier(fontName, "font", context.packageName)
    )
    if (typeface != null) {
        applySpan(CustomTypefaceSpan(typeface), annotation)
    }
}

// TODO: 12.11.2021 Till we replace the font-family with correct ones, we should this function to change strings
//  textAppearances which are annotated into strings.xml
private fun SpannableStringBuilder.applyDefaultFontAnnotation(annotation: Annotation) {
    val fontName = annotation.value
    val typeFace = Typeface.create(fontName, Typeface.NORMAL)
    if (fontName != null) {
        applySpan(CustomTypefaceSpan(typeFace), annotation)
    }
}

fun SpannableStringBuilder.setFont(fontTypeface: Typeface?) {
    if (fontTypeface != null) {
        setSpan(CustomTypefaceSpan(fontTypeface), 0, this.length, SPAN_EXCLUSIVE_EXCLUSIVE)
    }
}

fun SpannableStringBuilder.setColor(textColor: Int) {
    setSpan(ForegroundColorSpan(textColor), 0, this.length, SPAN_EXCLUSIVE_EXCLUSIVE)
}

fun SpannableStringBuilder.setTextSize(textSize: Int) {
    setSpan(AbsoluteSizeSpan(textSize), 0, this.length, SPAN_EXCLUSIVE_EXCLUSIVE)
}
