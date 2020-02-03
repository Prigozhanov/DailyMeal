//
//  Created by Vladimir on 1/26/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class SliderView: UIView {
    
    private let sliderValues: [String]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText()
        return label
    }()
    
    private lazy var valuesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        sliderValues.forEach { value in
            let label = UILabel.makeText(value)
            label.font = FontFamily.Poppins.regular.font(size: 10)
            label.textColor = Colors.smoke.color
            stack.addArrangedSubview(label)
        }
        return stack
    }()
    
    private lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.setThumbImage(Images.Icons.thumb.image, for: .normal)
        slider.tintColor = Colors.blue.color
        slider.maximumValue = Float(sliderValues.count - 1)
        slider.addTarget(self, action: #selector(valueChanged), for: .touchDragInside)
        slider.addTarget(self, action: #selector(valueChanged), for: .touchDragOutside)
        return slider
    }()
    
    init(title: String, sliderValues: [String]) {
        self.sliderValues = sliderValues
        
        super.init(frame: .height(100))
        
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        addSubview(valuesStack)
        valuesStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeMargin)
        }
        
        addSubview(sliderView)
        sliderView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.top.equalTo(valuesStack.snp.bottom).offset(4)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    @objc func valueChanged() {
        sliderView.value = round(sliderView.value)
    }
    
}
