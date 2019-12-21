//
//  Created by Vladimir on 12/8/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class FoodItemCell: UIView {
    struct Item {
        let title: String
        let description: String
        let price: String
    }
    
    var item: Item?
    
    private let foodTitle: UILabel = {
        let label = UILabel.makeMediumText()
        label.font = FontFamily.semibold
        return label
    }()
    
    private let foodDescription: UILabel = {
        let label = UILabel.makeExtraSmallText()
        label.textColor = Colors.gray.color
        label.numberOfLines = 3
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel.makeMediumText()
        label.textColor = Colors.blue.color
        label.font = FontFamily.semibold
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
        view.setRoundCorners(Layout.cornerRadius)
        view.setShadow(offset: CGSize(width: 0, height: 4.0), opacity: 0.07, radius: 10)
        view.backgroundColor = Colors.white.color
        
        let shadow = UIView()
        view.addSubview(shadow)
        shadow.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(view.snp.height).inset(Layout.largeMargin)
        }
        shadow.setRoundCorners(Layout.cornerRadius)
        shadow.setShadow(offset: CGSize(width: 0, height: 5), opacity: 0.1, radius: 10)
        shadow.backgroundColor = .white
        
        let foodImage = UIImageView(image: Images.foodItemPlaceholder.image)
        view.addSubview(foodImage)
        foodImage.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(view.snp.height).inset(Layout.largeMargin)
        }
        foodImage.contentMode = .scaleAspectFit
        foodImage.setRoundCorners(Layout.cornerRadius)
        
        view.addSubview(foodTitle)
        foodTitle.snp.makeConstraints {
            $0.leading.equalTo(foodImage.snp.trailing).offset(Layout.largeMargin)
            $0.top.equalToSuperview().inset(Layout.largeMargin)
        }
        
        view.addSubview(price)
        price.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.centerY.equalTo(foodTitle.snp.centerY)
        }
        
        view.addSubview(foodDescription)
        foodDescription.snp.makeConstraints {
            $0.leading.equalTo(foodImage.snp.trailing).offset(Layout.largeMargin)
            $0.top.equalTo(foodTitle).offset(Layout.commonMargin)
            $0.bottom.trailing.equalToSuperview().inset(Layout.largeMargin)
        }
    }
    
    func configure(with item: Item) {
        foodTitle.text = item.title
        foodDescription.text = item.description
        price.text = "BYN \(item.price)"
    }
    
}
