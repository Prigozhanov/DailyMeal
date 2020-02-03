//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class OrderPlacedViewController: UIViewController {
    
    private lazy var orderAgainButton = UIButton.makeActionButton("View order status") { button in
        button.tapAnimation()
        self.navigationController?.dismiss(animated: true, completion: {
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style.addBlueCorner(self)
        
        view.backgroundColor = Colors.commonBackground.color
        
        let notificationButton = UIButton.makeNotificationButton()
        notificationButton.tintColor = Colors.charcoal.color
        let titleLabel = UILabel.makeLargeText("Order placed")
        titleLabel.textAlignment = .center
        let imageView = UIImageView(image: Images.orderPlacedPlaceholder.image)
        imageView.contentMode = .scaleAspectFit
        let messageTitle = UILabel.makeText("Your Food order have been placed")
        messageTitle.numberOfLines = 2
        messageTitle.font = FontFamily.Poppins.semiBold.font(size: 18)
        let messageLabel = UILabel.makeText("Bushwick meh Blue Bottle pork belly mustache skateboard 3 wolf moon. Actually") // TODO change text
        messageLabel.font = FontFamily.Poppins.regular.font(size: 12)
        messageLabel.textColor = Colors.gray.color
        messageLabel.numberOfLines = 5
        messageLabel.lineBreakMode = .byClipping
        
        view.addSubviews([notificationButton, titleLabel, imageView, messageTitle, messageLabel, orderAgainButton])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(30)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(30)
        }
        notificationButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(25)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        messageTitle.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(messageTitle.snp.bottom).offset(Layout.largeMargin)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        orderAgainButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(messageLabel.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(orderAgainButton)
    }
    
}

