//
//  Created by Vladimir on 2/24/20.
//  Copyright © 2020 epam. All rights reserved.
//

import CollectionKit

class FilteredRestaurantsPreview: CollectionView {
    
    private var items: [FilteredRestaurantsPreviewCell.Item]
    
    private let emptyStateViewHeight: CGFloat = 40
    private lazy var emptyStateView: UILabel = {
        let label = UILabel.makeText("No restaurants found")
        label.backgroundColor = Colors.white.color
        label.setRoundCorners(emptyStateViewHeight / 2)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dataSource = ArrayDataSource(data: items)
    
    private lazy var viewSource = ClosureViewSource { [weak self] (view: FilteredRestaurantsPreviewCell, data: FilteredRestaurantsPreviewCell.Item, index: Int) in
        view.configure(item: data)
    }
    
    private lazy var sizeSource = { (index: Int, data: FilteredRestaurantsPreviewCell.Item, collectionSize: CGSize) -> CGSize in
        return CGSize(width: 200, height: 130)
    }
    
    private lazy var basicProvider =  BasicProvider(
        dataSource: dataSource,
        viewSource: viewSource,
        sizeSource: sizeSource,
        layout: FlowLayout(lineSpacing: 10, alignItems: .end, alignContent: .start).transposed(),
        tapHandler: { [weak self] handler in
            self?.items[handler.index].onSelectAction()
    })
    
    init(items: [FilteredRestaurantsPreviewCell.Item]) {
        self.items = items
        
        super.init(frame: .zero)
        
        provider = basicProvider
        showsHorizontalScrollIndicator = false
        alwaysBounceHorizontal = true
        contentInset = UIEdgeInsets(top: 0, left: Layout.commonInset, bottom: 0, right: Layout.commonInset)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func configure(items: [FilteredRestaurantsPreviewCell.Item]) {
        isUserInteractionEnabled = true
        emptyStateView.removeFromSuperview()
        self.items = items
        dataSource.data = items
        reloadData()
        
        if items.isEmpty {
            showEmptyState()
        }
    }
    
    private func showEmptyState() {
        isUserInteractionEnabled = false
        addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(emptyStateViewHeight)
        }
    }
    
}
