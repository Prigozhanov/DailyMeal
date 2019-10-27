//
//  RestaurantCell.swift
//  DailyMenu
//
//  Created by Vladimir on 10/26/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import TableKit

struct RestaurantCellItem {
  let name: String
  let rate: String
  let deliveryFee: String
}

class RestaurantCell: UITableViewCell {
  
  typealias CellData = RestaurantCellItem
  
  private let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  
  var containerView = UIView(frame: .zero)
  var restaurantInfoView: UIView! = UIView(frame: .zero)
  
  var restaurantImageView: UIImageView!
  var restaurantNameLabel: UILabel!
  var restaurantLogoImageView: UIImageView!
  var restaurantRateView: UIImageView!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: nil)
  }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  override func prepareForReuse() {
    restaurantImageView?.removeFromSuperview()
    restaurantNameLabel?.removeFromSuperview()
    restaurantLogoImageView?.removeFromSuperview()
    restaurantRateView?.removeFromSuperview()
    containerView.removeFromSuperview()
    super.prepareForReuse()
  }
  
}

extension RestaurantCell: ConfigurableCell {
  
  static var estimatedHeight: CGFloat? {
    return 300
  }
  
  func configure(with item: RestaurantCellItem) {
    selectionStyle = .none
    contentView.backgroundColor = Colors.lightGray.color
    
    containerView.frame = contentView.frame
    contentView.addSubview(containerView)
    containerView.setRoundCorners(15)
    containerView.backgroundColor = Colors.white.color
    containerView.setShadow()
    containerView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(edgeInsets)
      $0.height.equalTo(RestaurantCell.estimatedHeight ?? 0)
    }
    
    restaurantImageView = UIImageView(image: Images.restaurentImagePlaceholder.image)
    containerView.addSubview(restaurantImageView)
    restaurantImageView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.height.equalTo(150)
    }
    
    containerView.addSubview(restaurantInfoView)
    restaurantInfoView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(restaurantImageView.snp.bottom).offset(20)
    }
    
    restaurantLogoImageView = UIImageView(image: Images.restaurantLogoPlaceholder.image)
    restaurantInfoView.addSubview(restaurantLogoImageView)
    restaurantLogoImageView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.size.equalTo(50)
    }
    
    restaurantNameLabel = UILabel.makeLargeText(item.name)
    restaurantInfoView.addSubview(restaurantNameLabel)
    restaurantNameLabel.font = FontFamily.hugeBoldFont
    restaurantNameLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalTo(restaurantLogoImageView.snp.trailing).offset(20)
    }
    
    restaurantRateView = UIImageView(image: Images.ratePlaceholder.image)
    restaurantInfoView.addSubview(restaurantRateView)
    restaurantRateView.contentMode = .scaleAspectFit
    restaurantRateView.snp.makeConstraints {
      $0.top.equalTo(restaurantNameLabel.snp.bottom)
      $0.bottom.equalToSuperview()
      $0.leading.equalTo(restaurantLogoImageView.snp.trailing).offset(20)
    }
    
    let deliveryFeeValue = UILabel.makeMediumText("BYN \(item.deliveryFee)")
    deliveryFeeValue.textColor = Colors.blue.color
    restaurantInfoView.addSubview(deliveryFeeValue)
    deliveryFeeValue.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.top.equalToSuperview()
    }
    
    let deliveryFeeLabel = UILabel.makeSmallText("Delivery fee")
    restaurantInfoView.addSubview(deliveryFeeLabel)
    deliveryFeeLabel.snp.makeConstraints {
      $0.top.equalTo(deliveryFeeValue.snp.bottom)
      $0.trailing.equalToSuperview()
    }
    
    
  }
  
}
