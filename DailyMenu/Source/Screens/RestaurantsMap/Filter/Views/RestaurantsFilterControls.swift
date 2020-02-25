//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import AloeStackView

class RestaurantsFilterControls: UIView {
    
    struct Item {
        let radiusValue: Int
        let radiusMaximumValue: Int
        
        let priceRangeValues: RangeValue<Int>
        let priceRangeMaximumValue: Int
        
        let ratingRangeValues: RangeValue<Double>
        let raingRangeMaximumValue: Double
        
        var selectedCategories: [FoodCategory]
        
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
    
    private lazy var radiusRow = RadiusRow(
        item: RadiusRow.Item(
            value: Float(item.radiusValue),
            maximumValue: Float(item.radiusMaximumValue),
            valueChanged: { [weak self] value in
                self?.item.onRadiusValueChanged(Int(value)
                )
            }
        )
    )
    
    private lazy var priceRangeRow = PriceRangeRow(
        item: PriceRangeRow.Item(
            value: (CGFloat(item.priceRangeValues.lowerValue), CGFloat(item.priceRangeValues.upperValue)),
            maximumValue: CGFloat(item.priceRangeMaximumValue),
            valueChanged: { [weak self] (lowerValue, upperValue) in
                self?.item.onPriceRangeValueChanged(Int(lowerValue), Int(upperValue))
            }
        )
    )
    
    private lazy var foodTypeRow = FoodTypeRow(
        item: FoodTypeRow.Item(
            selectedCategories: item.selectedCategories,
            didChange: { [weak self] selectedCategories in
                self?.item.onFoodTypeCategoriesChanged(selectedCategories)
            }
        )
    )
    
    private lazy var ratingRangeRow = RatingRangeRow(
        item: RatingRangeRow.Item(
            value: (CGFloat(item.ratingRangeValues.lowerValue), CGFloat(item.ratingRangeValues.upperValue)),
            maximumValue: CGFloat(item.raingRangeMaximumValue),
            valueChanged: { [weak self] (lowerValue, upperValue) in
                self?.item.onRatingRangeValueChanged(Double(lowerValue), Double(upperValue))
            }
        )
    )
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.white.color
        setRoundCorners(Layout.cornerRadius, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
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
