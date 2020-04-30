//
//  Created by Vladimir on 3/8/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit.UIFeedbackGenerator

extension UINotificationFeedbackGenerator {
	
	public static func impact(_ type: UINotificationFeedbackGenerator.FeedbackType) {
		let impactFeedbackgenerator = UINotificationFeedbackGenerator()
		impactFeedbackgenerator.prepare()
		impactFeedbackgenerator.notificationOccurred(type)
	}
	
}

extension UISelectionFeedbackGenerator {
	
	public static func impact() {
		let impactFeedbackgenerator = UISelectionFeedbackGenerator()
		impactFeedbackgenerator.prepare()
		impactFeedbackgenerator.selectionChanged()
	}
	
}
