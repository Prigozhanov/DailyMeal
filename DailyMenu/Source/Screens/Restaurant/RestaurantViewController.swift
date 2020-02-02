//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import CollectionKit

final class RestaurantViewController: UIViewController {
    
    private var viewModel: RestaurantViewModel
    
    private lazy var scrollDelegate: StretchScrollDelegate = StretchScrollDelegate(view: navigationBarBackground) { [weak self] shouldBeAppeared in
        self?.navigationBarControls.alpha = !shouldBeAppeared ? 0 : 1
        self?.navigationBarControls.isUserInteractionEnabled = shouldBeAppeared
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
        let collectionView = CollectionView(provider: composedSectionProvider)
        collectionView.backgroundColor = Colors.commonBackground.color
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        collectionView.delegate = scrollDelegate
        return collectionView
        }()
    
    
    private lazy var headerDataSource = ArrayDataSource<Restaurant>(data: [
        self.viewModel.restaurant
    ])
    private lazy var headerViewSource = ClosureViewSource<Restaurant, CollectionHeaderCell>(viewUpdater: { (view: CollectionHeaderCell, data: Restaurant, index: Int) in
        let item = CollectionHeaderCell.Item(
            label: data.chain_label.orEmpty,
            distance: "\(Formatter.Distance.toString(data.distance ?? 0)) away",
            orderDelay: "\(data.orderDelayFirst ?? 0) minutes delivery time",
            minOrderPrice: Formatter.Currency.toString(Double(data.min_amount_order ?? 0)),
            imageURL: data.src.orEmpty
        )
        view.configure(with: item)
    })
    private lazy var headerSizeSource = { [weak self] (index: Int, data: Restaurant, collectionSize: CGSize) -> CGSize in
        return CGSize(width: self?.collectionView.frame.width ?? 0, height: 160)
    }
    
    private lazy var headerProvider = BasicProvider<Restaurant, CollectionHeaderCell>(
        dataSource: headerDataSource,
        viewSource: headerViewSource,
        sizeSource: headerSizeSource
    )
    
    private lazy var itemViewSource = ClosureViewSource(viewUpdater: { (view: FoodItemCell, data: CartItem, index: Int) in
        view.configure(with: FoodItemCell.Item(
            title: data.name,
            description: data.description.orEmpty.withRemovedHtmlTags,
            price: Formatter.Currency.toString(data.price),
            imageURL: data.imageURL.orEmpty))
        view.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            let vm = ItemViewModelImplementation(item: data)
            let vc = ItemViewController(viewModel: vm)
            self?.navigationController?.pushViewController(vc, animated: true)
        }))
    })
    private lazy var itemSizeSource = { [weak self] (index: Int, data: CartItem, collectionSize: CGSize) -> CGSize in
        return CGSize(width: self?.collectionView.frame.width ?? 0, height: 120)
    }
    
    private lazy var composedSectionProvider: ComposedHeaderProvider<SectionHeaderCell> = {
        let provider = ComposedHeaderProvider(
            headerViewSource: { [weak self] (view: SectionHeaderCell, data, index) in
                guard let self = self else { return }
                guard index != 0 else {
                    view.isHidden = true
                    return
                }
                if !self.viewModel.categories.isEmpty, index > 0 {
                    view.configure(section: self.viewModel.categories[index - 1].label.orEmpty, itemsCount: data.section.numberOfItems)
                }
        },
            headerSizeSource: { (index, data, maxSize) -> CGSize in
                if index == 0 {
                    return .zero
                }
                return CGSize(width: maxSize.width, height: 60)
        },
            sections: sections
        )
        
        provider.isSticky = false
        provider.layout = FlowLayout(spacing: 10)
        return provider
    }()
    
    private var sections: [Provider] {
        var sections: [Provider] = viewModel.categories.map { makeItemsSection(viewModel.getItemsByCategory($0)) }
        if sections.isEmpty {
            sections.append( makeItemsSection(viewModel.items) )
        }
        sections.insert(headerProvider, at: 0)
        return sections
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return navigationBarBackground.alpha < 0.3 ? .default : .lightContent
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
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.loadMenu()
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
    func reloadItems() {
        composedSectionProvider.sections = sections
        composedSectionProvider.reloadData()
    }
}

//MARK: -  Private
private extension RestaurantViewController {
}
