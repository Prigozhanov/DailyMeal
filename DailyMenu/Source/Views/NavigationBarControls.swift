//
//  Created by Vladimir on 12/22/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class NavigationBarControls: UIView {
    
    init() {
        super.init(frame: .zero)
        let notificationButton = UIButton.makeNotificationButton()
        addSubview(notificationButton)
        notificationButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(44)
        }
        
        let title = UILabel.makeNavigationTitle("Restaurant")
        title.textColor = Colors.white.color
        addSubview(title)
        title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(notificationButton.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard let vc = parentViewController else { return }
        let backButton = UIButton.makeBackButton(vc)
        addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(44)
        }
    }
    
}
