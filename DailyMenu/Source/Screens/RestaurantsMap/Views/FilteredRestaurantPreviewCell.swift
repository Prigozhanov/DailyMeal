//
//  Created by Vladimir on 2/24/20.
//  Copyright © 2020 epam. All rights reserved.
//

import AloeStackView

class FilteredRestaurantsPreviewCell: UICollectionViewCell {
    
    struct Item {
		let id: Int
        let title: String
        let rating: Double
        let imageSrc: String
        let categories: [FoodCategory]
        let minOrderPrice: String
        let onSelectAction: VoidClosure
    }
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Poppins.semiBold.font(size: 18)
        return label
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView(item: RatingView.Item(value: 0, maxValue: 5))
        return view
    }()
    
    private lazy var ratingValueLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.blue.color
        return label
    }()
    
    private lazy var foodCategoriesStack: AloeStackView = {
        let stack = AloeStackView()
        stack.axis = .horizontal
        stack.separatorHeight = 0
        stack.rowInset = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        stack.backgroundColor = .clear
        return stack
    }()
    
    private lazy var minOrderLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.blue.color
        return label
    }()

    private lazy var minOrderView: UIView = {
        let view = UIView()
        view.addSubview(minOrderLabel)
        
        let descritionLabel = UILabel.makeExtraSmallText("Min order")
        view.addSubview(descritionLabel)
        
        minOrderLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        descritionLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(minOrderLabel.snp.trailing).offset(10)
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Colors.white.color
        setRoundCorners(Layout.cornerRadius)
        
        let logoImageCardView = CardView(shadowSize: .small, customInsets: .zero)
        
        addSubviews([
            logoImageCardView,
            titleLabel,
            ratingView,
            ratingValueLabel,
            foodCategoriesStack,
            minOrderView
        ])
        
        logoImageCardView.contentView.addSubview(logoImageView)
        
        logoImageCardView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Layout.commonInset)
            $0.size.equalTo(40)
        }
        
        logoImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(logoImageCardView.snp.trailing).offset(Layout.commonMargin)
            $0.trailing.lessThanOrEqualToSuperview().inset(Layout.commonInset)
        }
        
        ratingView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(titleLabel.snp.bottom)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalTo(logoImageCardView)
            $0.width.equalTo(70)
        }
        
        ratingValueLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingView.snp.trailing).offset(5)
            $0.centerY.equalTo(ratingView)
        }
        
        foodCategoriesStack.snp.makeConstraints {
            $0.top.equalTo(logoImageCardView.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        minOrderView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(foodCategoriesStack).offset(Layout.commonMargin)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Layout.commonInset)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(item: Item) {
        foodCategoriesStack.removeAllRows()
        
        titleLabel.text = item.title
        ratingView.value = item.rating
        ratingValueLabel.text = String(format: "%.1f", item.rating)
        item.categories.prefix(3).forEach {
            foodCategoriesStack.addRow(StackCategoryView(item: $0))
        }
        minOrderLabel.text = item.minOrderPrice
        
        if let url = URL(string: item.imageSrc) {
            logoImageView.kf.setImage(with: url)
        }
    }
    
}

private class StackCategoryView: UIView {
    
    typealias Item = FoodCategory
    
    private let item: FoodCategory
    
    private lazy var label: UILabel = {
        let label = UILabel.makeExtraSmallText(item.humanReadableValue)
        return label
    }()
    
    init(item: Item) {
        self.item = item
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
        
        backgroundColor = Colors.lightGray.color
        
        setRoundCorners(4)
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.equalTo(50).priority(.required)
            $0.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
