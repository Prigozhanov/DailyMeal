//
//  Created by Vladimir on 2/28/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import SnapKit

class DailyTabBar: UIView {
	
	var items: [DailyTabBarButton.Item] = []
	
	private var arrangedButtons: [DailyTabBarButton] {
		return itemsStackView.arrangedSubviews.compactMap { $0 as? DailyTabBarButton }
	}
	
	private let itemsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.distribution = .fill
		stackView.axis = .horizontal
		return stackView
	}()
	
	private let sliderHeight: CGFloat = 18
	private lazy var sliderView: UIView = {
		let label = UIView(frame: CGRect(x: 0, y: 0, width: 65, height: sliderHeight))
		label.setRoundCorners(sliderHeight / 2)
		label.backgroundColor = Colors.blue.color
		return label
	}()
	
	private var underlineLeadingConstraint: Constraint?

	init() {
		super.init(frame: .zero)

		backgroundColor = Colors.white.color
		isExclusiveTouch = true
		addSubview(itemsStackView)
		itemsStackView.snp.makeConstraints {
			$0.top.equalToSuperview().inset(Layout.commonInset)
			$0.centerX.equalToSuperview()
			$0.bottom.equalTo(safeAreaLayoutGuide)
		}
		
		itemsStackView.addSubview(sliderView)
		sliderView.snp.makeConstraints {
			underlineLeadingConstraint = $0.leading.equalToSuperview().constraint
			$0.height.equalTo(sliderHeight)
			$0.width.equalTo(65)
			$0.bottom.equalToSuperview().inset(1)
		}
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	func addItem(item: DailyTabBarButton.Item) {
		items.append(item)
		itemsStackView.addArrangedSubview(
			DailyTabBarButton(
				item: DailyTabBarButton.Item(
					title: item.title,
					image: item.image,
					highlightedImage: item.highlightedImage,
					didSelect: item.didSelect
				)
			)
		)
	}
	
	func selectItem(at index: Int) {
		arrangedButtons.enumerated().forEach { i, view in
			i == index ? view.setSelected(true) : view.setSelected(false)
		}
		
		underlineLeadingConstraint?.update(
			inset: CGFloat(index * DailyTabBarButton.buttonWidth) +
				CGFloat(DailyTabBarButton.buttonWidth / 2) -
				CGFloat(sliderView.frame.width / 2)
		)

		UIView.transition(with: sliderView, duration: 0.35, options: [.curveEaseInOut], animations: { [weak self] in
			self?.layoutIfNeeded()
			}, completion: nil)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		Style.addBlueGradient(sliderView)
	}
	
	func setBadgeVisible(_ visible: Bool, at index: Int) {
		arrangedButtons[index].setBadgeVisible(visible)
	}
	
}
