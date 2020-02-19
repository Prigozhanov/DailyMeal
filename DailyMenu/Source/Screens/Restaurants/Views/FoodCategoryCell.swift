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
        let onSelectAction: (FoodCategory?) -> Void
    }
    
    enum State {
        case normal, selected, outOfFocus
    }
    
    var item: Item?
    
    private var state: State = .normal
    
    private let cardView: CardView = CardView(shadowSize: .small, customInsets: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    
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
        backgroundColor = Colors.commonBackground.color
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        cardView.contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalTo(Layout.largeMargin)
            $0.top.equalTo(Layout.largeMargin)
            $0.bottom.equalTo(-Layout.largeMargin)
            $0.width.equalTo(50)
        }
        
        cardView.contentView.addSubview(filterNameLabel)
        filterNameLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Layout.commonMargin)
            $0.top.equalTo(Layout.largeMargin)
        }
        
        cardView.contentView.addSubview(restaurantCountLabel)
        restaurantCountLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Layout.commonMargin)
            $0.bottom.equalTo(imageView.snp.bottom)
            $0.trailing.equalToSuperview().inset(Layout.largeMargin)
        }
        
        cardView.contentView.addSubview(borderView)
        borderView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        borderView.setRoundCorners(cardView.contentView.layer.cornerRadius)
        borderView.setBorder(width: 1, color: Colors.blue.color.cgColor)
        
        addGestureRecognizer(BlockTap(action: { [unowned self] _ in
            if self.state != .selected {
                self.setState(.selected, animated: true)
                self.item?.onSelectAction(self.item?.category)
            } else {
                self.setState(.normal, animated: true)
                self.item?.onSelectAction(nil)
            }
         
        }))
    }
    
    func configure(with item: Item) {
        self.item = item
        
        imageView.image = item.image
        filterNameLabel.text = item.category.rawValue
        restaurantCountLabel.text = item.subtitle
        if isSelected {
            setState(.selected)
        } else {
            setState(.normal)
        }
    }
    
    func setState(_ state: State, animated: Bool? = false) {
        self.state = state
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.transition(with: self.contentView, duration: animated == true ? 0.3 : 0, options: .transitionCrossDissolve, animations: { [weak self] in
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
