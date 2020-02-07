//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Extensions
import Networking

class SendPhoneVerificationViewController: UIViewController {
    
    private lazy var contentView = PhoneNumberVerificationContentView(item:
        PhoneNumberVerificationContentView.Item(onSendPhone: { [weak self] phoneNumber in
            self?.sendPushGeneration(phoneNumber: phoneNumber)
        }))
    
    private var context: AppContext
    
    init() {
        self.context = AppDelegate.shared.context
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = Colors.commonBackground.color
        
        let titleLabel = UILabel.makeText("Phone verification")
        titleLabel.font = FontFamily.Poppins.medium.font(size: 16)
        
        view.addSubviews([titleLabel, contentView])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(70)
            $0.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.setupGradient()
    }
    
    private func sendPushGeneration(phoneNumber: String) {
        let req = Requests.generateToken(phone: "+\(phoneNumber)")
        LoadingIndicator.show(self)
        context.networkService.send(request: req) { [weak self] result in
            LoadingIndicator.hide()
            switch result {
            case .success:
                self?.navigationController?.pushViewController(
                    EnterValidationCodePhoneVerificationViewController(phoneNumber: phoneNumber),
                    animated: true
                )
            case .failure:
                self?.contentView.onErrorAction()
            }
        }
    }
}
