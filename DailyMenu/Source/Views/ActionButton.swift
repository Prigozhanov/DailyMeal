//
//  Created by Vladimir on 2/27/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class ActionButton: UIButton {
	
	override var isEnabled: Bool {
		didSet {
			if isEnabled {
				Style.addBlueGradient(self)
			} else {
				removeGradientLayer()
				backgroundColor = Colors.lightGray.color
			}
		}
	}
	
	init(_ title: String, action: @escaping (ActionButton) -> Void) {
		super.init(frame: .zero)
		setRoundCorners(Layout.cornerRadius)
		setTitle(title, for: .normal)
		titleLabel?.font = FontFamily.medium
		setActionHandler(controlEvents: .touchUpInside) { _ in
			self.tapAnimation()
			action(self)
		}
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if isEnabled {
			Style.addBlueGradient(self)
		}
	}
	
	private func removeGradientLayer() {
		subviews.first(where: { $0 is GradientView })?.removeFromSuperview()
	}
	
}
