//
//  Created by Vladimir on 2/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class CardInfoView: UIView {
    
    typealias Item = (Details) -> Void
    
    struct Details {
        var number: String
        var year: String
        var month: String
        var cvv: String
    }
    
    private var item: Item
    private var details: Details
    
    private lazy var cardNumberTextField: TextField = {
        let textField = TextField(
            placeholder: "Card number",
            shouldChangeCharacters: { [weak self] (textField, range, string) -> Bool in
                if range.location == 19 { // reached the end of formatted card nubmer input
                    self?.expireDateMonthTextField.becomeFirstResponder()
                    return true
                }
                if let formattedText = textField.text {
                    let text = formattedText.replacingOccurrences(of: " ", with: "")
                    if Formatter.CreditCard.shouldChange(string: text.appending(string), maxCharacters: 16) {
                        self?.details.number = text.appending(string)
                        if text.count % 4 == 0, !string.isEmpty {
                            textField.text = formattedText.replacingOccurrences(of: formattedText, with: "\(formattedText) ")
                        }
                        return true
                    }
                }
                return false
        })
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var expireDateMonthTextField: TextField = {
        let textField = TextField(
            shouldShowClearButton: false,
            textAlignment: .center,
            shouldChangeCharacters: { [weak self] (textField, range, string) -> Bool in
                if range.location == 2 {
                    self?.expireDateYearTextField.becomeFirstResponder()
                    return true
                }
                if let text = textField.text {
                    if Formatter.CreditCard.shouldChange(string: text.appending(string), maxCharacters: 2) {
                        self?.details.month = text.appending(string)
                        return true
                    }
                }
                return false
        })
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var expireDateYearTextField: TextField = {
        let textField = TextField(
            shouldShowClearButton: false,
            textAlignment: .center,
            shouldChangeCharacters: { [weak self] (textField, range, string) -> Bool in
                if range.location == 2 {
                    self?.securityCodeTextField.becomeFirstResponder()
                    return true
                }
                if let text = textField.text {
                    if Formatter.CreditCard.shouldChange(string: text.appending(string), maxCharacters: 2) {
                        self?.details.year = text.appending(string)
                        return true
                    }
                }
                return false
        })
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var securityCodeTextField: TextField = {
        let textField = TextField(
            placeholder: "CVV",
            shouldShowClearButton: false,
            textAlignment: .center,
            shouldChangeCharacters: { [weak self] (textField, _, string) -> Bool in
                if let text = textField.text {
                    if Formatter.CreditCard.shouldChange(string: text.appending(string), maxCharacters: 3) {
                        self?.details.cvv = text.appending(string)
                        return true
                    }
                }
                return false
        })
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var saveCreditCardDetailsButton: UIButton = {
        let button = ActionButton("Save Card details") { [weak self] _ in
            guard let self = self else { return }
            self.item(self.details)
        }
        return button
    }()
    
    init(item: @escaping Item) {
        self.item = item
        details = Details(number: "", year: "", month: "", cvv: "")
        
        super.init(frame: .zero)
        let cardView = CardView(shadowSize: .large, customInsets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        let titleLabel = UILabel.makeText("Enter your credit card details")
        titleLabel.numberOfLines = 2
        titleLabel.font = FontFamily.Poppins.semiBold.font(size: 18)
        titleLabel.textColor = Colors.smoke.color
        cardView.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        let cardNumberLabel = UILabel.makeText("Card number")
        cardView.contentView.addSubview(cardNumberLabel)
        cardNumberLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        cardView.contentView.addSubview(cardNumberTextField)
        cardNumberTextField.snp.makeConstraints {
            $0.top.equalTo(cardNumberLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
        
        let expireDateLabel = UILabel.makeText("Expire Date")
        cardView.contentView.addSubview(expireDateLabel)
        expireDateLabel.snp.makeConstraints {
            $0.top.equalTo(cardNumberTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(Layout.commonInset)
        }
        
        cardView.contentView.addSubview(expireDateMonthTextField)
        expireDateMonthTextField.snp.makeConstraints {
            $0.top.equalTo(expireDateLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
            $0.width.equalTo(43)
        }
        
        let slashSymbol = UILabel.makeText("/")
        cardView.contentView.addSubview(slashSymbol)
        slashSymbol.snp.makeConstraints {
            $0.centerY.equalTo(expireDateMonthTextField.snp.centerY)
            $0.leading.equalTo(expireDateMonthTextField.snp.trailing).offset(4)
        }
        
        cardView.contentView.addSubview(expireDateYearTextField)
        expireDateYearTextField.snp.makeConstraints {
            $0.top.equalTo(expireDateLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.equalTo(slashSymbol.snp.trailing).offset(4)
            $0.height.equalTo(50)
            $0.width.equalTo(43)
        }
        
        let securityCodeLabel = UILabel.makeText("Security Code")
        cardView.contentView.addSubview(securityCodeLabel)
        securityCodeLabel.snp.makeConstraints {
            $0.top.equalTo(cardNumberTextField.snp.bottom).offset(20)
            $0.leading.equalTo(expireDateLabel.snp.trailing).offset(Layout.commonMargin)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.width.equalTo(100)
        }
        
        cardView.contentView.addSubview(securityCodeTextField)
        securityCodeTextField.snp.makeConstraints {
            $0.top.equalTo(securityCodeLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.greaterThanOrEqualTo(expireDateYearTextField.snp.trailing).offset(Layout.commonMargin)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        cardView.contentView.addSubview(saveCreditCardDetailsButton)
        saveCreditCardDetailsButton.snp.makeConstraints {
            $0.top.equalTo(securityCodeTextField.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
