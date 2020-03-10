//
//  Created by Vladimir on 2/25/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RestaurantsHeaderView: UIView {
    
    typealias Item = String
    
    private let item: Item
    
    private lazy var titleLabel: UILabel = {
		let label = UILabel.makeText(item.appending(Localizable.Restaurants.whatWouldYouLikeToEat))
        label.numberOfLines = 3
        label.font = FontFamily.Poppins.bold.font(size: 20)
        label.textColor = Colors.charcoal.color
        return label
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton.makeNotificationButton()
        button.tintColor = Colors.charcoal.color
        return button
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton.makeImageButton(image: Images.Icons.map.image) { [weak self] _ in
            let vc = RestaurantsMapViewController(
                viewModel: RestaurantsMapViewModelImplementation()
            )
            let navigationController = NavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.setNavigationBarHidden(true, animated: false)
            self?.parentViewController?.present(navigationController, animated: true)
        }
        button.tintColor = Colors.charcoal.color
        return button
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        addSubviews([titleLabel, notificationButton, mapButton])
        titleLabel.snp.makeConstraints {
			$0.leading.top.bottom.equalToSuperview().inset(Layout.commonInset)
        }

		mapButton.snp.makeConstraints {
			$0.top.equalTo(titleLabel)
			$0.leading.equalTo(titleLabel.snp.trailing).offset(Layout.largeMargin)
			$0.size.equalTo(24)
			$0.bottom.lessThanOrEqualToSuperview()
		}
		
        notificationButton.snp.makeConstraints {
			$0.top.equalTo(mapButton)
			$0.trailing.equalToSuperview().inset(Layout.commonInset)
			$0.leading.equalTo(mapButton.snp.trailing).offset(Layout.largeMargin)
			$0.size.equalTo(24)
			$0.bottom.lessThanOrEqualToSuperview()
        }
    
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
	override var intrinsicContentSize: CGSize {
		return titleLabel.intrinsicContentSize
	}

}
