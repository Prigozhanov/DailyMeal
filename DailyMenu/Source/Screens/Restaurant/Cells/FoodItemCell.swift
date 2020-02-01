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
        let imageURL: String
    }
    
    var item: Item?
    
    private let foodTitle: UILabel = {
        let label = UILabel.makeText()
        label.numberOfLines = 3
        label.font = FontFamily.semibold
        return label
    }()
    
    private let foodDescription: UILabel = {
        let label = UILabel.makeExtraSmallText()
        label.textColor = Colors.gray.color
        label.numberOfLines = 5
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.blue.color
        label.font = FontFamily.semibold
        return label
    }()
    
    private let foodImage: UIImageView = {
        let view = UIImageView(image: Images.foodItemPlaceholder.image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        let cardView = CardView(shadowSize: .medium, customInsets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        cardView.contentView.addSubview(foodImage)
        foodImage.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(cardView.contentView.snp.height).inset(Layout.largeMargin)
        }
        foodImage.contentMode = .scaleAspectFit
        foodImage.setRoundCorners(Layout.cornerRadius)
        
        cardView.contentView.addSubview(foodTitle)
        foodTitle.snp.makeConstraints {
            $0.leading.equalTo(foodImage.snp.trailing).offset(Layout.largeMargin)
            $0.top.equalToSuperview().inset(Layout.largeMargin)
        }
        
        cardView.contentView.addSubview(priceLabel)
        priceLabel.textAlignment = .right
        priceLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(foodTitle.snp.trailing).offset(Layout.commonMargin)
        }
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        
        cardView.contentView.addSubview(foodDescription)
        
        foodDescription.snp.makeConstraints {
            $0.leading.equalTo(foodImage.snp.trailing).offset(Layout.largeMargin)
            $0.top.equalTo(foodTitle.snp.bottom).offset(Layout.commonMargin)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.bottom.lessThanOrEqualTo(cardView.snp.bottom)
        }
    }
    
    func configure(with item: Item) {
        foodTitle.text = item.title
        foodDescription.text = item.description
        priceLabel.text = item.price
        if let url = URL(string: item.imageURL) {
            foodImage.sd_setImage(with: url)
        }
        
        layoutSubviews()
    }
    
}
