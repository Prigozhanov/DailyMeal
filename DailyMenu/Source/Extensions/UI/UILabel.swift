//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
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
