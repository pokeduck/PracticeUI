//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `line_main`.
    static let line_main = Rswift.ColorResource(bundle: R.hostingBundle, name: "line_main")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "line_main", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func line_main(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.line_main, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "line_main", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func line_main(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.line_main.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 15 files.
  struct file {
    /// Resource file `launch.PNG`.
    static let launchPNG = Rswift.FileResource(bundle: R.hostingBundle, name: "launch", pathExtension: "PNG")
    /// Resource file `passcode.PNG`.
    static let passcodePNG = Rswift.FileResource(bundle: R.hostingBundle, name: "passcode", pathExtension: "PNG")
    /// Resource file `passcode_button_press.PNG`.
    static let passcode_button_pressPNG = Rswift.FileResource(bundle: R.hostingBundle, name: "passcode_button_press", pathExtension: "PNG")
    /// Resource file `passcude_input.jpeg`.
    static let passcude_inputJpeg = Rswift.FileResource(bundle: R.hostingBundle, name: "passcude_input", pathExtension: "jpeg")
    /// Resource file `step1.PNG`.
    static let step1PNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step1", pathExtension: "PNG")
    /// Resource file `step2.PNG`.
    static let step2PNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step2", pathExtension: "PNG")
    /// Resource file `step2_tips.PNG`.
    static let step2_tipsPNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step2_tips", pathExtension: "PNG")
    /// Resource file `step2_wrong.PNG`.
    static let step2_wrongPNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step2_wrong", pathExtension: "PNG")
    /// Resource file `step2_wrong2.PNG`.
    static let step2_wrong2PNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step2_wrong2", pathExtension: "PNG")
    /// Resource file `step3.PNG`.
    static let step3PNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step3", pathExtension: "PNG")
    /// Resource file `step3_last.PNG`.
    static let step3_lastPNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step3_last", pathExtension: "PNG")
    /// Resource file `step3_success.PNG`.
    static let step3_successPNG = Rswift.FileResource(bundle: R.hostingBundle, name: "step3_success", pathExtension: "PNG")
    /// Resource file `turn_on_touchid.PNG`.
    static let turn_on_touchidPNG = Rswift.FileResource(bundle: R.hostingBundle, name: "turn_on_touchid", pathExtension: "PNG")
    /// Resource file `turn_on_touchid_step1.PNG`.
    static let turn_on_touchid_step1PNG = Rswift.FileResource(bundle: R.hostingBundle, name: "turn_on_touchid_step1", pathExtension: "PNG")
    /// Resource file `turn_on_touchid_step2.PNG`.
    static let turn_on_touchid_step2PNG = Rswift.FileResource(bundle: R.hostingBundle, name: "turn_on_touchid_step2", pathExtension: "PNG")

    /// `bundle.url(forResource: "launch", withExtension: "PNG")`
    static func launchPNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.launchPNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "passcode", withExtension: "PNG")`
    static func passcodePNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.passcodePNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "passcode_button_press", withExtension: "PNG")`
    static func passcode_button_pressPNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.passcode_button_pressPNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "passcude_input", withExtension: "jpeg")`
    static func passcude_inputJpeg(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.passcude_inputJpeg
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step1", withExtension: "PNG")`
    static func step1PNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step1PNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step2", withExtension: "PNG")`
    static func step2PNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step2PNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step2_tips", withExtension: "PNG")`
    static func step2_tipsPNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step2_tipsPNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step2_wrong", withExtension: "PNG")`
    static func step2_wrongPNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step2_wrongPNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step2_wrong2", withExtension: "PNG")`
    static func step2_wrong2PNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step2_wrong2PNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step3", withExtension: "PNG")`
    static func step3PNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step3PNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step3_last", withExtension: "PNG")`
    static func step3_lastPNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step3_lastPNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "step3_success", withExtension: "PNG")`
    static func step3_successPNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.step3_successPNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "turn_on_touchid", withExtension: "PNG")`
    static func turn_on_touchidPNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.turn_on_touchidPNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "turn_on_touchid_step1", withExtension: "PNG")`
    static func turn_on_touchid_step1PNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.turn_on_touchid_step1PNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "turn_on_touchid_step2", withExtension: "PNG")`
    static func turn_on_touchid_step2PNG(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.turn_on_touchid_step2PNG
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 38 images.
  struct image {
    /// Image `cardboard_1`.
    static let cardboard_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "cardboard_1")
    /// Image `cardboard`.
    static let cardboard = Rswift.ImageResource(bundle: R.hostingBundle, name: "cardboard")
    /// Image `favor_1`.
    static let favor_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "favor_1")
    /// Image `favor`.
    static let favor = Rswift.ImageResource(bundle: R.hostingBundle, name: "favor")
    /// Image `find_1`.
    static let find_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "find_1")
    /// Image `find`.
    static let find = Rswift.ImageResource(bundle: R.hostingBundle, name: "find")
    /// Image `home_1`.
    static let home_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "home_1")
    /// Image `home`.
    static let home = Rswift.ImageResource(bundle: R.hostingBundle, name: "home")
    /// Image `icon`.
    static let icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon")
    /// Image `launch.PNG`.
    static let launchPNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "launch.PNG")
    /// Image `me_1`.
    static let me_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "me_1")
    /// Image `me`.
    static let me = Rswift.ImageResource(bundle: R.hostingBundle, name: "me")
    /// Image `message_1`.
    static let message_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "message_1")
    /// Image `message`.
    static let message = Rswift.ImageResource(bundle: R.hostingBundle, name: "message")
    /// Image `more_1`.
    static let more_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "more_1")
    /// Image `more`.
    static let more = Rswift.ImageResource(bundle: R.hostingBundle, name: "more")
    /// Image `passcode.PNG`.
    static let passcodePNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "passcode.PNG")
    /// Image `passcode_button_press.PNG`.
    static let passcode_button_pressPNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "passcode_button_press.PNG")
    /// Image `passcude_input.jpeg`.
    static let passcude_inputJpeg = Rswift.ImageResource(bundle: R.hostingBundle, name: "passcude_input.jpeg")
    /// Image `photo_1`.
    static let photo_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "photo_1")
    /// Image `photo_big-1`.
    static let photo_big1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "photo_big-1")
    /// Image `photo_big`.
    static let photo_big = Rswift.ImageResource(bundle: R.hostingBundle, name: "photo_big")
    /// Image `photo_verybig_1`.
    static let photo_verybig_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "photo_verybig_1")
    /// Image `photo_verybig`.
    static let photo_verybig = Rswift.ImageResource(bundle: R.hostingBundle, name: "photo_verybig")
    /// Image `photo`.
    static let photo = Rswift.ImageResource(bundle: R.hostingBundle, name: "photo")
    /// Image `shop_1`.
    static let shop_1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "shop_1")
    /// Image `shop`.
    static let shop = Rswift.ImageResource(bundle: R.hostingBundle, name: "shop")
    /// Image `step1.PNG`.
    static let step1PNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step1.PNG")
    /// Image `step2.PNG`.
    static let step2PNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step2.PNG")
    /// Image `step2_tips.PNG`.
    static let step2_tipsPNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step2_tips.PNG")
    /// Image `step2_wrong.PNG`.
    static let step2_wrongPNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step2_wrong.PNG")
    /// Image `step2_wrong2.PNG`.
    static let step2_wrong2PNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step2_wrong2.PNG")
    /// Image `step3.PNG`.
    static let step3PNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step3.PNG")
    /// Image `step3_last.PNG`.
    static let step3_lastPNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step3_last.PNG")
    /// Image `step3_success.PNG`.
    static let step3_successPNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "step3_success.PNG")
    /// Image `turn_on_touchid.PNG`.
    static let turn_on_touchidPNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "turn_on_touchid.PNG")
    /// Image `turn_on_touchid_step1.PNG`.
    static let turn_on_touchid_step1PNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "turn_on_touchid_step1.PNG")
    /// Image `turn_on_touchid_step2.PNG`.
    static let turn_on_touchid_step2PNG = Rswift.ImageResource(bundle: R.hostingBundle, name: "turn_on_touchid_step2.PNG")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "cardboard", bundle: ..., traitCollection: ...)`
    static func cardboard(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cardboard, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "cardboard_1", bundle: ..., traitCollection: ...)`
    static func cardboard_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cardboard_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "favor", bundle: ..., traitCollection: ...)`
    static func favor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.favor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "favor_1", bundle: ..., traitCollection: ...)`
    static func favor_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.favor_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "find", bundle: ..., traitCollection: ...)`
    static func find(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.find, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "find_1", bundle: ..., traitCollection: ...)`
    static func find_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.find_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "home", bundle: ..., traitCollection: ...)`
    static func home(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "home_1", bundle: ..., traitCollection: ...)`
    static func home_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icon", bundle: ..., traitCollection: ...)`
    static func icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "launch.PNG", bundle: ..., traitCollection: ...)`
    static func launchPNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.launchPNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "me", bundle: ..., traitCollection: ...)`
    static func me(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.me, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "me_1", bundle: ..., traitCollection: ...)`
    static func me_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.me_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "message", bundle: ..., traitCollection: ...)`
    static func message(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.message, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "message_1", bundle: ..., traitCollection: ...)`
    static func message_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.message_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "more", bundle: ..., traitCollection: ...)`
    static func more(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.more, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "more_1", bundle: ..., traitCollection: ...)`
    static func more_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.more_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "passcode.PNG", bundle: ..., traitCollection: ...)`
    static func passcodePNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.passcodePNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "passcode_button_press.PNG", bundle: ..., traitCollection: ...)`
    static func passcode_button_pressPNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.passcode_button_pressPNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "passcude_input.jpeg", bundle: ..., traitCollection: ...)`
    static func passcude_inputJpeg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.passcude_inputJpeg, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "photo", bundle: ..., traitCollection: ...)`
    static func photo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "photo_1", bundle: ..., traitCollection: ...)`
    static func photo_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photo_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "photo_big", bundle: ..., traitCollection: ...)`
    static func photo_big(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photo_big, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "photo_big-1", bundle: ..., traitCollection: ...)`
    static func photo_big1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photo_big1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "photo_verybig", bundle: ..., traitCollection: ...)`
    static func photo_verybig(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photo_verybig, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "photo_verybig_1", bundle: ..., traitCollection: ...)`
    static func photo_verybig_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photo_verybig_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "shop", bundle: ..., traitCollection: ...)`
    static func shop(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.shop, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "shop_1", bundle: ..., traitCollection: ...)`
    static func shop_1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.shop_1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step1.PNG", bundle: ..., traitCollection: ...)`
    static func step1PNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step1PNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step2.PNG", bundle: ..., traitCollection: ...)`
    static func step2PNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step2PNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step2_tips.PNG", bundle: ..., traitCollection: ...)`
    static func step2_tipsPNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step2_tipsPNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step2_wrong.PNG", bundle: ..., traitCollection: ...)`
    static func step2_wrongPNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step2_wrongPNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step2_wrong2.PNG", bundle: ..., traitCollection: ...)`
    static func step2_wrong2PNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step2_wrong2PNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step3.PNG", bundle: ..., traitCollection: ...)`
    static func step3PNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step3PNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step3_last.PNG", bundle: ..., traitCollection: ...)`
    static func step3_lastPNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step3_lastPNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "step3_success.PNG", bundle: ..., traitCollection: ...)`
    static func step3_successPNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.step3_successPNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "turn_on_touchid.PNG", bundle: ..., traitCollection: ...)`
    static func turn_on_touchidPNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.turn_on_touchidPNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "turn_on_touchid_step1.PNG", bundle: ..., traitCollection: ...)`
    static func turn_on_touchid_step1PNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.turn_on_touchid_step1PNG, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "turn_on_touchid_step2.PNG", bundle: ..., traitCollection: ...)`
    static func turn_on_touchid_step2PNG(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.turn_on_touchid_step2PNG, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `PasscodeNumericPadView`.
    static let passcodeNumericPadView = _R.nib._PasscodeNumericPadView()
    /// Nib `TestDelegateTabController`.
    static let testDelegateTabController = _R.nib._TestDelegateTabController()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "PasscodeNumericPadView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.passcodeNumericPadView) instead")
    static func passcodeNumericPadView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.passcodeNumericPadView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TestDelegateTabController", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.testDelegateTabController) instead")
    static func testDelegateTabController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.testDelegateTabController)
    }
    #endif

    static func passcodeNumericPadView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> PasscodeNumericPadView? {
      return R.nib.passcodeNumericPadView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? PasscodeNumericPadView
    }

    static func testDelegateTabController(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TestDelegateTabController? {
      return R.nib.testDelegateTabController.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TestDelegateTabController
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 4 localization keys.
    struct localizable {
      /// en translation: Hello
      ///
      /// Locales: en, zh-Hant, fr, ko, ja, de, fr-CA, es
      static let hello = Rswift.StringResource(key: "hello", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hant", "fr", "ko", "ja", "de", "fr-CA", "es"], comment: nil)
      /// en translation: Setting
      ///
      /// Locales: en, zh-Hant, ko, ja, de, fr-CA, es
      static let setting = Rswift.StringResource(key: "setting", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hant", "ko", "ja", "de", "fr-CA", "es"], comment: nil)
      /// en translation: Share
      ///
      /// Locales: en, zh-Hant, fr, ko, ja, de, fr-CA, es
      static let share = Rswift.StringResource(key: "share", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hant", "fr", "ko", "ja", "de", "fr-CA", "es"], comment: nil)
      /// en translation: back en 
      ///
      /// Locales: en, zh-Hant, fr, ko, ja, de, fr-CA, es
      static let back = Rswift.StringResource(key: "back", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "zh-Hant", "fr", "ko", "ja", "de", "fr-CA", "es"], comment: nil)

      /// en translation: Hello
      ///
      /// Locales: en, zh-Hant, fr, ko, ja, de, fr-CA, es
      static func hello(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("hello", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "hello"
        }

        return NSLocalizedString("hello", bundle: bundle, comment: "")
      }

      /// en translation: Setting
      ///
      /// Locales: en, zh-Hant, ko, ja, de, fr-CA, es
      static func setting(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("setting", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "setting"
        }

        return NSLocalizedString("setting", bundle: bundle, comment: "")
      }

      /// en translation: Share
      ///
      /// Locales: en, zh-Hant, fr, ko, ja, de, fr-CA, es
      static func share(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("share", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "share"
        }

        return NSLocalizedString("share", bundle: bundle, comment: "")
      }

      /// en translation: back en 
      ///
      /// Locales: en, zh-Hant, fr, ko, ja, de, fr-CA, es
      static func back(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("back", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "back"
        }

        return NSLocalizedString("back", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib {
    struct _PasscodeNumericPadView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "PasscodeNumericPadView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> PasscodeNumericPadView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? PasscodeNumericPadView
      }

      fileprivate init() {}
    }

    struct _TestDelegateTabController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TestDelegateTabController"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TestDelegateTabController? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TestDelegateTabController
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainTabBarController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
