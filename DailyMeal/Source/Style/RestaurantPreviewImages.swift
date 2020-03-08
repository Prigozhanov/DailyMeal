//
//  Created by Vladimir on 2/19/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

struct RestaurantPreviewImages {
    
    static func getRestaurantPreviewByCategory(_ category: FoodCategory) -> UIImage {
        switch category {
        case .burger:
            return Images.Category.burger.image
        case .pizza:
            return Images.Category.pizza.image
        case .hotdog:
            return Images.Category.hotdog.image
        case .shawarma:
            return Images.Category.shawarma.image
        case .pasta:
            return Images.Category.pasta.image
        case .sushi:
            return Images.Category.sushi.image
        default:
            return Images.Category.placeholder.image
        }
    }
    
    static func getPreviewByRestaurantId(_ id: Int) -> UIImage? {
        switch id {
        case 484:
            return Images.Restaurants.mcdonalds.image
        case 47:
            return Images.Restaurants.pzz.image
        default:
            return nil
        }
    }
    
}
