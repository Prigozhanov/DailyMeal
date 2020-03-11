//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import CollectionKit

class FoodTypeRow: UIView {
    
    struct Item {
        var selectedCategories: [FoodCategory]
        let didChange: ([FoodCategory]) -> Void
    }
    
    private var item: Item
    
    private let categories: [FoodCategory] = FoodCategory.allCases.filter { $0 != .unknown }
    
    private lazy var dataSource = ArrayDataSource(data: categories)
    
    private lazy var viewSource = ClosureViewSource { [weak self] (view: CategoryCell, data: FoodCategory, _) in
        guard let self = self else { return }
        view.configure(item: data)
        view.setSelected( self.item.selectedCategories.contains(data))
    }
    
    private lazy var categoriesSizeSource = { (index: Int, data: FoodCategory, collectionSize: CGSize) -> CGSize in
        return CGSize(width: 70, height: 30)
    }
    
    private lazy var basicProvider =  BasicProvider(
        dataSource: dataSource,
        viewSource: viewSource,
        sizeSource: categoriesSizeSource,
        layout: FlowLayout(lineSpacing: 10).transposed(),
        tapHandler: { [weak self] handler in
            guard let self = self else { return }
            if self.item.selectedCategories.contains(handler.data) {
                self.item.selectedCategories.removeAll(where: { $0 == handler.data })
            } else {
                self.item.selectedCategories.append(handler.data)
            }
            self.item.didChange(self.item.selectedCategories)
            handler.setNeedsReload()
    })
    
    private lazy var collectionView = CollectionView(provider: basicProvider)
    
    private lazy var titleLabel = UILabel.makeSmallText(Localizable.RestaurantsMap.foodType)
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}

class CategoryCell: UICollectionViewCell {
    
    typealias Item = FoodCategory
    
    let label: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.smoke.color
        label.font = FontFamily.Avenir.book.font(size: 11)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(item: Item) {
        setRoundCorners(3)
        backgroundColor = Colors.backgroundGray.color
        label.text = item.humanReadableValue
    }
    
    func setSelected(_ selected: Bool) {
        backgroundColor = selected ? Colors.blue.color : Colors.backgroundGray.color
        label.textColor = selected ? Colors.white.color : Colors.smoke.color
    }
    
}
