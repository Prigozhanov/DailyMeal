//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

typealias Colors = Asset.Colors
typealias Images = Asset.Images

extension UIResponder {
    
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }

}

extension CGFloat {
    
  static var onePixel: CGFloat {
    return 1 / UIScreen.main.scale
  }
    
}
