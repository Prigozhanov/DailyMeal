//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import CollectionKit

final class RestaurantViewController: UIViewController {
    
    private var viewModel: RestaurantViewModel
    
    private lazy var scrollDelegate: StretchScrollDelegate = StretchScrollDelegate(view: navigationBarBackground) { [weak self] shouldBeAppeared in
        self?.navigationBarControls.isHidden = !shouldBeAppeared
        self?.setNeedsStatusBarAppearanceUpdate()
    }
    
    private var navigationBarBackground: UIImageView = {
        let image = UIImageView(image: Images.restaurentImagePlaceholder.image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private var navigationBarBackgroundHeightConstraint: NSLayoutConstraint?
    
    private var navigationBarControls = NavigationBarControls()
    
    private lazy var collectionView: CollectionView = {
        let collectionView = CollectionView(provider: sectionHeaderProvider)
        collectionView.backgroundColor = Colors.commonBackground.color
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        collectionView.delegate = scrollDelegate
        return collectionView
        }()
    
    private lazy var headerDataSource = ArrayDataSource(data: [
        CollectionHeaderCell.Item(
            label: self.viewModel.restaurant.label,
            distance: self.viewModel.restaurant.distance,
            orderDelay: self.viewModel.restaurant.orderDelayFirst,
            minOrderPrice: Formatter.Currency.toString(Double(self.viewModel.restaurant.minAmountOrder))
        )
    ])
    private lazy var headerViewSource = ClosureViewSource(viewUpdater: { (view: CollectionHeaderCell, data: CollectionHeaderCell.Item, index: Int) in
        view.configure(with: data)
    })
    private lazy var headerSizeSource = { [weak self] (index: Int, data: CollectionHeaderCell.Item, collectionSize: CGSize) -> CGSize in
        return CGSize(width: self?.collectionView.frame.width ?? 0, height: 160)
    }
    
    private lazy var headerProvider = BasicProvider(
        dataSource: headerDataSource,
        viewSource: headerViewSource,
        sizeSource: headerSizeSource
    )
    
    private lazy var itemViewSource = ClosureViewSource(viewUpdater: { (view: FoodItemCell, data: CartItem, index: Int) in
        view.configure(with: FoodItemCell.Item(title: data.name, description: "", price: Formatter.Currency.toString(data.price)))
        view.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            let vm = ItemViewModelImplementation(item: data)
            let vc = ItemViewController(viewModel: vm)
            self?.navigationController?.pushViewController(vc, animated: true)
        }))
    })
    private lazy var itemSizeSource = { [weak self] (index: Int, data: CartItem, collectionSize: CGSize) -> CGSize in
        return CGSize(width: self?.collectionView.frame.width ?? 0, height: 100)
    }
    
    private lazy var sectionHeaderProvider: ComposedHeaderProvider<SectionHeaderCell> = {
        let provider = ComposedHeaderProvider(
            headerViewSource: { (view: SectionHeaderCell, data, index) in
                view.configure(section: "Dummy section \(index)", itemsCount: data.section.numberOfItems)
                if index == 0 {
                    view.isHidden = true
                }
        },
            headerSizeSource: { (index, data, maxSize) -> CGSize in
                if index == 0 {
                    return .zero
                }
                return CGSize(width: maxSize.width, height: 50)
        },
            sections: sections
        )
        
        provider.isSticky = false
        provider.layout = FlowLayout(spacing: 10)
        return provider
    }()
    
    private lazy var sections: [Provider] = [
        headerProvider,
        makeItemsSection(viewModel.items),
        makeItemsSection(viewModel.items),
        makeItemsSection(viewModel.items),
        makeItemsSection(viewModel.items)
    ]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return navigationBarControls.isHidden ? .default : .lightContent
    }
    
    init(viewModel: RestaurantViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        view.addSubview(navigationBarBackground)
        navigationBarBackground.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        collectionView.backgroundColor = .clear
        
        view.addSubview(navigationBarControls)
        navigationBarControls.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(100)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Style.addBlackGradient(navigationBarBackground)
    }
    
    private func makeItemsSection(_ items: [CartItem]) -> BasicProvider<CartItem, FoodItemCell> {
        let itemDataSource = ArrayDataSource(data: items)
        
        let itemsProvider = BasicProvider(
            dataSource: itemDataSource,
            viewSource: itemViewSource,
            sizeSource: itemSizeSource
        )
        itemsProvider.layout = FlowLayout(spacing: 20)
        return itemsProvider
    }
    
}

//MARK: -  RestaurantView
extension RestaurantViewController: RestaurantView {
    
}

//MARK: -  Private
private extension RestaurantViewController {
}
