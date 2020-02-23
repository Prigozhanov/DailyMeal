//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class PriceRangeRow: UIView {
    
    struct Item {
        let valueChanged: (Int, Int) -> Void
    }
    
    private let item: Item
    
    private var initialValue: Float = 4
    
    private lazy var rangeSlider: PriceRangeControl = {
        let control = PriceRangeControl { [weak self] rangeSlider in
            let upperValue = Int(rangeSlider.upperValue)
            let lowerValue = Int(rangeSlider.lowerValue)
            self?.item.valueChanged(lowerValue, upperValue)
            self?.valueLabel.text = "\(Formatter.Currency.toString(lowerValue)) - \(Formatter.Currency.toString(upperValue))"
        }
        control.minimumValue = 0
        control.maximumValue = 500
        control.upperValue = 500
        control.lowerValue = 0
        return control
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel.makeSmallText("\(Formatter.Currency.toString(0)) - \(Formatter.Currency.toString(500))")
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
