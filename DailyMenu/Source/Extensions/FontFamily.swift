//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

extension FontFamily {
    
    public static var bold: UIFont? {
        return Poppins.bold.font(size: 15)
    }
    
    
    public static var light: UIFont? {
        return Poppins.light.font(size: 15)
    }
    
    public static var semibold: UIFont? {
        return Poppins.semiBold.font(size: 14)
    }
    
    public static var regular: UIFont? {
        return Poppins.regular.font(size: 15)
    }
    
    public static var smallRegular: UIFont? {
        return Poppins.regular.font(size: 12)
    }
    
    public static var extraSmallRegular: UIFont? {
        return Poppins.regular.font(size: 9)
    }
    
    public static var largeRegular: UIFont? {
        return Poppins.regular.font(size: 18)
    }
    
    public static var smallMedium: UIFont? {
        return Poppins.medium.font(size: 12)
    }
    
}
