//
// FontManager.swift
//
// Created by Ben for PracticeUI on 2021/3/17.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit

extension UIFontDescriptor {
    private enum FontFamily {
        static var preferredFontNameRegular: String = "Montserrat-Regular"
        static var preferredFontNameBold: String = "Montserrat-Bold"
    }

    static let fontSizeTable: [UIFont.TextStyle: [UIContentSizeCategory: CGFloat]] = [
        .headline: [
            .accessibilityExtraExtraExtraLarge: 38,
            .accessibilityExtraExtraLarge: 35,
            .accessibilityExtraLarge: 33,
            .accessibilityLarge: 30,
            .accessibilityMedium: 29,
            .extraExtraExtraLarge: 27,
            .extraExtraLarge: 21,
            .extraLarge: 19,
            .large: 17,
            .medium: 16,
            .small: 15,
            .extraSmall: 14,
        ],
    ]

    final class func preferredDescriptor(textStyle: UIFont.TextStyle, styleBold: Bool = false) -> UIFontDescriptor {
        let contentSize = UIApplication.shared.preferredContentSizeCategory

        let fontFamily = styleBold ? FontFamily.preferredFontNameBold : FontFamily.preferredFontNameRegular

        guard let style = fontSizeTable[textStyle], let size = style[contentSize] else {
            return UIFontDescriptor(name: fontFamily, size: 16)
        }
        return UIFontDescriptor(name: fontFamily, size: size)
    }
}
