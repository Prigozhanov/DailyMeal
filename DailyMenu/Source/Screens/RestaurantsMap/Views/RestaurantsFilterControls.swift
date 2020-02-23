//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import AloeStackView

class RestaurantsFilterControls: UIView {
    
    struct Item {
        let onRadiusValueChanged: (Int) -> Void
        let onPriceRangeValueChanged: (Int, Int) -> Void
        let onFoodTypeCategoriesChanged: ([FoodCategory]) -> Void
        let onRatingRangeValueChanged: (Double, Double) -> Void
    }
    
    private let item: Item
    
    private let controlsStack: AloeStackView = {
        let stack = AloeStackView()
        stack.separatorHeight = 0
        stack.rowInset = UIEdgeInsets(top: 10, left: Layout.commonInset, bottom: 10, right: Layout.commonInset)
        stack.backgroundColor = .clear
        return stack
    }()
    
    private lazy var radiusRow = RadiusRow(item: RadiusRow.Item(valueChanged: { [weak self] value in
        self?.item.onRadiusValueChanged(value)
    }))
    
    private lazy var priceRangeRow = PriceRangeRow(item: PriceRangeRow.Item(valueChanged: { [weak self] (lowerValue, upperValue) in
        self?.item.onPriceRangeValueChanged(lowerValue, upperValue)
    }))
    
    private lazy var foodTypeRow = FoodTypeRow(item: FoodTypeRow.Item(didChange: { [weak self] selectedCategories in
        self?.item.onFoodTypeCategoriesChanged(selectedCategories)
    }))
    
    private lazy var ratingRangeRow = RatingRangeRow(item: RatingRangeRow.Item(valueChanged: { [weak self] (lowerValue, upperValue) in
        self?.item.onRatingRangeValueChanged(lowerValue, upperValue)
    }))
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        addSubview(controlsStack)
        controlsStack.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        radiusRow.snp.makeConstraints { $0.height.equalTo(70) }
        priceRangeRow.snp.makeConstraints { $0.height.equalTo(70) }
        foodTypeRow.snp.makeConstraints { $0.height.equalTo(70) }
        ratingRangeRow.snp.makeConstraints { $0.height.equalTo(30) }
        
        controlsStack.addRows([radiusRow, priceRangeRow, foodTypeRow, ratingRangeRow])
        controlsStack.setInset(forRow: foodTypeRow, inset: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    
}
