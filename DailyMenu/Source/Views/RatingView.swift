//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Extensions

class RatingView: UIView {
    
    
    struct Item {
        var value: Double
        let maxValue: Double
    }
    
    private var item: Item
    
    var value: Double {
        didSet {
            updateValue(value)
        }
    }
    
    private var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private var viewsFillData: [Double] = []
    
    init(item: Item) {
        self.item = item
        value = item.value
        
        super.init(frame: .zero)
        
        calculateFillData()
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        viewsFillData.forEach { _ in 
            let starImage = UIImageView(image: Images.Icons.starFull.image)
            starImage.tintColor = Colors.lightGray.color
            starImage.contentMode = .scaleAspectFit
            starImage.snp.makeConstraints {
                $0.width.equalTo(starImage.snp.height)
            }
            stackView.addArrangedSubview(starImage)
        }
        
        updateValue(value)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func updateValue(_ value: Double) {
        calculateFillData()
        
        stackView.arrangedSubviews.forEach { view in
            let view = (view as! UIImageView)
            view.image = Images.Icons.starFull.image
        }
        
        stackView.arrangedSubviews.enumerated().forEach { (index, view) in
            let view = (view as! UIImageView)
            if value == 0 {
                view.image = view.image?.withHorizontalFill(ratio: CGFloat(1), highlightingColor: Colors.lightGray.color, fillColor: Colors.blue.color)
                return
            }
            let ratio = viewsFillData[index]
            view.image = view.image?.withHorizontalFill(ratio: CGFloat(ratio), highlightingColor: Colors.blue.color, fillColor: Colors.lightGray.color)
        }
        
    }
    
    private func calculateFillData() {
        viewsFillData.removeAll()
        for i in 0 ..< Int(item.maxValue) {
            let elementNumber = Double(i)
            if elementNumber <= value {
                let ratio = value - elementNumber
                viewsFillData.append(ratio)
                continue
            }
            if elementNumber > value {
                viewsFillData.append(0)
            }
        }
    }
    
}
