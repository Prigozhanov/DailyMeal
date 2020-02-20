//
//  Created by Vladimir on 2/12/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class ChoiceRow: UIView {
    
    struct Item {
        let id: Int
        let optionId: Int
        let title: String
        let price: String
        var isSelected: Bool
        let onSelectChoice: (Item) -> Void
    }
    
    var item: Item
    
    private let willSelectChoice: (ChoiceRow) -> Void
    
    private lazy var checkMark: UIImageView = {
        let image = Images.Icons.checkmarkNotMarked.image
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText(item.title)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel.makeText(item.price)
        return label
    }()
    
    init(item: Item, willSelectChoice: @escaping (ChoiceRow) -> Void) {
        self.item = item
        self.willSelectChoice = willSelectChoice
        
        super.init(frame: .zero)
        
        let cardView = CardView(shadowSize: .small, customInsets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        cardView.contentView.addSubview(checkMark)
        checkMark.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(10)
            $0.size.equalTo(20)
        }
        
        cardView.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(checkMark.snp.trailing).offset(Layout.largeMargin)
        }
        
        cardView.contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(10)
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing)
        }
        
        addGestureRecognizer(BlockTap(action: { [unowned self] _ in
            self.willSelectChoice(self)
        }))
    }
    
    func setSelected() {
        item.isSelected = !item.isSelected
        checkMark.image = item.isSelected ? Images.Icons.checkmarkChecked.image : Images.Icons.checkmarkNotMarked.image
        item.onSelectChoice(item)
    }
    
    func setSelected(_ selected: Bool) {
        item.isSelected = selected
        checkMark.image = item.isSelected ? Images.Icons.checkmarkChecked.image : Images.Icons.checkmarkNotMarked.image
        item.onSelectChoice(item)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
}
