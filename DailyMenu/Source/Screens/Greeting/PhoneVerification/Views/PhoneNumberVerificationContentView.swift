//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class PhoneNumberVerificationContentView: UIView {
    
    struct Item {
        let onSendPhone: StringClosure
    }
    
    private var item: Item
    private var phoneNumber: String
    
    private lazy var textField: TextField = {
        let field = TextField(
            placeholder: "+375",
            shouldShowClearButton: true,
            shouldChangeCharacters: { [weak self] (textField, _, string) -> Bool in
                if string.isEmpty {
                    return true
                }
                let text = textField.text?.replacingOccurrences(of: "+", with: "")
                if let formattedText = textField.text,
                    Formatter.PhoneNumber.shouldChange(string: text?.appending(string), maxCharacters: 15) {
                    self?.phoneNumber = text?.appending(string) ?? ""
                    textField.text = Formatter.PhoneNumber.formattedString(text?.appending(string)) ?? ""
                    return false
                }
                return false
        }) { textField -> Bool in
            textField.resignFirstResponder()
            return true
        }
        field.setKeyboardType(.phonePad)
        return field
    }()
    
    private lazy var sendPhoneButton = UIButton.makeActionButton("Send verification code") { [unowned self] button in
        button.tapAnimation()
        self.item.onSendPhone(self.phoneNumber)
    }
    
    
    init(item: Item) {
        self.item = item
        self.phoneNumber = ""
        
        super.init(frame: .zero)
        
        let cardView = CardView(shadowSize: .large, customInsets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        let titleLabel = UILabel.makeText("Enter your phone number")
        titleLabel.font = FontFamily.Poppins.medium.font(size: 16)
        titleLabel.textAlignment = .center
        let subtitleLabel = UILabel.makeText("We will send a code to your number. Standard data charge may apply")
        subtitleLabel.font = FontFamily.Poppins.regular.font(size: 12)
        subtitleLabel.textColor = Colors.gray.color
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 3
        
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        cardView.contentView.addSubviews([titleLabel, subtitleLabel, textField, sendPhoneButton])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
        
        sendPhoneButton.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setupGradient() {
        Style.addBlueGradient(sendPhoneButton)
    }
    
    func onErrorAction() {
        shakeAnimation()
        textField.text = ""
    }
    
    
}
