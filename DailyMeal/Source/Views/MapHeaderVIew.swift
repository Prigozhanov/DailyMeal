//
//  Created by Vladimir on 2/9/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class MapHeaderView: UIView {
    
    lazy var backButton: UIButton = {
        var button = UIButton.makeBackButton(self.parentViewController)
        button.tintColor = Colors.charcoal.color
        return button
    }()
    
    init(title: String, shouldShowBackButton: Bool = true, shouldShowNotificationsButton: Bool = true) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        let headerTitleLabel = UILabel.makeText(title)
        let notificationButton = UIButton.makeNotificationButton()
        notificationButton.tintColor = Colors.charcoal.color
        
        addSubviews([backButton, headerTitleLabel, notificationButton])
        
        backButton.snp.makeConstraints {
            $0.leading.top.equalTo(safeAreaLayoutGuide)
			$0.size.equalTo(60)
        }
        
        headerTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
			$0.centerY.equalTo(backButton)
        }
        headerTitleLabel.font = FontFamily.Avenir.medium.font(size: 16)
        
        notificationButton.snp.makeConstraints {
			$0.trailing.equalToSuperview()
			$0.centerY.equalTo(backButton)
			$0.size.equalTo(60)
        }
        
    }
    
    func setupGradient() {
        Style.addWhiteGradient(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
