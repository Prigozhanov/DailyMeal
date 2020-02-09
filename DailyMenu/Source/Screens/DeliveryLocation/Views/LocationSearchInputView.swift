//
//  Created by Vladimir on 2/9/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class LocationSearchInputView: UIView {
    
    struct Item {
        let onUserLocationButtonTapped: VoidClosure
        let shouldChangeCharacters: StringClosure
    }
    
    private var item: Item
    
    var text: String? {
        get {
            textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    private lazy var searchIcon: UIButton = {
        let button = UIButton.makeImageButton(image: Images.Icons.search.image) { [weak self] _ in
            self?.textField.becomeFirstResponder()
        }
        button.contentMode = .scaleAspectFit
        button.tintColor = Colors.gray.color
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.font = FontFamily.Poppins.medium.font(size: 14)
        textField.placeholder = "Type delivery location"
        textField.tintColor = Colors.gray.color
        textField.delegate = self
        return textField
    }()
    
    private lazy var userLocationButton: UIButton = {
        let button = UIButton.makeImageButton(image: Images.Icons.location.image) { [weak self] _ in
            self?.item.onUserLocationButtonTapped()
        }
        button.contentMode = .scaleAspectFit
        button.tintColor = Colors.gray.color
        return button
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        backgroundColor = Colors.white.color
        
        addSubviews([searchIcon, textField, userLocationButton])
        
        searchIcon.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.width.equalTo(30).priority(.required)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(searchIcon.snp.trailing).offset(Layout.commonMargin)
            $0.trailing.equalTo(userLocationButton.snp.leading).offset(-Layout.largeMargin).priority(.required)
        }
        
        userLocationButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.width.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}

extension LocationSearchInputView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            item.shouldChangeCharacters(text.appending(string))
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
