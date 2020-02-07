//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import TableKit
import SnapKit

final class RestaurantsViewController: UIViewController {
    
    private let filterCellIdentifier = "FilterCell"
    
    private var viewModel: RestaurantsViewModel
    
    private var lastScrollOffset: CGFloat = 0
    private var lastScrollDirection: ScrollDirection!
    private var lastScrollValue: CGFloat = 0
    
    private var filterBarUpperBorder: CGFloat!
    private var filterBarBottomBorder: CGFloat!
    
    private var isDrugging: Bool = false
    private var filterBarTopConstraint: NSLayoutConstraint?
    
    private lazy var headerView: UIView = {
        let view = UIView()
        let label = UILabel.makeText("What would you like to eat?")
        label.numberOfLines = 2
        label.font = FontFamily.Poppins.bold.font(size: 24)
        label.textColor = Colors.charcoal.color
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(Layout.largeMargin)
            $0.width.equalTo(200)
        }
        
        let notificationButton = UIButton.makeCommonButton { _ in }
        notificationButton.setImage(Images.Icons.notification.image, for: .normal)
        view.addSubview(notificationButton)
        notificationButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(Layout.largeMargin)
        }
        return view
    }()
    
    private lazy var filterBar: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.commonBackground.color
        view.addSubview(categoryCollectionView)
        categoryCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(90)
        }
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(categoryCollectionView.snp.bottom)
        }
        return view
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .height(100), collectionViewLayout: collectionViewFlowLayout)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.backgroundColor = Colors.commonBackground.color
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: filterCellIdentifier)
        return collectionView
    }()
    
    private lazy var searchView = RestaurantsSearchView(viewModel: viewModel)
    
    private lazy var tableDirector: TableDirector = TableDirector(tableView: tableView, scrollDelegate: self)
    
    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.commonBackground.color
        
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        return tableView
    }()
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.commonBackground.color
        
        viewModel.view = self
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        view.addSubview(filterBar)
        filterBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.lessThanOrEqualTo(100)
        }
        headerView.backgroundColor = Colors.commonBackground.color
        filterBarTopConstraint = filterBar.topAnchor.constraint(equalTo: headerView.bottomAnchor)
        filterBarTopConstraint?.isActive = true
        
        let statusBarBackground = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarBackground.backgroundColor = Colors.commonBackground.color
        view.addSubview(statusBarBackground)
        
        
        tableView.contentInset = UIEdgeInsets(top: 250, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.setContentOffset(CGPoint(x: 0, y: -250), animated: false)
        
        viewModel.loadRestaurants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterBarUpperBorder = headerView.frame.height - filterBar.frame.height + view.safeAreaInsets.top
        filterBarBottomBorder = headerView.frame.height + view.safeAreaInsets.top
        
    }
    
}

//MARK: -  RestaurantsView
extension RestaurantsViewController: RestaurantsView {
    func reloadScreen() {
        tableDirector.clear()
        var rows: [TableRow<RestaurantCell>]
        if !viewModel.isFiltering {
        rows = viewModel
            .pagedRestaurants
            .enumerated()
            .map { [weak self] (index, item) -> TableRow<RestaurantCell> in
                let row = TableRow<RestaurantCell>(item: viewModel.restaurants[index])
                    .on(.click) { [weak self] cell in
                        let vc = RestaurantViewController(viewModel: RestaurantViewModelImplementation(restaurant: cell.item))
                        self?.navigationController?.pushViewController(vc, animated: true)
                }
                return row
            }
        } else {
           rows = viewModel
            .filteredRestaurants
            .enumerated()
            .map { [weak self] (index, item) -> TableRow<RestaurantCell> in
                let row = TableRow<RestaurantCell>(item: viewModel.filteredRestaurants[index])
                    .on(.click) { [weak self] cell in
                        let vc = RestaurantViewController(viewModel: RestaurantViewModelImplementation(restaurant: cell.item))
                        self?.navigationController?.pushViewController(vc, animated: true)
                }
                return row
            }
        }
        let section = TableSection()
        tableDirector.append(section: section)
        section.append(rows: rows)
        tableDirector.reload()
    }
}

//MARK: -  Private
private extension RestaurantsViewController {
    
}

//MARK: - CollectionView
extension RestaurantsViewController: UICollectionViewDataSource {
    
    private var categoryItems: [(image: UIImage, category: FoodCategory)] {
        return [
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
            (image: Images.FilterIcons.pastry.image, .pastry)
        ]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterItem = categoryItems[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellIdentifier, for: indexPath) as! FoodCategoryCell
        
        let item = FoodCategoryCell.Item(image: filterItem.image, category: filterItem.category, subtitle: "10 Restaurants")
        cell.configure(with: item)
        
        if viewModel.foodCategory != nil, !cell.isSelected {
            cell.setState(.outOfFocus)
        }
        
        return cell
    }
    
}

extension RestaurantsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
}


extension RestaurantsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FoodCategoryCell
        
        viewModel.foodCategory = cell.category
        
        collectionView.visibleCells.forEach {
            guard let cell = $0 as? FoodCategoryCell else { return }
            cell.setState(.outOfFocus, animated: true)
            
        }
        cell.setState(.selected, animated: true)
    }
    
}

//MARK: - TableView
extension RestaurantsViewController: UIScrollViewDelegate {
    
    private enum ScrollDirection {
        case up, down
    }
    
    private var filterBarTopPosition: CGFloat {
        return filterBar.frame.minY
    }
    
    private var filterBarBottomPosition: CGFloat {
        return filterBar.frame.maxY
    }
    
    private var isHeaderAllowToOpen: Bool {
        return filterBar.frame.midY > filterBarBottomBorder
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastScrollOffset = scrollView.contentOffset.y
        isDrugging = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lastScrollOffset = 0
        isDrugging = false
        if tableView.contentOffset.y < -headerView.frame.height {
            openFilterBar()
            return
        }
        
        if lastScrollDirection == .up,
            (lastScrollValue >= 5 || !isHeaderAllowToOpen) {
            closeFilterBar()
        } else {
            openFilterBar()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetYValue = scrollView.contentOffset.y
        lastScrollDirection = lastScrollOffset > offsetYValue ? .down : .up
        moveFilterBar(by: offsetYValue, direction: lastScrollDirection)
        lastScrollOffset = offsetYValue
        
        if scrollView.contentSize.height > scrollView.bounds.size.height, (scrollView.contentSize.height - scrollView.contentOffset.y) < scrollView.bounds.size.height {
            viewModel.showMoreRestaurants()
        }
    }
    
    private func moveFilterBar(by offset: CGFloat, direction: ScrollDirection) {
        var scrollValue: CGFloat
        switch lastScrollDirection {
        case .down:
            scrollValue = lastScrollOffset - offset
            
            if let filterBarBottomBorder = filterBarBottomBorder, scrollValue > filterBarBottomBorder - filterBarTopPosition {
                scrollValue = filterBarBottomBorder - filterBarTopPosition
            }
            if let border = filterBarBottomBorder,
                filterBarTopPosition <= border,
                scrollValue > 0,
                isDrugging {
                filterBarTopConstraint?.constant += scrollValue
                filterBar.layoutIfNeeded()
            }
        case .up:
            scrollValue = offset - lastScrollOffset
            if let border = filterBarUpperBorder,
                filterBar.frame.minY >= border,
                scrollValue > 0,
                isDrugging {
                filterBarTopConstraint?.constant -= scrollValue
                filterBar.layoutIfNeeded()
            }
        default:
            return
        }
        lastScrollValue = scrollValue
    }
    
    private func openFilterBar() {
        filterBarTopConstraint?.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        })
    }
    
    private func closeFilterBar() {
        filterBarTopConstraint?.constant = -filterBar.frame.height
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        })
    }
    
}
