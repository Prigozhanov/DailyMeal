//
// Created by Vladimir on 11/11/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {}
    
}
