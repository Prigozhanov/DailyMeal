//
//  Created by Vladimir on 2/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class CardInfoView: UIView {
    
    private lazy var cardNumberTextField: TextField = {
        let textField = TextField(
            placeholder: "Card number",
            shouldChangeCharacters: { (_, _, _) -> Bool in
                true
        },
            shouldBeginEditing: { (_) -> Bool in
                true
        },
            didBeginEditing: { (_) in
                
        },
            shouldEndEditing: { (_) -> Bool in
                true
        },
            didEndEditing: { (_, _) in
                
        },
            didChangeSelection: { (_) in
                
        },
            shouldClear: { (_) -> Bool in
                true
        }) { [weak self] (_) -> Bool in
            return true
        }
        textField.setKeyboardType(.numberPad)
        return textField
    }()
    
    private lazy var expireDateMonthTextField: TextField = {
        let textField = TextField(
            shouldShowClearButton: false,
            shouldChangeCharacters: { (field, range, string) -> Bool in
                return true
        },
            shouldBeginEditing: { (_) -> Bool in
                true
        },
            didBeginEditing: { (_) in
                
        },
            shouldEndEditing: { (_) -> Bool in
                true
        },
            didEndEditing: { (_, _) in
                
        },
            didChangeSelection: { (_) in
                
        },
            shouldClear: { (_) -> Bool in
                true
        }) { (_) -> Bool in
            true
        }
        textField.setKeyboardType(.numberPad)
        return textField
    }()
    
    private lazy var expireDateYearTextField: TextField = {
        let textField = TextField(
            shouldShowClearButton: false,
            shouldChangeCharacters: { (field, range, string) -> Bool in
                return true
        },
            shouldBeginEditing: { (_) -> Bool in
                true
        },
            didBeginEditing: { (_) in
                
        },
            shouldEndEditing: { (_) -> Bool in
                true
        },
            didEndEditing: { (_, _) in
                
        },
            didChangeSelection: { (_) in
                
        },
            shouldClear: { (_) -> Bool in
                true
        }) { (_) -> Bool in
            true
        }
        textField.setKeyboardType(.numberPad)
        return textField
    }()
    
    private lazy var securityCodeTextField: TextField = {
        let textField = TextField(
            placeholder: "CVV",
            shouldChangeCharacters: { (_, _, _) -> Bool in
                true
        },
            shouldBeginEditing: { (_) -> Bool in
                true
        },
            didBeginEditing: { (_) in
                
        },
            shouldEndEditing: { (_) -> Bool in
                true
        },
            didEndEditing: { (_, _) in
                
        },
            didChangeSelection: { (_) in
                
        },
            shouldClear: { (_) -> Bool in
                true
        }) { (_) -> Bool in
            true
        }
        textField.setKeyboardType(.numberPad)
        return textField
    }()
    
    private let saveCreditCardDetailsButton: UIButton = {
        let button = UIButton.makeActionButton("Save Card details") { view in
            view.tapAnimation()
        }
        return button
    }()
    
    init() {
        
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
            $0.width.equalTo(cardNumberTextField.snp.width).multipliedBy(0.2)
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
            $0.width.equalTo(cardNumberTextField.snp.width).multipliedBy(0.2)
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
    
    func setupGradient() {
        Style.addBlueGradient(saveCreditCardDetailsButton)
    }
    
}
