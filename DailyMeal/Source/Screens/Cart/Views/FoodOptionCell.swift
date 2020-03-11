//
//  Created by Vladimir on 1/23/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import Networking

class FoodOptionCell: UICollectionViewCell {
    
    typealias Item = Choice
    
    private let label: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Avenir.book.font(size: 11)
        label.textColor = Colors.smoke.color
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public func configure(with item: Item) {
        label.text = item.label
    }
    
    private func setup() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
    }
    
}
