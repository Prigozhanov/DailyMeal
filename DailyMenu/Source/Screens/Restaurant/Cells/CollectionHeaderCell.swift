//
//  Created by Vladimir on 12/8/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class CollectionHeaderCell: UIView {
    
    private var item: Restaurant?
    
    private let restaurantNameLabel: UILabel = {
        let label = UILabel.makeLargeText()
        label.font = FontFamily.bold
        label.textColor = Colors.charcoal.color
        return label
    }()
    
    private let minOrderValueLabel: UILabel = {
        let label = UILabel.makeMediumText()
        label.textColor = Colors.blue.color
        label.font = FontFamily.smallMedium
        return label
    }()
    
    private let distanceValueLabel: UILabel = {
        let label = UILabel.makeSmallText()
        label.textColor = Colors.smoke.color
        label.font = FontFamily.Poppins.medium.font(size: 10)
        return label
    }()
    
    private let deliveryTimeValueLabel: UILabel = {
        let label = UILabel.makeSmallText()
        label.textColor = Colors.smoke.color
        label.font = FontFamily.Poppins.medium.font(size: 10)
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
        view.backgroundColor = .white
        
        
        let restaurantLogo = UIImageView(image: Images.restaurantLogoPlaceholder.image)
        view.addSubview(restaurantLogo)
        restaurantLogo.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(60)
        }
        
        let restaurantInfoView = UIView()
        view.addSubview(restaurantInfoView)
        restaurantInfoView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.largeMargin)
            $0.leading.equalTo(restaurantLogo.snp.trailing).offset(20)
            $0.height.equalTo(restaurantLogo.snp.height)
        }
        
        restaurantInfoView.addSubview(restaurantNameLabel)
        restaurantNameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        let restaurantRating = UIImageView(image: Images.ratePlaceholder.image)
        restaurantInfoView.addSubview(restaurantRating)
        restaurantRating.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(restaurantNameLabel.snp.bottom).offset(Layout.largeMargin)
        }
        
        
        view.addSubview(minOrderValueLabel)
        minOrderValueLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.leading.equalTo(restaurantInfoView.snp.trailing)
        }
        
        let minOrderLabel = UILabel.makeExtraSmallText("Min order")
        view.addSubview(minOrderLabel)
        minOrderLabel.snp.makeConstraints {
            $0.top.equalTo(minOrderValueLabel.snp.bottom)
            $0.trailing.equalToSuperview().inset(Layout.largeMargin)
        }
        
        let deliveryInfo = UIView()
        view.addSubview(deliveryInfo)
        deliveryInfo.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.bottom.equalToSuperview().inset(25)
            $0.top.equalTo(restaurantInfoView.snp.bottom).offset(25)
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
    
    func configure(with item: Restaurant) {
        restaurantNameLabel.text = item.label
        minOrderValueLabel.text = "BYN \(item.minAmountOrder)"
        distanceValueLabel.text = "\(item.distance) km away"
        deliveryTimeValueLabel.text = "\(item.orderDelayFirst) minutes delivery time"
    }
    
}
