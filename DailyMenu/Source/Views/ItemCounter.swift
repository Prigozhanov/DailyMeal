//
//  Created by Vladimir on 1/10/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class ItemCounter: UIView {
	
	enum Axis {
		case veritcal, horizontal
	}
	
	private var value = 1
	
	private var minimumValue = 1
	private var maximumValue = 20
	
	let valueLabel = UILabel()
	
	init(axis: Axis, valueChanged: @escaping (Int) -> Void) {
		super.init(frame: .zero)
		
		let plusButton = UIButton()
		plusButton.setTitle("+", for: .normal)
		plusButton.setTitleColor(Colors.lightGray.color, for: .normal)
		plusButton.setActionHandler(controlEvents: .touchUpInside) { [unowned self] _ in
			if self.value < self.maximumValue {
				self.value += 1
				self.valueLabel.text = String(self.value)
			}
			valueChanged(self.value)
		}
		addSubview(plusButton)
		plusButton.snp.makeConstraints {
			switch axis {
			case .horizontal:
				$0.trailing.top.bottom.equalToSuperview()
			case .veritcal:
				$0.leading.top.trailing.equalToSuperview()
			}
		}
		
		addSubview(valueLabel)
		valueLabel.text = String(value)
		valueLabel.textAlignment = .center
		valueLabel.snp.makeConstraints {
			switch axis {
			case .horizontal:
				$0.top.bottom.equalToSuperview()
				$0.trailing.equalTo(plusButton.snp.leading)
			case .veritcal:
				$0.leading.trailing.equalToSuperview()
				$0.top.equalTo(plusButton.snp.bottom)
			}
		}
		
		let minusButton = UIButton()
		minusButton.setTitle("-", for: .normal)
		minusButton.setTitleColor(Colors.lightGray.color, for: .normal)
		minusButton.setActionHandler(controlEvents: .touchUpInside) { [unowned self] _ in
			if self.value > self.minimumValue {
				self.value -= 1
				self.valueLabel.text = String(self.value)
			}
			valueChanged(self.value)
		}
		addSubview(minusButton)
		minusButton.snp.makeConstraints {
			switch axis {
			case .horizontal:
				$0.top.bottom.leading.equalToSuperview()
				$0.trailing.equalTo(valueLabel.snp.leading)
				$0.width.equalTo(plusButton.snp.width)
			case .veritcal:
				$0.leading.bottom.trailing.equalToSuperview()
				$0.top.equalTo(valueLabel.snp.bottom)
				$0.height.equalTo(plusButton.snp.height)
			}
		}
		
		setBorder(width: 1, color: Colors.lightGray.color)
		setRoundCorners(Layout.cornerRadius)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	func updateValue(_ value: Int) {
		self.value = value
		self.valueLabel.text = String(value)
	}
	
}
