// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Avenir {
    internal static let black = FontConvertible(name: "Avenir-Black", family: "Avenir", path: "Avenir-Black.ttf")
    internal static let book = FontConvertible(name: "Avenir-Book", family: "Avenir", path: "Avenir-Book.ttf")
    internal static let heavy = FontConvertible(name: "Avenir-Heavy", family: "Avenir", path: "Avenir-Heavy.ttf")
    internal static let light = FontConvertible(name: "Avenir-Light", family: "Avenir", path: "Avenir-Light.ttf")
    internal static let medium = FontConvertible(name: "Avenir-Medium", family: "Avenir", path: "Avenir-Medium.ttf")
    internal static let all: [FontConvertible] = [black, book, heavy, light, medium]
  }
  internal static let allCustomFonts: [FontConvertible] = [Avenir.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
