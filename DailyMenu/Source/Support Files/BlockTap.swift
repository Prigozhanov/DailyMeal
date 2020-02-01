//
//  Created by Vladimir on 1/27/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

open class BlockTap: UITapGestureRecognizer {
    private var tapAction: ((UITapGestureRecognizer) -> Void)?
    
    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    public convenience init(tapCount: Int = 1, fingerCount: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        self.init()
        
        numberOfTapsRequired = tapCount
        numberOfTouchesRequired = fingerCount
        
        tapAction = action
        addTarget(self, action: #selector(BlockTap.didTap(_:)))
    }
    
    @objc open func didTap(_ tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            tapAction?(tap)
        }
    }
}
