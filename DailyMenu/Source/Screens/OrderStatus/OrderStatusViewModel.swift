//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Services

// MARK: - View
protocol OrderStatusView: class {
	
}

// MARK: - ViewModel
protocol OrderStatusViewModel {
	
	var view: OrderStatusView? { get set }
	
	var orderDate: Date {get }
	var orderId: String? { get }
	var orderDeliveryDate: Date { get }
	
	var deliveredToYouStatus: (time: String, done: Bool) { get }
	
}

// MARK: - Implementation
final class OrderStatusViewModelImplementation: OrderStatusViewModel {
	
	weak var view: OrderStatusView?
	
	private let context: AppContext
	private let userDefaultsService: UserDefaultsService
	
	var orderDeliveryDate: Date
	
	var orderDate: Date
	
	var orderId: String?
	
	var deliveredToYouStatus: (time: String, done: Bool) {
		var time = "--:--"
		var state = false
		if Date() > orderDeliveryDate {
			time = orderDeliveryDate.toString(formatter: Date.timeFormatter)
			state = true
		}
		return (time, state)
	}
	
	init() {
		context = AppDelegate.shared.context
		userDefaultsService = context.userDefaultsService
		orderDate = userDefaultsService.getValueForKey(key: .lastOrderDate) as? Date ?? Date()
		orderId = userDefaultsService.getValueForKey(key: .lastOrderId) as? String
		
		orderDeliveryDate = orderDate.addingTimeInterval(
			TimeInterval(
				userDefaultsService.getValueForKey(key: .lastOrderDeliveryTimeSeconds) as? Int ?? 0
			)
		)
	}
	
}
