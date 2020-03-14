// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Cart {
    /// Apply
    internal static let apply = L10n.tr("Localizable", "cart.apply")
    /// Cart is empty
    internal static let cartIsEmpty = L10n.tr("Localizable", "cart.cart_is_empty")
    /// Cart total
    internal static let cartTotal = L10n.tr("Localizable", "cart.cart_total")
    /// Delivery
    internal static let delivery = L10n.tr("Localizable", "cart.delivery")
    /// Proceed to Checkout
    internal static let proceedToCheckout = L10n.tr("Localizable", "cart.proceed_to_checkout")
    /// Promo Code
    internal static let promo = L10n.tr("Localizable", "cart.promo")
    /// Promo discaunt
    internal static let promoDiscaunt = L10n.tr("Localizable", "cart.promo_discaunt")
    /// Sign In to proceed
    internal static let singInToProceed = L10n.tr("Localizable", "cart.sing_in_to_proceed")
    /// Subtotal
    internal static let subtotal = L10n.tr("Localizable", "cart.subtotal")
    /// Your Food Cart
    internal static let yourCart = L10n.tr("Localizable", "cart.your_cart")
  }

  internal enum Categories {
    /// Burger
    internal static let burger = L10n.tr("Localizable", "categories.burger")
    /// Chicken
    internal static let chicken = L10n.tr("Localizable", "categories.chicken")
    /// Desert
    internal static let desert = L10n.tr("Localizable", "categories.desert")
    /// Fries
    internal static let fries = L10n.tr("Localizable", "categories.fries")
    /// Hotdog
    internal static let hotdog = L10n.tr("Localizable", "categories.hotdog")
    /// Lobstar
    internal static let lobstar = L10n.tr("Localizable", "categories.lobstar")
    /// Pasta
    internal static let pasta = L10n.tr("Localizable", "categories.pasta")
    /// Pizza
    internal static let pizza = L10n.tr("Localizable", "categories.pizza")
    /// Sandwich
    internal static let sandwich = L10n.tr("Localizable", "categories.sandwich")
    /// Shaurma
    internal static let shaurma = L10n.tr("Localizable", "categories.shaurma")
    /// Steak
    internal static let steak = L10n.tr("Localizable", "categories.steak")
    /// Sushi
    internal static let sushi = L10n.tr("Localizable", "categories.sushi")
    /// Taco
    internal static let taco = L10n.tr("Localizable", "categories.taco")
    /// Unknown
    internal static let unknown = L10n.tr("Localizable", "categories.unknown")
    internal enum Compatible {
      /// Burgers
      internal static let burger = L10n.tr("Localizable", "categories.compatible.burger")
      /// Chicken
      internal static let chicken = L10n.tr("Localizable", "categories.compatible.chicken")
      /// Desserts
      internal static let desert = L10n.tr("Localizable", "categories.compatible.desert")
      /// Fries
      internal static let fries = L10n.tr("Localizable", "categories.compatible.fries")
      /// Hot Dogs
      internal static let hotdog = L10n.tr("Localizable", "categories.compatible.hotdog")
      /// Lobstar
      internal static let lobstar = L10n.tr("Localizable", "categories.compatible.lobstar")
      /// Pasta
      internal static let pasta = L10n.tr("Localizable", "categories.compatible.pasta")
      /// Pizza
      internal static let pizza = L10n.tr("Localizable", "categories.compatible.pizza")
      /// Sandwich
      internal static let sandwich = L10n.tr("Localizable", "categories.compatible.sandwich")
      /// Shaurma
      internal static let shaurma = L10n.tr("Localizable", "categories.compatible.shaurma")
      /// Steak
      internal static let steak = L10n.tr("Localizable", "categories.compatible.steak")
      /// Sushi
      internal static let sushi = L10n.tr("Localizable", "categories.compatible.sushi")
      /// Taco
      internal static let taco = L10n.tr("Localizable", "categories.compatible.taco")
      /// Unknown
      internal static let unknown = L10n.tr("Localizable", "categories.compatible.unknown")
    }
  }

  internal enum Common {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "common.cancel")
    /// Confirm
    internal static let confirm = L10n.tr("Localizable", "common.confirm")
    /// BYN
    internal static let currency = L10n.tr("Localizable", "common.currency")
    /// km
    internal static let km = L10n.tr("Localizable", "common.km")
  }

  internal enum DeliveryLocation {
    /// Address confirmation
    internal static let addressConfirmation = L10n.tr("Localizable", "delivery_location.address_confirmation")
    /// Apt. no (optional)
    internal static let apartments = L10n.tr("Localizable", "delivery_location.apartments")
    /// Delivery location
    internal static let deliveryLocation = L10n.tr("Localizable", "delivery_location.delivery_location")
    /// Do you want to choose %@ as your delivery address, please confirm if it's correct, and start choosing your meal.
    internal static func doYouWantToChooseAddress(_ p1: String) -> String {
      return L10n.tr("Localizable", "delivery_location.do_you_want_to_choose_address", p1)
    }
    /// Floor no (optional)
    internal static let floor = L10n.tr("Localizable", "delivery_location.floor")
    /// Type delivery location
    internal static let typeDeliveryLocation = L10n.tr("Localizable", "delivery_location.type_delivery_location")
  }

  internal enum Greeting {
    /// Don't have an account?
    internal static let dontHaveAccount = L10n.tr("Localizable", "greeting.dont_have_account")
    /// E-mail
    internal static let email = L10n.tr("Localizable", "greeting.email")
    /// Incorrect email or password
    internal static let incorrectCredentials = L10n.tr("Localizable", "greeting.incorrect_credentials")
    /// Sign in
    internal static let login = L10n.tr("Localizable", "greeting.login")
    /// Password
    internal static let password = L10n.tr("Localizable", "greeting.password")
    /// Sign up
    internal static let signup = L10n.tr("Localizable", "greeting.signup")
    /// Skip
    internal static let skip = L10n.tr("Localizable", "greeting.skip")
  }

  internal enum OrderCheckout {
    /// Cash
    internal static let cash = L10n.tr("Localizable", "order_checkout.cash")
    /// Checkout
    internal static let checkout = L10n.tr("Localizable", "order_checkout.checkout")
    /// Credit/Debt card
    internal static let creditCard = L10n.tr("Localizable", "order_checkout.credit_card")
    /// Credit card on delivery
    internal static let creditCardOnDelviery = L10n.tr("Localizable", "order_checkout.credit_card_on_delviery")
    /// Delivery time
    internal static let deliveryTime = L10n.tr("Localizable", "order_checkout.delivery_time")
    /// %d minutes
    internal static func minutes(_ p1: Int) -> String {
      return L10n.tr("Localizable", "order_checkout.minutes", p1)
    }
    /// Payment method
    internal static let paymentMethod = L10n.tr("Localizable", "order_checkout.payment_method")
    /// Submit Order
    internal static let submitOrder = L10n.tr("Localizable", "order_checkout.submit_order")
    /// You
    internal static let you = L10n.tr("Localizable", "order_checkout.you")
  }

  internal enum OrderPlaced {
    /// Order placed
    internal static let orderPlacedTitle = L10n.tr("Localizable", "order_placed.order_placed_title")
    /// View order status
    internal static let viewOrderStatus = L10n.tr("Localizable", "order_placed.view_order_status")
    /// Wait for courier in %d minutes
    internal static func waitForCourier(_ p1: Int) -> String {
      return L10n.tr("Localizable", "order_placed.wait_for_courier", p1)
    }
    /// Your Food order have been placed
    internal static let yourOrderPlaced = L10n.tr("Localizable", "order_placed.your_order_placed")
  }

  internal enum OrderStatus {
    /// Delivered to you
    internal static let deliveredToYou = L10n.tr("Localizable", "order_status.delivered_to_you")
    /// Food on the way
    internal static let foodOnTheWay = L10n.tr("Localizable", "order_status.food_on_the_way")
    /// No orders found
    internal static let noOrdersFound = L10n.tr("Localizable", "order_status.no_orders_found")
    /// Order confirmed
    internal static let orderConfirmed = L10n.tr("Localizable", "order_status.order_confirmed")
    /// Order status
    internal static let orderStatus = L10n.tr("Localizable", "order_status.order_status")
    /// Preparing food
    internal static let preparingFood = L10n.tr("Localizable", "order_status.preparing_food")
    /// Your order ID
    internal static let yourOrderId = L10n.tr("Localizable", "order_status.your_order_id")
  }

  internal enum PhoneVerification {
    /// A verification code is sent to your number provided %@
    internal static func codeIsSentToNumber(_ p1: String) -> String {
      return L10n.tr("Localizable", "phone_verification.code_is_sent_to_number", p1)
    }
    /// Don’t get the code?
    internal static let dontGetTheCode = L10n.tr("Localizable", "phone_verification.dont_get_the_code")
    /// Enter validation code
    internal static let enterCode = L10n.tr("Localizable", "phone_verification.enter_code")
    /// Enter verification code
    internal static let enterCodeTitle = L10n.tr("Localizable", "phone_verification.enter_code_title")
    /// Explore restaurants
    internal static let explore = L10n.tr("Localizable", "phone_verification.explore")
    /// Your phone number is verified!
    internal static let phoneVerified = L10n.tr("Localizable", "phone_verification.phone_verified")
    /// Your phone number is verified, you can start choosing your meal
    internal static let phoneVerifiedSubtitle = L10n.tr("Localizable", "phone_verification.phone_verified_subtitle")
  }

  internal enum Product {
    /// Add to Cart
    internal static let addToCart = L10n.tr("Localizable", "product.add_to_cart")
    /// Restaurants conflict
    internal static let restaurantsConflict = L10n.tr("Localizable", "product.restaurants_conflict")
    /// You trying to add food from another restaurant, all your cart items will be removed after add this one
    internal static let restaurantsConflictMessage = L10n.tr("Localizable", "product.restaurants_conflict_message")
    /// Total
    internal static let total = L10n.tr("Localizable", "product.total")
  }

  internal enum RestaurantInfo {
    /// Closed
    internal static let closed = L10n.tr("Localizable", "restaurant_info.closed")
    /// Delivery Fee
    internal static let deliveryFee = L10n.tr("Localizable", "restaurant_info.delivery_fee")
    /// %@ away
    internal static func kmAway(_ p1: String) -> String {
      return L10n.tr("Localizable", "restaurant_info.km_away", p1)
    }
    /// Min order
    internal static let minOrder = L10n.tr("Localizable", "restaurant_info.min_order")
    /// %d minutes delivery time
    internal static func minutesDeliveryTime(_ p1: Int) -> String {
      return L10n.tr("Localizable", "restaurant_info.minutes_delivery_time", p1)
    }
    /// Open
    internal static let `open` = L10n.tr("Localizable", "restaurant_info.open")
  }

  internal enum Restaurants {
    /// Hello, %@. 
    internal static func hello(_ p1: String) -> String {
      return L10n.tr("Localizable", "restaurants.hello", p1)
    }
    /// Search Restaurant
    internal static let search = L10n.tr("Localizable", "restaurants.search")
    /// What would you like to eat?
    internal static let whatWouldYouLikeToEat = L10n.tr("Localizable", "restaurants.what_would_you_like_to_eat")
  }

  internal enum RestaurantsMap {
    /// Filter
    internal static let filter = L10n.tr("Localizable", "restaurants_map.filter")
    /// Filter Applied
    internal static let filterApplied = L10n.tr("Localizable", "restaurants_map.filter_applied")
    /// Food type
    internal static let foodType = L10n.tr("Localizable", "restaurants_map.food_type")
    /// Nearby restaurants
    internal static let nerbyRestaurants = L10n.tr("Localizable", "restaurants_map.nerby_restaurants")
    /// No restaurants found
    internal static let noRestFound = L10n.tr("Localizable", "restaurants_map.no_rest_found")
    /// Price range
    internal static let priceRange = L10n.tr("Localizable", "restaurants_map.price_range")
    /// Radius
    internal static let radius = L10n.tr("Localizable", "restaurants_map.radius")
    /// Rating
    internal static let rating = L10n.tr("Localizable", "restaurants_map.rating")
    /// Search
    internal static let search = L10n.tr("Localizable", "restaurants_map.search")
    /// Type restaurant name
    internal static let typeRestName = L10n.tr("Localizable", "restaurants_map.type_rest_name")
  }

  internal enum Settings {
    /// Add
    internal static let add = L10n.tr("Localizable", "settings.add")
    /// Address
    internal static let address = L10n.tr("Localizable", "settings.address")
    /// Build
    internal static let build = L10n.tr("Localizable", "settings.build")
    /// Change
    internal static let change = L10n.tr("Localizable", "settings.change")
    /// Credit Card
    internal static let creditCard = L10n.tr("Localizable", "settings.credit_card")
    /// Name
    internal static let name = L10n.tr("Localizable", "settings.name")
    /// Phone
    internal static let phone = L10n.tr("Localizable", "settings.phone")
    /// Sign in
    internal static let signIn = L10n.tr("Localizable", "settings.sign_in")
    /// Sign out
    internal static let signOut = L10n.tr("Localizable", "settings.sign_out")
    /// Version
    internal static let version = L10n.tr("Localizable", "settings.version")
  }

  internal enum Signup {
    /// Account with email %@ is already exists
    internal static func accountExists(_ p1: String) -> String {
      return L10n.tr("Localizable", "signup.account_exists", p1)
    }
    /// Create your account
    internal static let createAccount = L10n.tr("Localizable", "signup.create_account")
    /// Error, please try again
    internal static let error = L10n.tr("Localizable", "signup.error")
    /// Invalid email format
    internal static let invalidEmailFormat = L10n.tr("Localizable", "signup.invalid_email_format")
    /// Invalid phone format
    internal static let invalidPhoneFormat = L10n.tr("Localizable", "signup.invalid_phone_format")
    /// Password minimum length should be at least 6
    internal static let passwordMinimumLengthError = L10n.tr("Localizable", "signup.password_minimum_length_error")
    /// Sign up
    internal static let signup = L10n.tr("Localizable", "signup.signup")
    /// We will send a code to your number. Standard data charge may apply
    internal static let willSendCode = L10n.tr("Localizable", "signup.will_send_code")
  }

  internal enum Tabbar {
    /// Cart
    internal static let cart = L10n.tr("Localizable", "tabbar.cart")
    /// Explore
    internal static let explore = L10n.tr("Localizable", "tabbar.explore")
    /// Settings
    internal static let settings = L10n.tr("Localizable", "tabbar.settings")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
