//
//  Created by Vladimir on 2/24/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class FilterAppliedView: UIView {
    
    struct Item {
        let onHideButtonTapAction: VoidClosure
        let onTapAction: VoidClosure
    }
    
    private let item: Item
    
    private let label: UILabel = {
		let label = UILabel.makeText(Localizable.RestaurantsMap.filterApplied)
        label.font = FontFamily.medium
        label.textColor = Colors.blue.color
        return label
    }()
    
    private lazy var hideButton: UIButton = {
        let button = UIButton.makeImageButton(image: Images.Icons.cross.image) { [weak self] _ in
            self?.item.onHideButtonTapAction()
        }
        button.tintColor = Colors.charcoal.color
        return button
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.white.color
        setRoundCorners(Layout.cornerRadius)
        setBorder(width: 1, color: Colors.lightGray.color)
        
        addSubviews([label, hideButton])
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(Layout.commonInset)
        }
        
        hideButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.size.equalTo(24)
        }
        
        addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.item.onTapAction()
        }))
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
