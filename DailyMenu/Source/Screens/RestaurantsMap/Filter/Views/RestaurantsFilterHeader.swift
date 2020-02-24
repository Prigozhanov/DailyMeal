//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RestaurantsFilterHeader: UIView {
    
    struct Item {
        let onHideControlsAction: VoidClosure
    }
    
    private let item: Item
    
    var isExpanded = true
    
    private var headerLabel: UILabel = {
        let label = UILabel.makeText("Filter")
        label.font = FontFamily.medium
        return label
    }()
    
    private lazy var hideControlsButton: UIButton = {
        let button = UIButton.makeImageButton(image: Images.Icons.cross.image) { [weak self] _ in
            self?.item.onHideControlsAction()
        }
        button.tintColor = Colors.charcoal.color
        return button
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.white.color
        setBorder(width: 1, color: Colors.lightGray.color)
        setRoundCorners(Layout.cornerRadius, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        addSubview(hideControlsButton)
        hideControlsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    
}
