//
//  Created by Vladimir on 2/10/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class EditableTextFieldView: UIView {
    
    struct Item {
        let title: String
        let text: String
        let type: FieldType
        let didEndEdititng: StringClosure
    }
    
    enum FieldType {
        case standard, phone, creditCard, address
    }
    
    private let item: Item
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textColor = Colors.charcoal.color
        textField.font = FontFamily.Poppins.light.font(size: 13)
        textField.delegate = self
        
        textField.addGestureRecognizer(BlockTap(action: { _ in
            
        }))
        
        return textField
    }()
    
    lazy var changeButton: UIButton = {
        let button = UIButton.makeActionButton("Change") { [weak self] button in
            button.tapAnimation()
            self?.textField.becomeFirstResponder()
        }
        button.titleLabel?.font = FontFamily.Poppins.light.font(size: 13)
        return button
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        let textFieldContainer = UIView()
        textFieldContainer.backgroundColor = Colors.white.color
        textFieldContainer.setRoundCorners(Layout.cornerRadius)
        textFieldContainer.setBorder(width: 0.5, color: Colors.lightGray.color)
        
        let titleLabel = UILabel.makeText(item.title)
        titleLabel.font = FontFamily.Poppins.light.font(size: 10)
        
        addSubviews([textFieldContainer, titleLabel])
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalTo(textFieldContainer.snp.top).inset(-10)
        }
        
        textFieldContainer.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        textFieldContainer.addSubviews([textField, changeButton])
        textField.text = item.text
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.commonInset)
            $0.top.bottom.equalToSuperview().inset(5)
            $0.trailing.equalTo(changeButton.snp.leading).offset(-20)
        }
        
        changeButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(100)
        }
        
        setupType()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupType() {
        switch item.type {
        case .phone:
            textField.keyboardType = .phonePad
        case .creditCard:
            let buttonLabelText = (textField.text ?? "").isEmpty ? "Add" : "Change"
            textField.keyboardType = .numberPad
            changeButton.setTitle(buttonLabelText, for: .normal)
            changeButton.setActionHandler(controlEvents: .touchUpInside) { [weak self] button in
                button.tapAnimation()
                let vc = AddCreditCardViewController(
                    viewModel: AddCreditCardViewModelImplementation(onSaveSuccess: { [weak self] creditCardNumber in
                        self?.textField.text = Formatter.CreditCard.hiddenNumber(string: creditCardNumber)
                    })
                )
                vc.modalPresentationStyle = .overCurrentContext
                UIApplication.topViewController?.show(vc, sender: nil)
            }
        case .address:
            changeButton.setActionHandler(controlEvents: .touchUpInside) { button in
                button.tapAnimation()
                let vc = DeliveryLocationViewController(viewModel: DeliveryLocationViewModelImplementation())
                vc.modalPresentationStyle = .overCurrentContext
                UIApplication.topViewController?.show(vc, sender: nil)
            }
        default:
            
            break
        }
    }
    
    func setupGradient() {
        Style.addBlueGradient(changeButton)
    }
    
    override func resignFirstResponder() -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension EditableTextFieldView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            item.didEndEdititng(text)
        }
        textField.resignFirstResponder()
        return true
    }
    
}
