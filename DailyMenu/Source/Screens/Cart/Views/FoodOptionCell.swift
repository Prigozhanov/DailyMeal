//
//  Created by Vladimir on 1/23/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Networking

class FoodOptionCell: UICollectionViewCell {
    
    public struct Item {
        public let option: Choice
        public let onRemoveOption: ((UIButton) -> ())
    }
    
    private let label: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Poppins.regular.font(size: 11)
        label.textColor = Colors.smoke.color
        return label
    }()
    
    private let optionRemoveButton: UIButton = {
        let button = UIButton.makeImageButton(image: Images.Icons.cross.image, action: {_ in})
        button.tintColor = .red
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public func configure(with item: Item) {
        label.text = item.option.label
        optionRemoveButton.setActionHandler(controlEvents: .touchUpInside, ForAction: item.onRemoveOption)
    }
    
    private func setup() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        contentView.addSubview(optionRemoveButton)
        optionRemoveButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(label.snp.trailing).offset(4)
        }
    }
    
}

