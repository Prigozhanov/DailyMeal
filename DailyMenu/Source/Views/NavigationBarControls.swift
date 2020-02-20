//
//  Created by Vladimir on 12/22/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class NavigationBarControls: UIView {
    
    internal enum Appearance {
        case light, dark
    }
    
    private let appearance: Appearance
    private let title: String
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.makeNavigationTitle(title)
        return label
    }()
    
    var backButton: UIButton?
    
    init(title: String, appearance: Appearance = .light) {
        self.appearance = appearance
        self.title = title
        
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        let notificationButton = UIButton.makeNotificationButton()
        addSubview(notificationButton)
        notificationButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(44)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(notificationButton.snp.centerY)
        }
        
        switch appearance {
        case .light:
            titleLabel.textColor = Colors.white.color
            backButton?.tintColor = Colors.white.color
            notificationButton.tintColor = Colors.white.color
        case .dark:
            titleLabel.textColor = Colors.charcoal.color
            backButton?.tintColor = Colors.charcoal.color
            notificationButton.tintColor = Colors.charcoal.color
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard let vc = parentViewController else { return }
        backButton = UIButton.makeBackButton(vc)
        backButton?.tintColor = appearance == .light ? Colors.white.color : Colors.black.color
        addSubview(backButton!)
        backButton!.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Layout.largeMargin)
        }
        snp.makeConstraints {
            $0.height.equalTo(100)
        }
        
    }
    
}
