//
//  Created by Vladimir on 2/5/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class TextField: UIView {
    
    private var shouldShowClearButton: Bool
    
    private var shouldChangeCharacters: ((UITextField, NSRange, String) -> Bool)?
    private var shouldBeginEditing: ((UITextField) -> Bool)?
    private var didBeginEditing: ((UITextField) -> Void)?
    private var shouldEndEditing: ((UITextField) -> Bool)?
    private var didEndEditing: ((UITextField, UITextField.DidEndEditingReason) -> Void)?
    private var didChangeSelection: ((UITextField) -> Void)?
    private var shouldClear: ((UITextField) -> Bool)?
    private var shouldReturn: ((UITextField) -> Bool)?
    
    private var image: UIImage?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.textColor = Colors.charcoal.color
        return textField
    }()
    
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView(image: image?.withRenderingMode(.alwaysTemplate))
        view.setRoundCorners(Layout.cornerRadius, maskedCorners: [.layerMaxXMaxYCorner, .layerMinXMinYCorner])
        view.contentMode = .scaleAspectFit
        view.tintColor = Colors.gray.color
        return view
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton.makeImageButton(image: Images.Icons.cancel.image.withRenderingMode(.alwaysTemplate)) { [weak self] button in
            self?.textField.text = ""
            button.isHidden = true
        }
        button.isHidden = true
        button.contentMode = .scaleAspectFit
        button.tintColor = Colors.gray.color
        return button
    }()
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
            guard let newValue = newValue else {
                return
            }
            clearButton.isHidden = newValue.isEmpty
        }
    }
    
    init(
        placeholder: String? = nil,
        image: UIImage? = nil,
        shouldShowClearButton: Bool = true,
        shouldChangeCharacters: ((UITextField, NSRange, String) -> Bool)? = nil,
        shouldBeginEditing: ((UITextField) -> Bool)? = nil,
        didBeginEditing: ((UITextField) -> Void)? = nil,
        shouldEndEditing: ((UITextField) -> Bool)? = nil,
        didEndEditing: ((UITextField, UITextField.DidEndEditingReason) -> Void)? = nil,
        didChangeSelection: ((UITextField) -> Void)? = nil,
        shouldClear: ((UITextField) -> Bool)? = nil,
        shouldReturn: ((UITextField) -> Bool)? = nil
    ) {
        self.shouldShowClearButton = shouldShowClearButton
        self.image = image
        self.shouldChangeCharacters = shouldChangeCharacters
        self.shouldBeginEditing = shouldBeginEditing
        self.didBeginEditing = didBeginEditing
        self.shouldEndEditing = shouldEndEditing
        self.didEndEditing = didEndEditing
        self.didChangeSelection = didChangeSelection
        self.shouldClear = shouldClear
        self.shouldReturn = shouldReturn
        
        super.init(frame: .zero)
        
        setRoundCorners(Layout.cornerRadius)
        backgroundColor = Colors.backgroundGray.color
        layer.borderColor = Colors.lightGray.color.cgColor
        layer.borderWidth = .onePixel
        textField.placeholder = placeholder
        
        addSubviews([leftImageView, textField, clearButton])
        
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.commonInset).priority(.high)
            $0.trailing.equalToSuperview().inset(4).priority(.high)
            $0.top.bottom.equalToSuperview()
        }
        
        if image != nil {
            leftImageView.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(10)
                $0.leading.equalToSuperview().inset(5)
                $0.width.equalTo(snp.height)
                $0.trailing.equalTo(textField.snp.leading).offset(-Layout.commonInset).priority(.required)
            }
        }
        
        if shouldShowClearButton {
            clearButton.snp.makeConstraints {
                $0.top.bottom.trailing.equalToSuperview().inset(Layout.commonInset)
                $0.width.equalTo(20)
                $0.leading.equalTo(textField.snp.trailing).priority(.required)
            }
        }
        
        addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.textField.becomeFirstResponder()
        }))
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}

extension TextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.shouldChangeCharacters?(textField, range, string) ?? true {
            clearButton.isHidden = ((textField.text ?? "") + string).isEmpty || (string.isEmpty && range.location == 0)
            return true
        }
        return false
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return shouldBeginEditing?(textField) ?? true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearButton.isHidden = textField.text?.isEmpty ?? true
        didBeginEditing?(textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return shouldEndEditing?(textField) ?? true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        clearButton.isHidden = true
        didEndEditing?(textField, reason)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        didChangeSelection?(textField)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return shouldClear?(textField) ?? true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return shouldReturn?(textField) ?? true
    }
    
}

extension TextField {
    
    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func setSecureEntry(_ secure: Bool) {
        textField.isSecureTextEntry = secure
    }
    
}
