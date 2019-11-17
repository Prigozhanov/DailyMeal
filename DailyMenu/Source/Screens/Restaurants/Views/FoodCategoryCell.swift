//
//  Created by Vladimir on 11/8/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class FoodCategoryCell: BaseCollectionCell {
    
    struct Item {
        let image: UIImage
        let category: FoodCategory
        let subtitle: String
    }
    
    enum State {
        case normal, selected, outOfFocus
    }
    
    private var state: State = .normal
    
    var category: FoodCategory!
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.color
        view.setRoundCorners(10)
        view.setShadow(offset: CGSize(width: 0, height: 4.0), opacity: 0.03, radius: 5)
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let filterNameLabel = UILabel.makeSmallText()
    
    private let restaurantCountLabel: UILabel = {
        let label = UILabel.makeExtraSmallText("{count} Restaurants")
        label.textColor = Colors.gray.color
        return label
    }()
    
    private let borderView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func setup() {
        backgroundColor = Colors.lightGray.color
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        cardView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalTo(Layout.largeMargin)
            $0.top.equalTo(Layout.largeMargin)
            $0.bottom.equalTo(-Layout.largeMargin)
            $0.width.equalTo(50)
        }
        
        cardView.addSubview(filterNameLabel)
        filterNameLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Layout.commonMargin)
            $0.top.equalTo(Layout.largeMargin)
        }
        
        cardView.addSubview(restaurantCountLabel)
        restaurantCountLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Layout.commonMargin)
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.trailing.equalToSuperview().inset(Layout.largeMargin)
        }
        
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints { $0.edges.equalToSuperview() }
        borderView.setRoundCorners(cardView.layer.cornerRadius)
        borderView.setBorder(width: 1, color: Colors.blue.color.cgColor)
    }
    
    func configure(with item: Item) {
        imageView.image = item.image
        filterNameLabel.text = item.category.rawValue
        restaurantCountLabel.text = item.subtitle
        category = item.category
        if isSelected {
            setState(.selected)
        } else {
            setState(.normal)
        }
    }
    
    func setState(_ state: State, animated: Bool? = false) {
        UIView.transition(with: contentView, duration: animated == true ? 0.3 : 0, options: .transitionCrossDissolve, animations: { [weak self] in
            switch state {
            case .normal:
                self?.borderView.alpha = 0
                self?.filterNameLabel.textColor = Colors.black.color
                self?.cardView.alpha = 1
            case .selected:
                self?.borderView.isHidden = false
                self?.borderView.alpha = 1
                self?.filterNameLabel.textColor = Colors.blue.color
                self?.cardView.alpha = 1
            case .outOfFocus:
                self?.borderView.alpha = 0
                self?.filterNameLabel.textColor = Colors.black.color
                self?.cardView.alpha = 0.5
            }
        })
    }
    
}
