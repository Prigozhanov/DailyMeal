//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

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
