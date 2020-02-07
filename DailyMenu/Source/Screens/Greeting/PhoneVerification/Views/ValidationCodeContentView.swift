//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class ValidationCodeContentView: UIView {
    
    struct Item {
        let phoneNumber: String
        let onSendCode: StringClosure
    }
    
    private var item: Item
    private var validationCode: String
    private var phoneNumber: String
    
    private lazy var firstContainer = SingleInputValidationCodeView(item: { [weak self] singleDigitString in
        self?.validationCode.append(singleDigitString)
        self?.secondContainer.textField.becomeFirstResponder()
    })
    private lazy var secondContainer = SingleInputValidationCodeView(item: { [weak self] singleDigitString in
        self?.validationCode.append(singleDigitString)
        self?.thirdContainer.textField.becomeFirstResponder()
    })
    private lazy var thirdContainer = SingleInputValidationCodeView(item: { [weak self] singleDigitString in
        self?.validationCode.append(singleDigitString)
        self?.forthContainer.textField.becomeFirstResponder()
    })
    private lazy var forthContainer = SingleInputValidationCodeView(item: { [weak self] singleDigitString in
        self?.validationCode.append(singleDigitString)
        self?.item.onSendCode(self?.validationCode ?? "")
    })
    
    private lazy var singleInputsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
    
        stack.addArrangedSubview(firstContainer)
        stack.addArrangedSubview(secondContainer)
        stack.addArrangedSubview(thirdContainer)
        stack.addArrangedSubview(forthContainer)
        
        stack.isUserInteractionEnabled = false
        
        return stack
    }()
    
    init(item: Item) {
        self.item = item
        validationCode = ""
        phoneNumber = ""
        
        super.init(frame: .zero)
        
        let cardView = CardView(shadowSize: .large, customInsets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        let titleLabel = UILabel.makeText("Enter validation code")
        titleLabel.font = FontFamily.Poppins.medium.font(size: 16)
        titleLabel.textAlignment = .center
        let subtitleLabel = UILabel.makeText("A verification code is sent to your number provided \(phoneNumber)")
        subtitleLabel.font = FontFamily.Poppins.regular.font(size: 12)
        subtitleLabel.textColor = Colors.gray.color
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 3
        
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        cardView.contentView.addSubviews([titleLabel, subtitleLabel, singleInputsStack])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        singleInputsStack.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(Layout.commonInset)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        firstContainer.textField.becomeFirstResponder()
    }

    func onErrorAction() {
        shakeAnimation()
        firstContainer.textField.text = ""
        secondContainer.textField.text = ""
        thirdContainer.textField.text = ""
        forthContainer.textField.text = ""
        validationCode = ""
        firstContainer.textField.becomeFirstResponder()
    }
    
}
