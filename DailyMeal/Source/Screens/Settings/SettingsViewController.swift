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
	
	private lazy var signOutButton: UIButton = {
		let button = UIButton.makeCommonButton(Localizable.Settings.signOut) { [weak self] _ in
			NotificationCenter.default.post(Notification(name: .userLoggedOut))
			self?.viewModel.clearUserInfo()
		}
		button.setTitleColor(Colors.red.color, for: .normal)
		button.titleLabel?.font = FontFamily.book
		return button
	}()
	
	private lazy var signInButton: UIButton = {
		let button = ActionButton(Localizable.Settings.signIn) { [weak self] _ in
			NotificationCenter.default.post(Notification(name: .userLoggedOut))
			self?.viewModel.clearUserInfo()
		}
		return button
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
        
		if viewModel.isUserLoggedIn {
			stackView.addRow(signOutButton)
			stackView.setInset(forRow: signOutButton, inset: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
		} else {
			stackView.addRow(signInButton)
			stackView.setInset(forRow: signInButton, inset: UIEdgeInsets(top: 100, left: Layout.largeMargin, bottom: 0, right: Layout.largeMargin))
			signInButton.snp.makeConstraints {
				$0.height.equalTo(50)
			}
		}
        
		let appInfoLabel = UILabel.makeSmallText("Daily Meal. \(Localizable.Settings.version) \(Bundle.versionNumber)")
        #if DEBUG
		appInfoLabel.text = "Daily Meal \(Localizable.Settings.version) \(Bundle.versionNumber). \(Localizable.Settings.build) \(Bundle.buildNumber)"
        #endif
        appInfoLabel.textColor = Colors.gray.color
        appInfoLabel.textAlignment = .center
        
        stackView.addRow(appInfoLabel)
    }
    
}

// MARK: - SettingsView
extension SettingsViewController: SettingsView {
    
}

// MARK: - Private
private extension SettingsViewController {
    
}
