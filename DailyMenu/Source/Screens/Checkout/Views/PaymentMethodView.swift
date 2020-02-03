//
//  Created by Vladimir on 2/3/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class PaymentMethodView: UIView {
    
    struct Item {
        let title: String
        let image: UIImage
        var isSelected: Bool = false
        let tapHandler: (PaymentMethodView) -> Void
    }
    
    private var item: Item
    
    let borderView: UIView = {
       let view = UIView()
        view.setBorder(width: 1, color: Colors.blue.color.cgColor)
        view.setRoundCorners(Layout.cornerRadius)
        view.isUserInteractionEnabled = false
        view.alpha = 0
        return view
    }()
    
    let titleLabel = UILabel.makeText()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        let cardView = CardView(shadowSize: .small, customInsets: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        addSubview(cardView)
        cardView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        addSubview(borderView)
        borderView.snp.makeConstraints{ $0.edges.equalTo(cardView.contentView.snp.edges) }
        
        let imageView = UIImageView(image: item.image)
        cardView.contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Layout.commonInset)
        }
        
        cardView.contentView.addSubview(titleLabel)
        titleLabel.text = item.title
        titleLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(imageView.snp.trailing).offset(Layout.largeMargin)
        }
        
        addGestureRecognizer(BlockTap(action: { [unowned self] _ in
            self.setSelected(!self.item.isSelected)
            self.item.tapHandler(self)
        }))
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func setSelected(_ selected: Bool) {
        item.isSelected = selected
        UIView.transition(with: self, duration: 0.3, options: [.curveEaseOut, .transitionCrossDissolve], animations: { [weak self] in
            self?.borderView.alpha = selected ? 1 : 0
            self?.titleLabel.textColor = selected ? Colors.blue.color : Colors.charcoal.color
        }, completion: nil)
    }
    
}
