//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import Extensions
import AloeStackView

final class SettingsViewController: UIViewController {
    
    private var viewModel: SettingsViewModel
    
    private var notificationTokens: [Token] = []
    
    private var stackView: AloeStackView = {
        let stack = AloeStackView()
        stack.backgroundColor = .clear
        stack.separatorHeight = 0
        return stack
    }()
    
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
        
        notificationTokens.append(Token.make(descriptor: .userAddressChangedDescriptor, using: { [weak self] _ in
            self?.reloadRows()
        }))
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.bottom.equalToSuperview().inset(Layout.commonInset)
        }
        
        reloadRows()
        
        view.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.stackView.getAllRows().forEach({ $0.resignFirstResponder() })
        }))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackView.getAllRows().forEach({ ($0 as? EditableTextFieldView)?.setupGradient() })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadRows()
    }
    
    func reloadRows() {
        stackView.removeAllRows()
        
        let addressField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
                title: "Address",
                text: viewModel.address,
                type: .address,
                didEndEdititng: { string in
                    
            })
        )
        
        
        let nameField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
                title: "Name",
                text: viewModel.userName,
                type: .standard,
                didEndEdititng: { [weak self] name in
                    self?.viewModel.userName = name
            })
        )
        
        
        let phoneField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
                title: "Phone",
                text: viewModel.phone,
                type: .phone,
                didEndEdititng: { [weak self] phone in
                    self?.viewModel.phone = phone
            })
        )
        
        let creditCardField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
                title: "Credit Card",
                text: Formatter.CreditCard.hiddenNumber(string: viewModel.creditCardNumber) ?? "",
                type: .creditCard,
                didEndEdititng: { _ in })
        )
        
        stackView.addRows([addressField, nameField, phoneField, creditCardField])
        
        // App info
        
        let signOutButton = UIButton.makeCommonButton("Sign out") { [weak self] _ in
            NotificationCenter.default.post(Notification(name: .userLoggedOut))
            self?.viewModel.clearUserInfo()
        }
        signOutButton.setTitleColor(Colors.red.color, for: .normal)
        signOutButton.titleLabel?.font = FontFamily.regular
        
        let appInfoLabel = UILabel.makeSmallText("Daily Menu. Version \(Bundle.versionNumber)")
        #if DEBUG
        appInfoLabel.text = "Daily Menu Version \(Bundle.versionNumber). Build \(Bundle.buildNumber)"
        #endif
        appInfoLabel.textColor = Colors.gray.color
        appInfoLabel.textAlignment = .center
        
        stackView.addRows([signOutButton, appInfoLabel])
        stackView.setInset(forRow: signOutButton, inset: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
    }
    
}

//MARK: -  SettingsView
extension SettingsViewController: SettingsView {
    
}

//MARK: -  Private
private extension SettingsViewController {
    
}


