//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

extension FontFamily {
    
    public static var black: UIFont? {
        return Avenir.black.font(size: 15)
    }
    
    public static var light: UIFont? {
        return Avenir.light.font(size: 15)
    }
    
    public static var book: UIFont? {
        return Avenir.book.font(size: 14)
    }
    
    public static var smallRegular: UIFont? {
        return Avenir.book.font(size: 10)
    }
    
    public static var extraSmallRegular: UIFont? {
        return Avenir.book.font(size: 9)
    }
    
    public static var largeRegular: UIFont? {
        return Avenir.book.font(size: 18)
    }
    
    public static var smallMedium: UIFont? {
        return Avenir.medium.font(size: 12)
    }
    
    public static var medium: UIFont? {
        return Avenir.medium.font(size: 14)
    }
	
	public static var extraSmallMedium: UIFont? {
		return Avenir.medium.font(size: 10)
	}
    
}
