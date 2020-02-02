//
//  Created by Vladimir on 1/26/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class ItemHeaderView: UIView {
    
    let itemViewModel: ItemViewModel
    
    let itemTitleLabel: UILabel = {
        let label = UILabel.makeText()
        label.numberOfLines = 3
        label.font = FontFamily.Poppins.semiBold.font(size: 16)
        return label
    }()
    
    let itemPriceLabel: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Poppins.semiBold.font(size: 12)
        label.textColor = Colors.blue.color
        return label
    }()
    
    private lazy var itemCounter: ItemCounter = {
        let counter = ItemCounter(axis: .horizontal) { [weak self] (value) in
            self?.itemViewModel.item.count = value
            self?.itemViewModel.view?.reloadTotalLabelView()
        }
        counter.updateValue(itemViewModel.item.count)
        return counter
    }()
    
    init(title: String, price: String, count: Int = 1, itemViewModel: ItemViewModel) {
        self.itemViewModel = itemViewModel
        
        super.init(frame: .height(120))
        
        let cardView = CardView(shadowSize: .medium, customInsets: UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10))
        addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardView.contentView.addSubview(itemTitleLabel)
        itemTitleLabel.text = title
        itemTitleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Layout.commonInset)
        }
        itemTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        cardView.contentView.addSubview(itemPriceLabel)
        itemPriceLabel.text = price
        itemPriceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.commonInset)
            $0.bottom.lessThanOrEqualToSuperview().inset(Layout.commonInset)
            $0.top.equalTo(itemTitleLabel.snp.bottom).offset(Layout.commonMargin)
        }
        
        cardView.contentView.addSubview(itemCounter)
        itemCounter.snp.makeConstraints {
            $0.leading.equalTo(itemTitleLabel.snp.trailing).offset(Layout.commonMargin)
            $0.trailing.top.equalToSuperview().inset(Layout.commonInset)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
        }
        itemCounter.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    
    
}
