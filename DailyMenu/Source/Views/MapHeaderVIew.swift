//
//  Created by Vladimir on 2/9/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class MapHeaderView: UIView {
    
    init(title: String, shouldShowBackButton: Bool = true, shouldShowNotificationsButton: Bool = true) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        let headerTitleLabel = UILabel.makeText(title)
        let notificationButton = UIButton.makeNotificationButton()
        notificationButton.tintColor = Colors.charcoal.color
        
        notificationButton.setActionHandler(controlEvents: .touchUpInside) { _ in
            
        }
        let backButton = UIButton.makeBackButton(self.parentViewController)
        backButton.tintColor = Colors.charcoal.color
        
        addSubviews([backButton, headerTitleLabel, notificationButton])
        
        backButton.snp.makeConstraints {
            $0.leading.top.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        headerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
        headerTitleLabel.font = FontFamily.Poppins.medium.font(size: 16)
        
        notificationButton.snp.makeConstraints {
            $0.top.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
    }
    
    func setupGradient() {
        Style.addWhiteGradient(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
