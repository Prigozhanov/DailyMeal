//
//  Created by Vladimir on 2/6/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class SingleInputValidationCodeView: UIView {
    
    typealias Item = StringClosure
    
    private let item: Item
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = FontFamily.Poppins.medium.font(size: 20)
        textField.tintColor = .clear
        textField.delegate = self
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let underline = UIView.makeSeparator()
    
    init(item: @escaping Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.backgroundGray.color
        setRoundCorners(Layout.cornerRadius)
        setBorder(width: 1, color: Colors.lightGray.color)
        
        snp.makeConstraints {
            $0.width.equalTo(40)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.top.equalToSuperview().inset(10)
        }
        
        underline.backgroundColor = Colors.gray.color
        addSubview(underline)
        underline.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.textField.becomeFirstResponder()
        }))
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func clear() {
        textField.text = ""
        underline.isHidden = false
    }
}

extension SingleInputValidationCodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 {
            underline.isHidden = true
            item(string)
            textField.text = string
            textField.resignFirstResponder()
            return false
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        false
    }
    
}
