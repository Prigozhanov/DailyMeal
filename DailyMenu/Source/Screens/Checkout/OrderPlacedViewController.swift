//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class OrderPlacedViewController: UIViewController {
    
	private var deliveryTime: Int
	
	private lazy var viewOrderStatusButton = ActionButton(Localizable.OrderPlaced.viewOrderStatus) { [weak self] _ in
		let vc = OrderStatusViewController(viewModel: OrderStatusViewModelImplementation())
		self?.navigationController?.pushViewController(vc, animated: true)
    }
    
	init(deliveryTime: Int) {
		self.deliveryTime = deliveryTime
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style.addBlueCorner(self)
        
        view.backgroundColor = Colors.commonBackground.color
        
        let imageView = UIImageView(image: Images.Placeholders.orderPlaced.image)
        imageView.contentMode = .scaleAspectFit
		let messageTitle = UILabel.makeText(Localizable.OrderPlaced.yourOrderPlaced)
        messageTitle.numberOfLines = 2
        messageTitle.font = FontFamily.Poppins.semiBold.font(size: 18)
		let messageLabel = UILabel.makeText(Localizable.OrderPlaced.waitForCourier(deliveryTime))
        messageLabel.font = FontFamily.Poppins.regular.font(size: 12)
        messageLabel.textColor = Colors.gray.color
        messageLabel.numberOfLines = 5
        view.addSubviews([imageView, messageTitle, messageLabel, viewOrderStatusButton])
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        messageTitle.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(messageTitle.snp.bottom).offset(Layout.largeMargin)
            $0.leading.equalTo(messageTitle)
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        viewOrderStatusButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(messageLabel.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }

        Style.addNotificationButton(self) { (_) in
            
        }
		Style.addTitle(title: Localizable.OrderPlaced.orderPlacedTitle, self)
    }
    
}
