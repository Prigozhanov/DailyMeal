//
//  Created by Vladimir on 2/19/20.
//  Copyright © 2020 epam. All rights reserved.
//

import CollectionKit

class CategoryFilterBar: UIView {
    
    struct Item {
        var selectedCategory: FoodCategory?
        let onSelectAction: (FoodCategory?) -> Void
        let categoryRestaurantsCount: (FoodCategory) -> Int
        
        init(onSelectAction: @escaping (FoodCategory?) -> Void, categoryRestaurantsCount: @escaping (FoodCategory) -> Int) {
            self.onSelectAction = onSelectAction
            self.categoryRestaurantsCount = categoryRestaurantsCount
        }
    }
    
    private var item: Item
    
    private lazy var collectionView: CollectionView = {
        CollectionView(provider: basicProvider)
    }()
    
    private var categoryItems: [(image: UIImage, category: FoodCategory)] = [
        (image: Images.FilterIcons.burger.image, .burger),
        (image: Images.FilterIcons.chicken.image, .chicken),
        (image: Images.FilterIcons.deserts.image, .desert),
        (image: Images.FilterIcons.fries.image, .fries),
        (image: Images.FilterIcons.hotdog.image, .hotdog),
        (image: Images.FilterIcons.lobstar.image, .lobastar),
        (image: Images.FilterIcons.pizza.image, .pizza),
        (image: Images.FilterIcons.sandwich.image, .sandwich),
        (image: Images.FilterIcons.steak.image, .steak),
        (image: Images.FilterIcons.sushi.image, .sushi),
        (image: Images.FilterIcons.taco.image, .taco),
        (image: Images.FilterIcons.pastry.image, .pasta)
    ]
    
    private lazy var categoriesDataSource = ArrayDataSource(data: categoryItems)
    
    private lazy var categoriesViewSource = ClosureViewSource { [weak self] (view: FoodCategoryCell, data: (image: UIImage, category: FoodCategory), _) in
        view.configure(
            with: FoodCategoryCell.Item(
                image: data.image,
				category: data.category,
				restaurantsCount: self?.item.categoryRestaurantsCount(data.category) ?? 0,
                onSelectAction: { [weak self] category in
                    self?.item.selectedCategory = category
                    self?.item.onSelectAction(category)
                    if category == nil {
                        self?.collectionView.visibleCells
                            .forEach({ ($0 as! FoodCategoryCell).setState(.normal, animated: true) })
                    } else {
                        self?.collectionView.visibleCells
                            .filter({ ($0 as! FoodCategoryCell).item?.category != category })
                            .forEach({ ($0 as! FoodCategoryCell).setState(.outOfFocus, animated: true) })
                    }
            })
        )
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            if let selectedCategory = self?.item.selectedCategory {
                if selectedCategory != view.item?.category {
                    view.setState(.outOfFocus)
                } else {
                    view.setState(.selected)
                }
            } else {
                view.setState(.normal)
            }
        }
    }
    
    private lazy var categoriesSizeSource = { (index: Int, data: (image: UIImage, category: FoodCategory), collectionSize: CGSize) -> CGSize in
        return CGSize(width: 170, height: 50)
    }
    
    private lazy var basicProvider =  BasicProvider(
        dataSource: categoriesDataSource,
        viewSource: categoriesViewSource,
        sizeSource: categoriesSizeSource
    )
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.commonBackground.color
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.provider = basicProvider
        addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        basicProvider.layout = WaterfallLayout(columns: 1, spacing: 20)
            .transposed()
            .inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func reload() {
        basicProvider.reloadData()
    }
    
}
