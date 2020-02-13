//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class OrderPlacedViewController: UIViewController {
    
    private lazy var orderAgainButton = UIButton.makeActionButton("View order status") { [weak self] button in
        button.tapAnimation()
        self?.navigationController?.dismiss(animated: true, completion: {
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style.addBlueCorner(self)
        
        view.backgroundColor = Colors.commonBackground.color
        
        let imageView = UIImageView(image: Images.Placeholders.orderPlaced.image)
        imageView.contentMode = .scaleAspectFit
        let messageTitle = UILabel.makeText("Your Food order have been placed")
        messageTitle.numberOfLines = 2
        messageTitle.font = FontFamily.Poppins.semiBold.font(size: 18)
        let messageLabel = UILabel.makeText("Bushwick meh Blue Bottle pork belly mustache skateboard 3 wolf moon. Actually") // TODO change text
        messageLabel.font = FontFamily.Poppins.regular.font(size: 12)
        messageLabel.textColor = Colors.gray.color
        messageLabel.numberOfLines = 5
        view.addSubviews([imageView, messageTitle, messageLabel, orderAgainButton])
        
        
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
        orderAgainButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(messageLabel.snp.bottom).offset(30)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }

        Style.addNotificationButton(self) { (_) in
            
        }
        Style.addTitle(title: "Order placed", self)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(orderAgainButton)
    }
    
}

