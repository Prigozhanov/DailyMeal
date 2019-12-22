//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import CollectionKit

final class RestaurantViewController: UIViewController {
    
    private var viewModel: RestaurantViewModel
    
    private var collectionViewTopPoint: CGPoint = .zero
    private var userScrollInitiated = false
    
    
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
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var headerDataSource = ArrayDataSource(data: [self.viewModel.restaurant])
    private lazy var headerViewSource = ClosureViewSource(viewUpdater: { (view: CollectionHeaderCell, data: Restaurant, index: Int) in
        view.configure(with: data)
    })
    private lazy var headerSizeSource = { (index: Int, data: Restaurant, collectionSize: CGSize) -> CGSize in
        return CGSize(width: self.collectionView.frame.width, height: 160)
    }
    
    private lazy var headerProvider = BasicProvider(
        dataSource: headerDataSource,
        viewSource: headerViewSource,
        sizeSource: headerSizeSource
    )
    
    private let itemViewSource = ClosureViewSource(viewUpdater: { (view: FoodItemCell, data: FoodItemCell.Item, index: Int) in
        view.configure(with: data)
    })
    private lazy var itemSizeSource = { (index: Int, data: FoodItemCell.Item, collectionSize: CGSize) -> CGSize in
        return CGSize(width: self.collectionView.frame.width, height: 100)
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
        makeItemsSection([
            FoodItemCell.Item(title: "Pastry", description: "Lorem ipsum dolor sit amet, consectetuer adipiscin", price: "2.00"),
            FoodItemCell.Item(title: "Pastry", description: "Lorem ipsum dolor sit amet, consectetuer adipiscin", price: "2.00"),
            FoodItemCell.Item(title: "Pastry", description: "Lorem ipsum dolor sit amet, consectetuer adipiscin", price: "2.00")
        ]),
        makeItemsSection([
            FoodItemCell.Item(title: "Pastry", description: "Lorem ipsum dolor sit amet, consectetuer adipiscin", price: "2.00"),
        ]),
        makeItemsSection([
            FoodItemCell.Item(title: "Pastry", description: "Lorem ipsum dolor sit amet, consectetuer adipiscin", price: "5.00"),
            FoodItemCell.Item(title: "Pastry", description: "Lorem ipsum dolor sit amet, consectetuer adipiscin", price: "5.00"),
            FoodItemCell.Item(title: "Pastry", description: "Lorem ipsum dolor sit amet, consectetuer adipiscin", price: "5.00")
        ])
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionViewTopPoint = collectionView.contentOffset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBarBackgroundHeightConstraint = navigationBarBackground.heightAnchor.constraint(equalToConstant: 150 + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0))
        navigationBarBackgroundHeightConstraint?.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationBarBackground.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        addGradeintToHeader()
    }
    
    private func makeItemsSection(_ items: [FoodItemCell.Item]) -> BasicProvider<FoodItemCell.Item, FoodItemCell> {
        let itemDataSource = ArrayDataSource(data: items)
        
        let itemsProvider = BasicProvider(
            dataSource: itemDataSource,
            viewSource: itemViewSource,
            sizeSource: itemSizeSource
        )
        itemsProvider.layout = FlowLayout(spacing: 20)
        return itemsProvider
    }
    
    private let gradientLayer = CAGradientLayer()
    private func addGradeintToHeader() {
        gradientLayer.removeFromSuperlayer()
        let colors = [Colors.black.color.cgColor, UIColor.clear.cgColor]
        let locations: [NSNumber] = [-0.4, 1]
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.frame = navigationBarBackground.frame
        navigationBarBackground.layer.addSublayer(gradientLayer)
    }
    
}

//MARK: -  RestaurantView
extension RestaurantViewController: RestaurantView {
    
}

//MARK: -  Private
private extension RestaurantViewController {
    
}

extension RestaurantViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        userScrollInitiated = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetYValue = scrollView.contentOffset.y
        let alphaValue = offsetYValue / (collectionViewTopPoint.y / 2)
        let heightValue = view.safeAreaInsets.top + 150 - (offsetYValue - collectionViewTopPoint.y)
        print(heightValue)
        if userScrollInitiated {
            if abs(collectionViewTopPoint.y) - offsetYValue > 0 {
                navigationBarBackground.alpha = alphaValue
                navigationBarControls.alpha = alphaValue
                navigationBarControls.isHidden = alphaValue <= 0.3
                setNeedsStatusBarAppearanceUpdate()
            }
            if heightValue > 0 {
                navigationBarBackgroundHeightConstraint?.constant = heightValue
            }
        }
    }
    
}
