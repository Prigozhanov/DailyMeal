//
//  Created by Vladimir on 12/8/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderCell: UIView {
    
    public struct Item {
        public let label: String
        public let distance: String
        public let orderDelay: String
        public let minOrderPrice: String
		public let rating: Double
        public let imageURL: String
    }
    
    private var item: Item?
    
    private let restaurantNameLabel: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.black
        return label
    }()
    
    private let minOrderValueLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.blue.color
		label.font = FontFamily.Avenir.black.font(size: 12)
        return label
    }()
    
    private let distanceValueLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.smoke.color
        label.font = FontFamily.Avenir.medium.font(size: 10)
        return label
    }()
    
    private let deliveryTimeValueLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.smoke.color
        label.font = FontFamily.Avenir.medium.font(size: 10)
        return label
    }()
    
    private let restaurantLogo: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
	
	private lazy var ratingView = RatingView(
		item: RatingView.Item(
			value: item?.rating ?? 0,
			maxValue: 5
		)
	)
	
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        let cardView = CardView(shadowSize: .large, customInsets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let logoImageCardView = CardView(shadowSize: .small, customInsets: .zero)
        cardView.contentView.addSubview(logoImageCardView)
        logoImageCardView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(60)
        }
        
        cardView.contentView.addSubview(restaurantLogo)
        restaurantLogo.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(60)
        }
        
        let restaurantInfoView = UIView()
        cardView.contentView.addSubview(restaurantInfoView)
        restaurantInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.largeMargin)
            $0.leading.equalTo(restaurantLogo.snp.trailing).offset(20)
            $0.height.equalTo(restaurantLogo.snp.height)
        }
        
        restaurantInfoView.addSubview(restaurantNameLabel)
        restaurantNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        restaurantInfoView.addSubview(ratingView)
        ratingView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(restaurantNameLabel.snp.bottom).offset(Layout.largeMargin)
			$0.height.equalTo(10)
        }
        
        cardView.contentView.addSubview(minOrderValueLabel)
        minOrderValueLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.leading.equalTo(restaurantInfoView.snp.trailing)
        }
        
		let minOrderLabel = UILabel.makeExtraSmallText(Localizable.RestaurantInfo.minOrder)
        cardView.contentView.addSubview(minOrderLabel)
        minOrderLabel.snp.makeConstraints {
            $0.top.equalTo(minOrderValueLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(Layout.largeMargin)
        }
        
        let deliveryInfo = UIView()
        cardView.contentView.addSubview(deliveryInfo)
        deliveryInfo.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.bottom.lessThanOrEqualTo(cardView.contentView.snp.bottom)
            $0.top.equalTo(restaurantInfoView.snp.bottom).offset(25)
            $0.height.equalTo(30)
        }
        deliveryInfo.setRoundCorners(Layout.cornerRadius)
        deliveryInfo.backgroundColor = Colors.lightBlue.color
        
        let distanceIcon = UIImageView(image: Images.Icons.mapPin1.image.withRenderingMode(.alwaysTemplate))
        distanceIcon.contentMode = .scaleAspectFit
        distanceIcon.tintColor = Colors.blue.color
        deliveryInfo.addSubview(distanceIcon)
        distanceIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(10)
        }
        deliveryInfo.addSubview(distanceValueLabel)
        distanceValueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(distanceIcon.snp.trailing).offset(Layout.commonMargin)
        }
        
        let deliveryTimeIcon = UIImageView(image: Images.Icons.clock.image.withRenderingMode(.alwaysTemplate))
        deliveryInfo.addSubview(deliveryTimeIcon)
        deliveryTimeIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(distanceValueLabel.snp.trailing).offset(30)
            $0.size.equalTo(10)
        }
        deliveryInfo.addSubview(deliveryTimeValueLabel)
        deliveryTimeValueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(deliveryTimeIcon.snp.trailing).offset(Layout.commonMargin)
            $0.trailing.equalToSuperview().inset(Layout.largeMargin)
        }
        
    }
    
    func configure(with item: Item) {
        restaurantNameLabel.text = item.label
        distanceValueLabel.text = item.distance
        deliveryTimeValueLabel.text = item.orderDelay
        minOrderValueLabel.text = item.minOrderPrice
        if let url = URL(string: item.imageURL) {
            restaurantLogo.kf.setImage(with: url)
        }
		ratingView.value = item.rating
        
    }
    
}
