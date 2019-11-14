//
// Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit


extension UIInputView {
  static func makeCommonInput(_ placeholder: String? = "") -> UIInputView {
    let input = UIInputView(frame: .zero)
    input.layer.cornerRadius = Layout.cornerRadius
    input.backgroundColor = Colors.lightGray.color
    input.layer.borderColor = Colors.gray.color.cgColor
    input.layer.borderWidth = .onePixel
    return input
  }
}
