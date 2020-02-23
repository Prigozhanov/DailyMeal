//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class PriceRangeRow: UIView {
    
    struct Item {
        var value: RangeValue<CGFloat>
        let maximumValue: CGFloat
        let valueChanged: (CGFloat, CGFloat) -> Void
    }
    
    private var item: Item
    
    private lazy var rangeSlider: PriceRangeControl = {
        let control = PriceRangeControl { [weak self] rangeSlider in
            self?.item.value.lowerValue = rangeSlider.lowerValue
            self?.item.value.upperValue = rangeSlider.upperValue
            self?.item.valueChanged(rangeSlider.lowerValue, rangeSlider.upperValue)
            self?.valueLabel.text = "\(Formatter.Currency.toString(Int(rangeSlider.lowerValue))) - \(Formatter.Currency.toString(Int(rangeSlider.upperValue)))"
        }
        control.minimumValue = 0
        control.maximumValue = item.maximumValue
        control.lowerValue = item.value.lowerValue
        control.upperValue = item.value.upperValue
        return control
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel.makeSmallText(
            "\(Formatter.Currency.toString(Int(item.value.lowerValue))) - \(Formatter.Currency.toString(Int(item.value.upperValue)))"
        )
        label.textColor = Colors.blue.color
        return label
    }()
    
    private lazy var titleLabel = UILabel.makeSmallText("Price range")
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        addSubviews([titleLabel, valueLabel, rangeSlider])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        rangeSlider.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
