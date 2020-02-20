//
//  Created by Vladimir on 2/20/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class RestaurantCalloutView: UIView {
    
    struct Item {
        let imageSrc: String
        let title: String
        let rating: Double
    }
    
    private var item: Item
    
    private lazy var restaurantImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        if let url = URL(string: item.imageSrc) {
            view.sd_setImage(with: url)
        }
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText(item.title)
        label.font = FontFamily.Poppins.semiBold.font(size: 11)
        return label
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.commonBackground.color
        
        let restaurantLogoCardView = CardView(shadowSize: .small, customInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        addSubview(restaurantLogoCardView)
        restaurantLogoCardView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(restaurantLogoCardView.snp.height)
        }
        restaurantLogoCardView.contentView.addSubview(restaurantImageView)
        restaurantImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(restaurantLogoCardView.snp.trailing).offset(Layout.largeMargin)
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
