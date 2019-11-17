//
//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import TableKit

class RestaurantCell: BaseTableCell {
        
    struct Item {
        let name: String
        let rate: String
        let deliveryFee: String
    }

    typealias CellData = RestaurantCell.Item
    
    private let deliveryFeeValueLabel = UILabel.makeMediumText()
    private var restaurantNameLabel = UILabel.makeMediumText()
     
    private let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func setup() {
        let shadowView = UIView(frame: .zero)
        let containerView = UIView(frame: .zero)
        let restaurantInfoView: UIView = UIView(frame: .zero)
        
        var restaurantImageView: UIImageView
        var restaurantLogoImageView: UIImageView
        var restaurantRateView: UIImageView
        
        selectionStyle = .none
        contentView.backgroundColor = Colors.lightGray.color
        
        containerView.frame = contentView.frame
        contentView.addSubview(containerView)
        containerView.backgroundColor = Colors.white.color
        containerView.setRoundCorners(15)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(edgeInsets)
            $0.height.equalTo(RestaurantCell.estimatedHeight ?? 0)
        }
        
        containerView.addSubview(shadowView)
        shadowView.frame = containerView.frame
        containerView.setShadow(offset: CGSize(width: 0, height: 3.0), opacity: 0.1, radius: 15)
        
        restaurantImageView = UIImageView(image: Images.restaurentImagePlaceholder.image)
        restaurantImageView.setRoundCorners(15, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
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
        
        restaurantInfoView.addSubview(restaurantNameLabel)
        restaurantNameLabel.font = FontFamily.bold
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
        
        deliveryFeeValueLabel.textColor = Colors.blue.color
        restaurantInfoView.addSubview(deliveryFeeValueLabel)
        deliveryFeeValueLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        let deliveryFeeLabel = UILabel.makeSmallText("Delivery fee")
        restaurantInfoView.addSubview(deliveryFeeLabel)
        deliveryFeeLabel.snp.makeConstraints {
            $0.top.equalTo(deliveryFeeValueLabel.snp.bottom)
            $0.trailing.equalToSuperview()
        }
    }
    
}

extension RestaurantCell: ConfigurableCell {
    
    static var estimatedHeight: CGFloat? {
        return 300
    }
    
    func configure(with item: RestaurantCell.Item) {
        restaurantNameLabel.text = item.name.uppercased()
        deliveryFeeValueLabel.text = "BYN \(item.deliveryFee)"
    }
    
    
}
