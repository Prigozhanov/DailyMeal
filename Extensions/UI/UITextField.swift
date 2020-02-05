//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

extension UITextField {
  static func makeCommonTextField(_ placeholder: String? = "") -> UITextField {
    let input = UITextField(frame: .zero)
    input.layer.cornerRadius = Layout.cornerRadius
    input.backgroundColor = Colors.backgroundGray.color
    input.layer.borderColor = Colors.lightGray.color.cgColor
    input.layer.borderWidth = .onePixel
    input.placeholder = placeholder
    return input
  }
}
