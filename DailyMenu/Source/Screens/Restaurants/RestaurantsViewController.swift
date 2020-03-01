//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import TableKit
import SnapKit
import Services
import Networking
import Extensions

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
    
    private var notificationTokens: [Token] = []
    
    private lazy var headerView = RestaurantsHeaderView(
        item: viewModel.userName.isEmpty ? "" : "Hello, \(viewModel.userName)."
    )
    
    private lazy var filterBar = CategoryFilterBar(item: CategoryFilterBar.Item(onSelectAction: { [weak self] selectedCategory in
        self?.viewModel.categoryFilter = selectedCategory
        self?.reloadScreen()
        }, categoryRestaurantsCount: { [weak self] category in
            return self?.viewModel.getRestaurantsFilteredByCategory(category).count ?? 0
    }))
    
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
        notificationTokens.append(Token.make(descriptor: .userAddressChangedDescriptor, using: { [weak self] _ in
            self?.tableDirector.clear()
            self?.tableDirector.reload()
            self?.viewModel.loadRestaurants()
        }))
        
        notificationTokens.append(Token.make(descriptor: .userLoggedInDescriptor, using: { [weak self] _ in
            self?.tableDirector.clear()
            self?.tableDirector.reload()
            self?.viewModel.loadRestaurants()
        }))
        
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
            $0.height.equalTo(70)
        }
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.top.equalTo(filterBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
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
        
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.setContentOffset(CGPoint(x: 0, y: -200), animated: false)
        
        viewModel.loadRestaurants()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterBarUpperBorder = headerView.frame.height - filterBar.frame.height + view.safeAreaInsets.top
        filterBarBottomBorder = headerView.frame.height + view.safeAreaInsets.top
    }
    
}

// MARK: - RestaurantsView
extension RestaurantsViewController: RestaurantsView {
    func reloadScreen() {
        tableDirector.clear()
        var rows: [TableRow<RestaurantCell>]
        if viewModel.isFiltering {
            if let categoryFilter = viewModel.categoryFilter {
                rows = makeRestaurantItemRows(restaurants: viewModel.getRestaurantsFilteredByCategory(categoryFilter))
            } else {
                rows = makeRestaurantItemRows(restaurants: viewModel.filteredRestaurants)
            }
        } else {
            rows = makeRestaurantItemRows(restaurants: viewModel.pagedRestaurants)
        }
        let section = TableSection()
        tableDirector.append(section: section)
        section.append(rows: rows)
        tableDirector.reload()
        filterBar.reload()
    }
    
    func showLoadingIndicator() {
        LoadingIndicator.show(self)
    }
    
    func hideLoadingIndicator() {
        LoadingIndicator.hide()
    }
    
    func makeRestaurantItemRows(restaurants: [Restaurant]) -> [TableRow<RestaurantCell>] {
        restaurants.enumerated().map { [weak self] (index, item) -> TableRow<RestaurantCell> in
                TableRow<RestaurantCell>(item: restaurants[index])
                    .on(.click) { [weak self] data in
                        let vc = RestaurantViewController(viewModel: RestaurantViewModelImplementation(restaurant: data.item, categories: []))
                        self?.navigationController?.pushViewController(vc, animated: true)
                }
                .on(.configure) { [weak self] data in
                    guard let self = self else { return }
                    if let categories = self.viewModel.categories[data.cell?.restaurant?.id ?? 0] {
                        data.cell?.categories = categories
                        data.cell?.updatePreview()
                    } else {
                        self.viewModel.loadCategory(restId: data.cell?.restaurant?.id ?? 0) { result in
                            switch result {
                            case let .success(response):
                                if let categories = response.data {
                                    data.cell?.categories = categories
                                    data.cell?.updatePreview()
                                }
                            default: break
                        }
                    }
            }
                }
        }
        
    }
}

// MARK: - Private
private extension RestaurantsViewController {
    
}

// MARK: - TableView
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
