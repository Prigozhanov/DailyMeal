//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import Extensions

final class SettingsViewController: UIViewController {
    
    private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = Colors.commonBackground.color
        
        let signOutButton = UIButton.makeCommonButton("Sign out") { [weak self] _ in
            NotificationCenter.default.post(Notification(name: .userLoggedOut))
            self?.viewModel.clearUserInfo()
        }
        view.addSubview(signOutButton)
        signOutButton.setTitleColor(Colors.red.color, for: .normal)
        signOutButton.titleLabel?.font = FontFamily.semibold
        signOutButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Layout.commonInset)
            $0.centerX.equalToSuperview()
        }
        
        let label = UILabel.makeText()
        label.text = viewModel.phone
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

//MARK: -  SettingsView
extension SettingsViewController: SettingsView {
    
}

//MARK: -  Private
private extension SettingsViewController {
    
}


