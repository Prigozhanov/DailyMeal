//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Networking
import CollectionKit

final class RestaurantViewController: UIViewController {
    
    private var viewModel: RestaurantViewModel
    
    private lazy var scrollDelegate: StretchScrollDelegate = StretchScrollDelegate(view: navigationBarBackground) { [weak self] viewShouldAppear in
        self?.navigationBarControls.alpha = !viewShouldAppear ? 0 : 1
        self?.navigationBarControls.isUserInteractionEnabled = viewShouldAppear
        self?.setNeedsStatusBarAppearanceUpdate()
    }
    
    private var navigationBarBackground: UIImageView = {
        let image = UIImageView(image: Images.restaurentImagePlaceholder.image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var navigationBarControls = NavigationBarControls(title: viewModel.restaurant.chainLabel)
    
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
            label: data.chainLabel,
            distance: "\(Formatter.Distance.toString(data.distance)) away",
            orderDelay: "\(data.orderDelayFirst) minutes delivery time",
            minOrderPrice: Formatter.Currency.toString(Double(data.minAmountOrder)),
            imageURL: data.src
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
    
    private lazy var itemViewSource = ClosureViewSource(viewUpdater: { (view: FoodItemCell, data: Product, index: Int) in
        view.configure(with: FoodItemCell.Item(
            title: data.label,
            description: data.content.withRemovedHtmlTags,
            price: Formatter.Currency.toString(data.price),
            imageURL: data.src))
        view.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            guard let restaurant = self?.viewModel.restaurant else {
                return
            }
            let vm = ProductViewModelImplementation(product: data, restaurant: restaurant)
            let vc = ProductViewController(viewModel: vm)
            self?.navigationController?.pushViewController(vc, animated: true)
        }))
    })
    private lazy var itemSizeSource = { [weak self] (index: Int, data: Product, collectionSize: CGSize) -> CGSize in
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
                    view.configure(item: SectionHeaderCell.Item(section: self.viewModel.categories[index - 1].label.orEmpty, itemsCount: data.section.numberOfItems))
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
            sections.append( makeItemsSection(viewModel.products) )
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
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        viewModel.loadInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Style.addBlackGradient(navigationBarBackground)
    }
    
    private func makeItemsSection(_ items: [Product]) -> BasicProvider<Product, FoodItemCell> {
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
