//
//  Created by Vladimir on 2/28/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class DailyTabBarController: UITabBarController {
	
	let dailyTabBar: DailyTabBar = DailyTabBar()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tabBar.removeShadow()
		tabBar.addSubview(dailyTabBar)
		dailyTabBar.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		tabBar.bringSubviewToFront(dailyTabBar)
		dailyTabBar.selectItem(at: selectedIndex)
	}
	
	override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
		super.setViewControllers(viewControllers, animated: animated)
		setupViewControllers()
	}
	
	private func setupViewControllers() {
		viewControllers?.enumerated().forEach { index, vc in
			dailyTabBar.addItem(item: DailyTabBarButton.Item(
				title: vc.tabBarItem.title,
				image: vc.tabBarItem.image,
				highlightedImage: vc.tabBarItem.selectedImage,
				didSelect: { [weak self] in
					guard let self = self, let viewControllers = self.viewControllers else {
						return
					}
					self.tabBarController(self, shouldSelect: viewControllers[index])
			})
			)
		}
	}
	
	@discardableResult
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		if let fromView = tabBarController.selectedViewController?.view,
			let toView = viewController.view, fromView != toView,
			let controllerIndex = self.viewControllers?.firstIndex(of: viewController) {
			
			let viewSize = fromView.frame
			let scrollRight = controllerIndex > tabBarController.selectedIndex
			
			if fromView.superview?.subviews.contains(toView) == true { return false }
			
			viewController.viewWillAppear(false)
			fromView.superview?.addSubview(toView)
			
			let screenWidth = UIScreen.main.bounds.size.width
			toView.frame = CGRect(x: (scrollRight ? screenWidth : -screenWidth), y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
			
			UIView.animate(withDuration: 0.25, delay: TimeInterval(0.0), options: [.curveEaseOut, .preferredFramesPerSecond60], animations: {
				fromView.frame = CGRect(x: (scrollRight ? -screenWidth : screenWidth), y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
				toView.frame = CGRect(x: 0, y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
			}, completion: { finished in
				if finished {
					fromView.removeFromSuperview()
					tabBarController.selectedIndex = controllerIndex
				}
			})
			dailyTabBar.selectItem(at: viewControllers?.firstIndex(of: viewController) ?? 0)
			return true
		}
		return false
	}
	
}

extension UITabBar {
	
	override open func sizeThatFits(_ size: CGSize) -> CGSize {
		super.sizeThatFits(size)
		guard let window = UIApplication.shared.keyWindow else {
			return super.sizeThatFits(size)
		}
		var sizeThatFits = super.sizeThatFits(size)
		sizeThatFits.height = window.safeAreaInsets.bottom + 70
		return sizeThatFits
	}
	
	// removes top horizontal separator
	func removeShadow() {
		if #available(iOS 13, *) {
			let appearance = standardAppearance.copy()
			appearance.backgroundImage = UIImage()
			appearance.shadowImage = UIImage()
			appearance.shadowColor = .clear
			standardAppearance = appearance
		} else {
			backgroundImage = UIImage()
			shadowImage = UIImage()
		}
	}
	
}

extension UITabBarController {
	
	var mainTabBar: DailyTabBar? {
		return (self as? DailyTabBarController)?.dailyTabBar
	}
	
}
