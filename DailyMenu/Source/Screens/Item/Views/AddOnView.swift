//
//  Created by Vladimir on 1/26/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class AddOnView: UIView {
    
    private let itemViewModel: ItemViewModel
    private let option: CartItem.Option
    private var isSelected: Bool
    
    private lazy var checkMarkImageView: UIImageView = {
        let view = UIImageView(image: isSelected ? Images.Icons.checkmarkChecked.image : Images.Icons.checkmarkNotMarked.image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Poppins.medium.font(size: 14)
        return label
    }()
    
    private var priceLabel = UILabel.makeSmallText()
    
    init(option: CartItem.Option, itemViewModel: ItemViewModel) {
        self.itemViewModel = itemViewModel
        self.option = option
        self.isSelected = option.applied
        
        super.init(frame: .height(60))
        
        let cardView = CardView(shadowSize: .small, customInsets: UIEdgeInsets(
            top: 0,
            left: CGFloat(Layout.commonInset),
            bottom: CGFloat(Layout.commonInset),
            right: CGFloat(Layout.commonInset))
        )
        addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardView.contentView.addSubview(checkMarkImageView)
        checkMarkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.commonInset)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(15)
        }
        cardView.contentView.addSubview(titleLabel)
        titleLabel.text = option.option.rawValue
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(checkMarkImageView.snp.trailing).offset(Layout.commonMargin)
        }
        cardView.contentView.addSubview(priceLabel)
        priceLabel.text = Formatter.Currency.toString(option.price)
        priceLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        cardView.addGestureRecognizer(BlockTap(action: { [unowned self] _ in
            self.setSelected()
            self.itemViewModel.view?.reloadTotalLabelView()
        }))
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setSelected() {
        isSelected = !isSelected
        option.applied = isSelected
        if isSelected {
            checkMarkImageView.image = Images.Icons.checkmarkChecked.image
        } else {
           checkMarkImageView.image = Images.Icons.checkmarkNotMarked.image
        }
    }
    
}
