//
//  Created by Vladimir on 3/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public extension Date {
	
	static var defaultFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
		return formatter
	}
	
	static var timeFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		return formatter
	}
	
	static func fromString(_ string: String) -> Date? {
		return defaultFormatter.date(from: string)
	}
	
	func toString(formatter: DateFormatter) -> String {
		return formatter.string(from: self)
	}
	
}
