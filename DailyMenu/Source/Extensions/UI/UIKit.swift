//
//  UIKit.swift
//  DailyMenu
//


import UIKit

extension UILabel {
  
  static func makeSmallText(_ text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = UIFont.systemFont(ofSize: 15)
    return label
  }
  
  static func makeMediumText(_ text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = UIFont.systemFont(ofSize: 17)
    return label
    
  }
  
  static func makeLargeText(_ text: String) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = UIFont.systemFont(ofSize: 19)
    return label
  }
}

extension UIButton {
  static func makeCommonButton(_ text: String, action: @escaping (UIButton) -> Void) -> UIButton {
    let button = UIButton()
    button.setTitle(text, for: .normal)
    button.setTitleColor(.d_commonBlue, for: .normal)
    button.setActionHandler(controlEvents: .touchUpInside, ForAction: action)
    return button
  }
  
  static func makeGrayButton(_ text: String, action: @escaping (UIButton) -> Void) -> UIButton {
    let button = UIButton()
    button.setAttributedTitle(NSAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]), for: .normal)
    button.setActionHandler(controlEvents: .touchUpInside, ForAction: action)
    return button
  }
  
  static func makeHugeButton(_ text: String, action: @escaping (UIButton) -> Void) -> UIButton {
    let button = UIButton()
    button.layer.cornerRadius = Layout.cornerRadius
    button.snp.makeConstraints { (make) in
      make.height.equalTo(50)
      make.width.equalTo(300)
    }
    button.backgroundColor = .d_commonBlue
    button.setTitle(text, for: .normal)
    button.setActionHandler(controlEvents: .touchUpInside, ForAction: action)
    return button
  }
}
extension UIInputView {
  static func makeCommonInput(_ placeholder: String? = "") -> UIInputView {
    let input = UIInputView(frame: .zero)
    input.layer.cornerRadius = Layout.cornerRadius
    input.backgroundColor = .d_lightGray
    input.layer.borderColor = UIColor.d_gray.cgColor
    input.layer.borderWidth = .onePixel
    return input
  }
}

extension UIStackView {
  static func makeHorizontalStack() -> UIStackView {
    let stack = UIStackView()
    stack.distribution = .fillEqually
    stack.alignment = .center
    stack.axis = .horizontal
    return stack
  }
  
  static func makeVerticalStack() -> UIStackView {
    let stack = UIStackView()
    stack.distribution = .fillEqually
    stack.alignment = .center
    stack.axis = .vertical
    return stack
  }
  
}
