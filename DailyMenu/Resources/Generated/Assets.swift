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
  internal enum Colors {
    internal static let background = ColorAsset(name: "background")
    internal static let backgroundGray = ColorAsset(name: "background_gray")
    internal static let black = ColorAsset(name: "black")
    internal static let blue = ColorAsset(name: "blue")
    internal static let blue2 = ColorAsset(name: "blue2")
    internal static let charcoal = ColorAsset(name: "charcoal")
    internal static let commonBackground = ColorAsset(name: "common_background")
    internal static let gray = ColorAsset(name: "gray")
    internal static let lightBlue = ColorAsset(name: "light_blue")
    internal static let lightGray = ColorAsset(name: "light_gray")
    internal static let lightRed = ColorAsset(name: "light_red")
    internal static let red = ColorAsset(name: "red")
    internal static let smoke = ColorAsset(name: "smoke")
    internal static let transparent = ColorAsset(name: "transparent")
    internal static let white = ColorAsset(name: "white")
  }
  internal enum Images {
    internal enum Category {
      internal static let burger = ImageAsset(name: "Category/burger")
      internal static let hotdog = ImageAsset(name: "Category/hotdog")
      internal static let pizza = ImageAsset(name: "Category/pizza")
    }
    internal enum FilterIcons {
      internal static let burger = ImageAsset(name: "FilterIcons/burger")
      internal static let chicken = ImageAsset(name: "FilterIcons/chicken")
      internal static let deserts = ImageAsset(name: "FilterIcons/deserts")
      internal static let fries = ImageAsset(name: "FilterIcons/fries")
      internal static let hotdog = ImageAsset(name: "FilterIcons/hotdog")
      internal static let lobstar = ImageAsset(name: "FilterIcons/lobstar")
      internal static let pastry = ImageAsset(name: "FilterIcons/pastry")
      internal static let pizza = ImageAsset(name: "FilterIcons/pizza")
      internal static let sandwich = ImageAsset(name: "FilterIcons/sandwich")
      internal static let steak = ImageAsset(name: "FilterIcons/steak")
      internal static let sushi = ImageAsset(name: "FilterIcons/sushi")
      internal static let taco = ImageAsset(name: "FilterIcons/taco")
    }
    internal enum Icons {
      internal static let arrowDown = ImageAsset(name: "Icons/arrow_down")
      internal static let back = ImageAsset(name: "Icons/back")
      internal static let cancel = ImageAsset(name: "Icons/cancel")
      internal static let check = ImageAsset(name: "Icons/check")
      internal static let checkmarkChecked = ImageAsset(name: "Icons/checkmark-checked")
      internal static let checkmarkNotMarked = ImageAsset(name: "Icons/checkmark_not_marked")
      internal static let chevronDown = ImageAsset(name: "Icons/chevron_down")
      internal static let clock = ImageAsset(name: "Icons/clock")
      internal static let cross = ImageAsset(name: "Icons/cross")
      internal static let disc = ImageAsset(name: "Icons/disc")
      internal static let envelope = ImageAsset(name: "Icons/envelope")
      internal static let google = ImageAsset(name: "Icons/google")
      internal static let location = ImageAsset(name: "Icons/location")
      internal static let mapPin = ImageAsset(name: "Icons/map_pin")
      internal static let mapPin1 = ImageAsset(name: "Icons/map_pin_1")
      internal static let mapPinBlue = ImageAsset(name: "Icons/map_pin_blue")
      internal static let menu = ImageAsset(name: "Icons/menu")
      internal static let menu2 = ImageAsset(name: "Icons/menu_2")
      internal static let notification = ImageAsset(name: "Icons/notification")
      internal static let notificationWhite = ImageAsset(name: "Icons/notification_white")
      internal static let password = ImageAsset(name: "Icons/password")
      internal static let pinShadow = ImageAsset(name: "Icons/pin_shadow")
      internal static let refresh = ImageAsset(name: "Icons/refresh")
      internal static let search = ImageAsset(name: "Icons/search")
      internal static let starFull = ImageAsset(name: "Icons/star_full")
      internal static let starHalf = ImageAsset(name: "Icons/star_half")
      internal static let thumb = ImageAsset(name: "Icons/thumb")
    }
    internal enum Placeholders {
      internal static let cash = ImageAsset(name: "Placeholders/cash")
      internal static let creditCard = ImageAsset(name: "Placeholders/credit_card")
      internal static let creditCardSecond = ImageAsset(name: "Placeholders/credit_card_second")
      internal static let orderDelivered = ImageAsset(name: "Placeholders/order-delivered")
      internal static let orderPlaced = ImageAsset(name: "Placeholders/order_placed")
      internal static let phoneVerified = ImageAsset(name: "Placeholders/phone-verified")
    }
    internal static let foodItemPlaceholder = ImageAsset(name: "food_item_placeholder")
    internal static let itemImagePlaceholder = ImageAsset(name: "item_image_placeholder")
    internal static let ratePlaceholder = ImageAsset(name: "rate_placeholder")
    internal static let restaurantLogoPlaceholder = ImageAsset(name: "restaurant_logo_placeholder")
    internal static let restaurentImagePlaceholder = ImageAsset(name: "restaurent_image_placeholder")
    internal static let spinner = ImageAsset(name: "spinner")
    internal static let tabCartActive = ImageAsset(name: "tab_cart_active")
    internal static let tabCartInactive = ImageAsset(name: "tab_cart_inactive")
    internal static let tabExploreActive = ImageAsset(name: "tab_explore-active")
    internal static let tabExploreInactive = ImageAsset(name: "tab_explore-inactive")
    internal static let tabSettingsActive = ImageAsset(name: "tab_settings_active")
    internal static let tabSettingsInactive = ImageAsset(name: "tab_settings_inactive")
  }
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
