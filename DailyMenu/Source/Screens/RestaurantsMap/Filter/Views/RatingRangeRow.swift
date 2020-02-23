//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RatingRangeRow: UIView {
    
    struct Item {
        var value: RangeValue<CGFloat>
        let maximumValue: CGFloat
        let valueChanged: (CGFloat, CGFloat) -> Void
    }
    
    private var item: Item
    
    private lazy var ratingRangeControl: RatingRangeControl = {
        let control = RatingRangeControl { [weak self] rangeSlider in
            self?.item.value.upperValue = rangeSlider.upperValue
            self?.item.value.lowerValue = rangeSlider.lowerValue
            self?.item.valueChanged(rangeSlider.lowerValue, rangeSlider.upperValue)
        }
        control.maximumValue = item.maximumValue
        control.lowerValue = item.value.lowerValue
        control.upperValue = item.value.upperValue
        return control
    }()
    
    private lazy var titleLabel = UILabel.makeSmallText("Rating")
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
        }
        
        addSubview(ratingRangeControl)
        ratingRangeControl.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(30)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(25)
        }
    
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
