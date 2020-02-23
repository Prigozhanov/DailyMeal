//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RadiusRow: UIView {
    
    struct Item {
        var value: Float
        let maximumValue: Float
        let valueChanged: (Float) -> Void
    }

    private var item: Item
    
    private lazy var initialValue = item.value
    
    private lazy var slider: Slider = {
       let slider = Slider()
        slider.minimumValue = 0
        slider.maximumValue = item.maximumValue
        
        slider.value = initialValue
     
        
        slider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        return slider
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel.makeSmallText("\(Int(item.value)) km")
        label.textColor = Colors.blue.color
        return label
    }()
    
    private lazy var titleLabel = UILabel.makeSmallText("Radius")
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        addSubviews([titleLabel, valueLabel, slider])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        slider.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    @objc func valueChanged(slider: UISlider) {
        item.value = slider.value
        item.valueChanged(slider.value)
        valueLabel.text = String(format: "%.0f km", slider.value)
    }
    
}
