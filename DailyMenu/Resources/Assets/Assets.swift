// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let iconBack = ImageAsset(name: "icon_Back")
  internal static let iconArrowDown = ImageAsset(name: "icon_arrow_down")
  internal static let iconCheck = ImageAsset(name: "icon_check")
  internal static let iconCheckmarkChecked = ImageAsset(name: "icon_checkmark_checked")
  internal static let iconCheckmarkNotMarked = ImageAsset(name: "icon_checkmark_not_marked")
  internal static let iconChevronDown = ImageAsset(name: "icon_chevron_down")
  internal static let iconClock = ImageAsset(name: "icon_clock")
  internal static let iconCross = ImageAsset(name: "icon_cross")
  internal static let iconDisc1 = ImageAsset(name: "icon_disc-1")
  internal static let iconDisc = ImageAsset(name: "icon_disc")
  internal static let iconGoogle = ImageAsset(name: "icon_google")
  internal static let iconMapPin = ImageAsset(name: "icon_map_pin")
  internal static let iconMapPin1 = ImageAsset(name: "icon_map_pin_1")
  internal static let iconMenu = ImageAsset(name: "icon_menu")
  internal static let iconMenu2 = ImageAsset(name: "icon_menu_2")
  internal static let iconNotification = ImageAsset(name: "icon_notification")
  internal static let iconNotificationWhite = ImageAsset(name: "icon_notification_white")
  internal static let iconRefresh = ImageAsset(name: "icon_refresh")
  internal static let iconSearch = ImageAsset(name: "icon_search")
  internal static let iconStarFull = ImageAsset(name: "icon_star_full")
  internal static let iconStarHalf = ImageAsset(name: "icon_star_half")
  internal static let tabCartActive = ImageAsset(name: "tab_cart_active")
  internal static let tabCartInactive = ImageAsset(name: "tab_cart_inactive")
  internal static let tabExploreActive = ImageAsset(name: "tab_explore-active")
  internal static let tabExploreInactive = ImageAsset(name: "tab_explore-inactive")
  internal static let tabSettingsActive = ImageAsset(name: "tab_settings_active")
  internal static let tabSettingsInactive = ImageAsset(name: "tab_settings_inactive")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
