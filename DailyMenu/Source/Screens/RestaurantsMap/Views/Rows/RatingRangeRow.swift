//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RatingRangeRow: UIView {
    
    struct Item {
        let valueChanged: (Double, Double) -> Void
    }
    
    private let item: Item
    
    private lazy var ratingRangeControl: RatingRangeControl = {
        let control = RatingRangeControl { [weak self] rangeSlider in
            let upperValue = Double(rangeSlider.upperValue)
            let lowerValue = Double(rangeSlider.lowerValue)
            self?.item.valueChanged(lowerValue, upperValue)
        }
        control.maximumValue = 5
        control.upperValue = 4
        control.lowerValue = 2
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
