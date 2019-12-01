//
//  Created by Vladimir on 12/1/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var statusBar: UIView? {
        guard let statusBar = value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return nil}
        return statusBar
    }
    
}
