//
//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import TableKit
import Networking

class RestaurantCell: BaseTableCell {
    
    typealias CellData = Restaurant
    
    var categories: [ProductCategory] = []
    
    var restaurant: Restaurant?
    
    private let deliveryFeeValueLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.blue.color
		label.font = FontFamily.Avenir.black.font(size: 12)
        return label
    }()
	
	private var restaurantNameLabel: UILabel = {
		let label = UILabel.makeText()
		label.numberOfLines = 2
		return label
	}()
	
    private var restaurantLogoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var restaurantImageView: UIImageView = {
        let view = UIImageView(image: Images.Category.placeholder.image)
		view.contentMode = .scaleAspectFill
        view.setRoundCorners(15, maskedCorners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        return view
    }()
    
    private var restaurantDescriptionLabel: UILabel = {
        let label = UILabel.makeExtraSmallText()
        label.numberOfLines = 3
        label.textColor = Colors.gray.color
        return label
    }()
    
    private lazy var restaurantRateView: RatingView = {
        RatingView(
            item: RatingView.Item(
                value: Double(restaurant?.rate ?? "0")!,
                maxValue: 5
            )
        )
    }()
    
    private lazy var restaurantRateValueLabel: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Avenir.black.font(size: 12)
        label.textColor = Colors.blue.color
        return label
    }()
    
	private lazy var restaurantStatusView: RestaurantStatusView = {
		let view = RestaurantStatusView()
		view.rectColor = Colors.white.color
		return view
	}()
	
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func setup() {
        let shadowView = UIView(frame: .zero)
        let cardView = CardView(shadowSize: .medium, customInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        let restaurantInfoView: UIView = UIView(frame: .zero)
		
        selectionStyle = .none
        contentView.backgroundColor = Colors.commonBackground.color
        
        contentView.addSubview(cardView)
        cardView.contentView.setRoundCorners(15)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardView.contentView.addSubview(shadowView)
        shadowView.frame = cardView.contentView.frame
        cardView.contentView.setShadow(offset: CGSize(width: 0, height: 3.0), opacity: 0.1, radius: 15)
        
        cardView.contentView.addSubview(restaurantImageView)
        restaurantImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(150)
        }
		
		cardView.contentView.addSubview(restaurantStatusView)
		restaurantStatusView.snp.makeConstraints {
			$0.top.trailing.equalToSuperview()
			$0.height.equalTo(50)
			$0.width.equalTo(100)
		}
		restaurantStatusView.setRoundCorners(Layout.cornerRadius)
		
        cardView.contentView.addSubview(restaurantInfoView)
        restaurantInfoView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.commonInset)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.top.equalTo(restaurantImageView.snp.bottom).offset(Layout.commonMargin)
        }
        
        let restaurantLogoCard = CardView(shadowSize: .small, customInsets: .zero)
        restaurantInfoView.addSubview(restaurantLogoCard)
        restaurantLogoCard.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.size.equalTo(50)
        }
        restaurantLogoCard.contentView.addSubview(restaurantLogoImageView)
        restaurantLogoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        restaurantInfoView.addSubview(restaurantNameLabel)
		restaurantNameLabel.font = FontFamily.Avenir.black.font(size: 15)
        restaurantNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(restaurantLogoImageView.snp.trailing).offset(20)
        }
        
        restaurantInfoView.addSubview(restaurantRateView)
        restaurantRateView.snp.makeConstraints {
            $0.top.equalTo(restaurantNameLabel.snp.bottom)
            $0.height.equalTo(10)
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.leading.equalTo(restaurantLogoImageView.snp.trailing).offset(20)
        }
        restaurantInfoView.addSubview(restaurantRateValueLabel)
        restaurantRateValueLabel.snp.makeConstraints {
            $0.leading.equalTo(restaurantRateView.snp.trailing).offset(Layout.commonMargin)
            $0.centerY.equalTo(restaurantRateView)
        }
        
        restaurantInfoView.addSubview(deliveryFeeValueLabel)
        deliveryFeeValueLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
		let deliveryFeeLabel = UILabel.makeSmallText(Localizable.RestaurantInfo.deliveryFee)
        restaurantInfoView.addSubview(deliveryFeeLabel)
        deliveryFeeLabel.snp.makeConstraints {
            $0.top.equalTo(deliveryFeeValueLabel.snp.bottom)
            $0.trailing.equalToSuperview()
			$0.leading.greaterThanOrEqualTo(restaurantNameLabel.snp.trailing)
        }
		deliveryFeeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        cardView.contentView.addSubview(restaurantDescriptionLabel)
        restaurantDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(restaurantInfoView.snp.bottom).offset(Layout.commonMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.lessThanOrEqualTo(50)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
    }
    
    func updatePreview() {
        if let image = RestaurantPreviewImages.getPreviewByRestaurantId(restaurant?.chainID ?? -1) {
            restaurantImageView.image = image
        } else {
            restaurantImageView.image = RestaurantPreviewImages.getRestaurantPreviewByCategory(
                FoodCategory.getMainCategoryBasedOnRestaurantCategories(categories)
            )
        }
    }
    
    override func prepareForReuse() {
        restaurantImageView.image = Images.Category.placeholder.image
        super.prepareForReuse()
    }
    
}

extension RestaurantCell: ConfigurableCell {
    
    static var defaultHeight: CGFloat? {
        return 300
    }
    
    func configure(with item: Restaurant) {
        restaurant = item
        restaurantNameLabel.text = item.chainLabel
        restaurantRateView.value = (Double(item.rate) ?? 0)
        restaurantRateValueLabel.text = String(format: "%.1f", (Double(item.rate) ?? 0))
        deliveryFeeValueLabel.text = Formatter.Currency.toString(Double(item.restDeliveryFee))
        restaurantDescriptionLabel.text = item.restaurantDescription
        if let url = URL(string: item.src) {
            self.restaurantLogoImageView.kf.setImage(with: url)
		}
		restaurantStatusView.configure(
			item: RestaurantStatusView.Item(
				status: RestaurantStatusView.Status.fromString(item.status.rawValue),
				openTime: Date.fromString(item.openTime)?.toString(formatter: Date.timeFormatter) ?? "",
				closedTime: Date.fromString(item.closeTime)?.toString(formatter: Date.timeFormatter) ?? ""
			)
		)
	}
	
}
