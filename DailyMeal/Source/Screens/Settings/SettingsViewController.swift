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
	
	private let headerView: UIView = {
		let view = UIView()
		let imageView = UIImageView(image: Images.Placeholders.dailyLogo.image)
		
		view.addSubview(imageView)
		imageView.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide)
			$0.leading.trailing.bottom.equalToSuperview()
		}
		imageView.contentMode = .scaleAspectFit
		return view
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
        
        view.addSubviews([headerView, stackView])
		
		headerView.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
			$0.height.equalTo(150)
		}
        
		stackView.snp.makeConstraints {
			$0.top.equalTo(headerView.snp.bottom)
			$0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
		}
		
        reloadRows()
        
        view.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.stackView.getAllRows().forEach({ $0.resignFirstResponder() })
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadRows()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		Style.addBlueGradient(headerView)
	}
    
    func reloadRows() {
        stackView.removeAllRows()
        let addressField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
				title: Localizable.Settings.address,
                text: viewModel.address,
                type: .address,
                didEndEdititng: { _ in
                    
            })
        )
        
        let nameField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
				title: Localizable.Settings.name,
                text: viewModel.userName,
                type: .standard,
                didEndEdititng: { [weak self] name in
                    self?.viewModel.userName = name
            })
        )
        
        let phoneField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
				title: Localizable.Settings.phone,
                text: viewModel.phone,
                type: .phone,
                didEndEdititng: { [weak self] phone in
                    self?.viewModel.phone = phone
            })
        )
        
        let creditCardField: EditableTextFieldView = EditableTextFieldView(
            item: EditableTextFieldView.Item(
				title: Localizable.Settings.creditCard,
                text: Formatter.CreditCard.hiddenNumber(string: viewModel.creditCardNumber) ?? "",
                type: .creditCard,
                didEndEdititng: { _ in })
        )
        
        stackView.addRows([addressField, nameField, phoneField, creditCardField])
        
        // App info
        
		let signOutButton = UIButton.makeCommonButton(Localizable.Settings.signOut) { [weak self] _ in
            NotificationCenter.default.post(Notification(name: .userLoggedOut))
            self?.viewModel.clearUserInfo()
        }
        signOutButton.setTitleColor(Colors.red.color, for: .normal)
        signOutButton.titleLabel?.font = FontFamily.book
        
		let appInfoLabel = UILabel.makeSmallText("Daily Menu. \(Localizable.Settings.version) \(Bundle.versionNumber)")
        #if DEBUG
		appInfoLabel.text = "Daily Menu \(Localizable.Settings.version) \(Bundle.versionNumber). \(Localizable.Settings.build) \(Bundle.buildNumber)"
        #endif
        appInfoLabel.textColor = Colors.gray.color
        appInfoLabel.textAlignment = .center
        
        stackView.addRows([signOutButton, appInfoLabel])
        stackView.setInset(forRow: signOutButton, inset: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
    }
    
}

// MARK: - SettingsView
extension SettingsViewController: SettingsView {
    
}

// MARK: - Private
private extension SettingsViewController {
    
}
