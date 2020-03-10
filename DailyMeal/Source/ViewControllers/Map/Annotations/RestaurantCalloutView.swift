//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RestaurantCalloutView: UIView {
    
    struct Item {
        let imageSrc: String
        let title: String
        let rating: Double
    }
    
    private var item: Item
    
    private lazy var restaurantImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        if let url = URL(string: item.imageSrc) {
            view.kf.setImage(with: url)
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText(item.title)
        label.font = FontFamily.Poppins.semiBold.font(size: 11)
        return label
    }()
    
    private lazy var ratingView = RatingView(item: RatingView.Item(value: item.rating, maxValue: 5))
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel.makeText(String(format: "%.1f", item.rating))
        label.textColor = Colors.blue.color
        return label
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
		backgroundColor = .clear
		
        let restaurantLogoCardView = CardView(shadowSize: .small, customInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        addSubview(restaurantLogoCardView)
        restaurantLogoCardView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(restaurantLogoCardView.snp.height)
        }
        restaurantLogoCardView.contentView.addSubview(restaurantImageView)
        restaurantImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(restaurantLogoCardView.snp.trailing).offset(Layout.largeMargin)
        }
        
        addSubview(ratingView)
        ratingView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(restaurantLogoCardView)
            $0.height.equalTo(10)
        }
        
        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingView.snp.trailing).offset(Layout.largeMargin)
            $0.centerY.equalTo(ratingView)
        }
        
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(150)
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
