//
//  Created by Vladimir on 2/3/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Networking

class OrderRouteViewController: UIViewController {
	
	typealias Item = RestaurantData
	
	private let item: Item
	
	private let context = AppDelegate.shared.context
	
	private let mapController = MapViewController(viewModel: MapViewModelImplementation(shouldShowPin: false, onRegionDidChange: nil))
	
	private lazy var orderDetailsView: OrderRouteDetailsView = {
		let userName = context?.userDefaultsService.getValueForKey(key: .name) as? String ?? Localizable.OrderCheckout.you
		let view = OrderRouteDetailsView(
			item: OrderRouteDetailsView.Item(
				restImageSrc: item.src,
				restTitle: item.chainLabel,
				restAddress: "", // Will be fetched from geocoder
				userImage: Images.Placeholders.home.image,
				userName: userName.isEmpty ? Localizable.OrderCheckout.you : userName,
				userAddress: context?.userDefaultsService.getValueForKey(key: .addressName) as? String ?? ""
			)
		)
		return view
	}()
	
	private lazy var deliveryTimeValueLabel: UIView = {
		let label = UILabel.makeText(Localizable.OrderCheckout.minutes(item.orderDelayFirst))
		label.font = FontFamily.Avenir.medium.font(size: 8)
		return label
	}()
	
	private lazy var deliveryTimeLabel: UIView = {
		let label = UILabel.makeText(Localizable.OrderCheckout.deliveryTime)
		label.font = FontFamily.Avenir.book.font(size: 6)
		label.textColor = Colors.blue.color
		return label
	}()
	
	private lazy var deliveryTimeView: UIView = {
		let view = UIView()
		view.setRoundCorners(Layout.cornerRadius)
		view.backgroundColor = Colors.commonBackground.color
		view.addSubviews([deliveryTimeLabel, deliveryTimeValueLabel])
		deliveryTimeValueLabel.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview().inset(5)
		}
		deliveryTimeLabel.snp.makeConstraints {
			$0.top.equalTo(deliveryTimeValueLabel.snp.bottom)
			$0.leading.trailing.bottom.equalToSuperview().inset(5)
		}
		return view
	}()
	
	init(item: Item) {
		self.item = item

		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.isUserInteractionEnabled = false
		
		let cardView = CardView(shadowSize: .medium, customInsets: UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10))
		view.addSubview(cardView)
		cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
		
		addChild(mapController)
		cardView.contentView.addSubview(mapController.view)
		mapController.view.setRoundCorners(Layout.cornerRadius)
		mapController.mapView.clipsToBounds = true
		mapController.mapView.showsUserLocation = false
		mapController.view.alpha = 0
		mapController.view.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
		}
		
		mapController.addRestaurants([item])
		mapController.showUserAddressAnnotation()
		mapController.showRoute(restaurant: item, completion: {
			UIView.animate(withDuration: 0.3) { [weak self] in
				self?.mapController.view.alpha = 1
			}
		})
		mapController.view.addSubview(deliveryTimeView)
		deliveryTimeView.snp.makeConstraints {
			$0.top.leading.equalToSuperview().inset(Layout.commonInset)
		}
		
		cardView.contentView.addSubview(orderDetailsView)
		orderDetailsView.snp.makeConstraints {
			$0.top.equalTo(mapController.view.snp.bottom)
			$0.leading.trailing.bottom.equalToSuperview()
		}
		
		// For now the restaurant data doesn't contains address details. Address fetches by coordinats
		mapController.viewModel.getAddresByCoordinates(lat: item.latitude, lon: item.longitude) { [weak self] address in
			self?.orderDetailsView.restAddressLabel.text = address
		}
	}
	
}
