//
//  Created by Vladimir on 2/2/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageByCategory(_ category: FoodCategory) {
            switch category {
            case .burger:
                self.image = Images.Category.burger.image
            case .pizza:
                self.image = Images.Category.pizza.image
            case .hotdog:
                self.image = Images.Category.hotdog.image
            default:
                break
            }
    }
    
}
