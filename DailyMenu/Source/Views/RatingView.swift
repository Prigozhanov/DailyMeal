//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Extensions

class RatingView: UIView {
    
    private enum FillDirection {
        case direct, inverse
    }
    
    struct Item {
        var lowerBound: Double
        var upperBound: Double
        let maxValue: Double
    }
    
    var item: Item
    
    private var isValid: Bool {
        return item.upperBound <= Double(item.maxValue) &&
            item.lowerBound <= Double(item.maxValue) &&
            
            item.upperBound >= 0 &&
            item.lowerBound >= 0 &&
            
            item.lowerBound <= item.upperBound
    }
    
    private var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private var viewsFillData: [(fillDirection: FillDirection, ratio: Double)] = []
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        guard isValid else {
            fatalError("rating value can't be greater than stars count and lower than 0")
        }
        
        calculateFillData()
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        for _ in 0 ..< viewsFillData.count {
            let starImage = UIImageView(image: Images.Icons.starFull.image)
            starImage.tintColor = Colors.lightGray.color
            starImage.contentMode = .scaleAspectFit
            starImage.snp.makeConstraints {
                $0.width.equalTo(starImage.snp.height)
            }
            stackView.addArrangedSubview(starImage)
        }
        
        configure(item: item)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(item: Item) {
        self.item = item
        
        calculateFillData()
        
        stackView.arrangedSubviews.forEach { view in
            let view = (view as! UIImageView)
            view.image = Images.Icons.starFull.image
        }
        
        stackView.arrangedSubviews.enumerated().forEach { (index, view) in
            let view = (view as! UIImageView)
            if item.upperBound == 0 {
                 view.image = view.image?.withHorizontalFill(ratio: CGFloat(1), fillColor: Colors.lightGray.color, secondColor: Colors.blue.color)
                return
            }
            let ratio = viewsFillData[index].ratio
            switch viewsFillData[index].fillDirection {
            case .direct:
                 view.image = view.image?.withHorizontalFill(ratio: CGFloat(ratio), fillColor: Colors.blue.color, secondColor: Colors.lightGray.color)
            case .inverse:
                view.image = view.image?.withHorizontalFill(ratio: CGFloat(ratio), fillColor: Colors.lightGray.color, secondColor: Colors.blue.color)
            }
        }
        
    }
    
    
    private func calculateFillData() {
        viewsFillData.removeAll()
        for i in 0 ..< Int(item.maxValue) {
            let elementNumber = Double(i)
            if elementNumber < item.lowerBound {
                let ratio = item.lowerBound - elementNumber
                viewsFillData.append((fillDirection: .inverse, ratio: ratio))
                continue
            }
            if elementNumber <= item.upperBound {
                let ratio = item.upperBound - elementNumber
                viewsFillData.append((fillDirection: .direct, ratio: ratio))
                continue
            }
            if elementNumber > item.upperBound {
                viewsFillData.append((fillDirection: .direct, ratio: 0))
            }
        }
    }
    
}
