//
//  Created by Vladimir on 3/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RestaurantStatusView: UIView {
	
	struct Item {
		let isOpen: Bool
		let openTime: String
		let closedTime: String
	}
	
	private var item: Item?
	
	var cornerRadius: CGFloat = 15
	var rectColor: UIColor? = Colors.commonBackground.color
	
	private lazy var statusLabel: UILabel = {
		let label = UILabel.makeText()
		label.textAlignment = .center
		return label
	}()
	
	private lazy var workingHoursLabel: UILabel = {
		let label = UILabel.makeExtraSmallText("\(item?.openTime ?? "") - \(item?.closedTime ?? "")")
		label.textAlignment = .center
		label.textColor = Colors.gray.color
		return label
	}()
	
	init() {
		super.init(frame: .zero)
		
		backgroundColor = .clear
		
		addSubview(statusLabel)
		statusLabel.snp.makeConstraints {
			$0.top.trailing.equalToSuperview().inset(5)
			$0.leading.equalToSuperview().inset(cornerRadius)
		}
		
		addSubview(workingHoursLabel)
		workingHoursLabel.snp.makeConstraints {
			$0.top.equalTo(statusLabel.snp.bottom)
			$0.trailing.equalToSuperview()
			$0.bottom.leading.lessThanOrEqualToSuperview().inset(cornerRadius)
		}
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func draw(_ rect: CGRect) {
		let path = UIBezierPath()
		
		path.move(to: .zero)
		
		path.addLine(to: CGPoint(x: rect.maxX, y: 0))
		
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		
		path.addCurve(
			to: CGPoint(x: rect.maxX - (cornerRadius), y: rect.maxY - cornerRadius),
			controlPoint1: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius),
			controlPoint2: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius)
		)
		
		path.addLine(to: CGPoint(x: cornerRadius * 2, y: rect.maxY - cornerRadius))
		
		path.addCurve(
			to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - (cornerRadius * 2)),
			controlPoint1: CGPoint(x: cornerRadius, y: rect.maxY - cornerRadius),
			controlPoint2: CGPoint(x: cornerRadius, y: rect.maxY - cornerRadius)
		)
		
		path.addLine(to: CGPoint(x: cornerRadius, y: cornerRadius))
		
		path.addCurve(
			to: .zero,
			controlPoint1: CGPoint(x: cornerRadius, y: 0),
			controlPoint2: CGPoint(x: cornerRadius, y: 0)
		)
		
		path.close()
		
		rectColor?.setFill()
		
		path.fill()
	}
	
	func configure(item: Item) {
		self.item = item
		statusLabel.text = item.isOpen ? Localizable.RestaurantInfo.open : Localizable.RestaurantInfo.closed
		workingHoursLabel.text = "\(item.openTime) - \(item.closedTime)"
		
		if item.isOpen {
			statusLabel.textColor = Colors.charcoal.color
		} else {
			statusLabel.textColor = Colors.red.color
		}
	}
	
}
