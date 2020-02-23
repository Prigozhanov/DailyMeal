//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import AloeStackView
import SnapKit

class RestaurantsFilterView: UIView {
    
    struct Item {
        let onRadiusValueChanged: (Int) -> Void
        let onPriceRangeValueChanged: (Int, Int) -> Void
        let onFoodTypeCategoriesChanged: ([FoodCategory]) -> Void
        let onRatingRangeValueChanged: (Double, Double) -> Void
    }
    
    private let item: Item

    private var heightConstraint: Constraint?
    
    private var stackView: AloeStackView = {
        let stack = AloeStackView()
        stack.separatorHeight = 0
        stack.rowInset = .zero
        return stack
    }()
    
    private lazy var restaurantsFilterHeader = RestaurantsFilterHeader(
        item: RestaurantsFilterHeader.Item(onHideControlsAction: { [weak self] in
            guard let self = self else { return }
            self.stackView.hideRow(self.restaurantsFilterControls, animated: true)
            self.heightConstraint?.update(offset: 50)
        })
    )
    
    private lazy var restaurantsFilterControls = RestaurantsFilterControls(
        item: RestaurantsFilterControls.Item(
            onRadiusValueChanged: item.onRadiusValueChanged,
            onPriceRangeValueChanged: item.onPriceRangeValueChanged,
            onFoodTypeCategoriesChanged: item.onFoodTypeCategoriesChanged,
            onRatingRangeValueChanged: item.onRatingRangeValueChanged
        )
    )
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.commonBackground.color
        
        setRoundCorners(Layout.cornerRadius)
        setBorder(width: 1, color: Colors.lightGray.color.cgColor)
        
        addSubview(stackView)
        
        var heightConstraint: Constraint?
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            heightConstraint = $0.height.equalTo(400).constraint
        }
        self.heightConstraint = heightConstraint
        
        restaurantsFilterHeader.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        restaurantsFilterControls.snp.makeConstraints {
            $0.height.equalTo(350)
        }
        
        stackView.addRows([restaurantsFilterHeader, restaurantsFilterControls])
        
        restaurantsFilterHeader.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            guard let self = self else { return }
            self.stackView.showRow(self.restaurantsFilterControls, animated: true)
            self.heightConstraint?.update(offset: 400)
        }))
        
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
