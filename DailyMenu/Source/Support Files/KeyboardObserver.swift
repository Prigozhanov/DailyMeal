//
//  Created by Vladimir on 2/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Extensions
import UIKit
import RxSwift
import RxKeyboard
import SnapKit

struct ObservableConstraint {
	let constraint: Constraint
	let inset: CGFloat
	var keyboardOffset: CGFloat = 0
}

protocol KeyboardObservable: UIViewController {
	
	var bag: DisposeBag { get }
	
	var observableConstraints: [ObservableConstraint] { get }
	
	func startObserveKeyboard()
}

extension KeyboardObservable {
	
	// Use this method in viewDidAppear. First call will always perfom even keyboard is hidden.
	func startObserveKeyboard() {
		RxKeyboard.instance.visibleHeight.drive(onNext: { height in
			if height <= 0 {
				self.observableConstraints.forEach {
					$0.constraint.update(inset: $0.inset)
				}
			} else {
				self.observableConstraints.forEach {
					$0.constraint.update(inset: height + $0.keyboardOffset)
				}
			}
			self.view.setNeedsLayout()
			UIView.animate(withDuration: 0) { [weak self] in
				self?.view.layoutIfNeeded()
				self?.children.forEach { $0.view.layoutIfNeeded() }
			}
		}).disposed(by: self.bag)
	}
	
}
