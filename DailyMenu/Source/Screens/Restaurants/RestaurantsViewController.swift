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
    
    private var headerViewUpperBorder: CGFloat!
    private var headerViewBottomBorder: CGFloat!
    
    private var isDrugging: Bool = false
    private var headerViewTopConstraint: NSLayoutConstraint?
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.commonBackground.color
        view.addSubview(self.categoryCollectionView)
        self.categoryCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }
        
        view.addSubview(self.searchView)
        self.searchView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(self.categoryCollectionView.snp.bottom).offset(10)
        }
        return view
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collectionViewFlow = UICollectionViewLayout()
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 100), collectionViewLayout: collectionViewFlow)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.backgroundColor = Colors.commonBackground.color
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: self.filterCellIdentifier)
        return collectionView
    }()
    
    private lazy var searchView = RestaurantsSearchView()
    
    private lazy var tableDirector: TableDirector = TableDirector(tableView: self.tableView, scrollDelegate: self, shouldUsePrototypeCellHeightCalculation: true)
    
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
        
        navigationItem.title = "What would you like to eat"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
        
        viewModel.view = self
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        tableView.setContentOffset(CGPoint(x: 0, y: -150), animated: false)
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        headerViewTopConstraint?.isActive = true
        
        let topView = UIView()
        view.addSubview(topView)
        topView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        topView.backgroundColor = Colors.commonBackground.color
        
        let rows = viewModel.restaurants.map {
            TableRow<RestaurantCell>(item: RestaurantCell.Item(name: $0.alias, rate: $0.rate, deliveryFee: "2.00"))
        }
        let section = TableSection()
        section.append(rows: rows)
        
        tableDirector.append(section: section)
        tableDirector.reload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        headerViewUpperBorder = view.safeAreaInsets.top - headerView.frame.height
        headerViewBottomBorder = view.safeAreaInsets.top
        
    }
    
}

//MARK: -  RestaurantsView
extension RestaurantsViewController: RestaurantsView {
    
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
        return CGSize(width: 170, height: 60)
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
    
    private var headerTopPosition: CGFloat {
        return headerView.frame.minY
    }
    
    private var headerBottomPosition: CGFloat {
        return headerView.frame.maxY
    }
    
    private var headerMiddlePosition: CGFloat {
        return headerView.frame.midY
    }
    
    private var isHeaderAllowToOpen: Bool {
        return headerMiddlePosition > headerViewBottomBorder
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastScrollOffset = scrollView.contentOffset.y
        isDrugging = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lastScrollOffset = 0
        isDrugging = false
        
        if  isHeaderAllowToOpen ||
            isHeaderAllowToOpen, lastScrollDirection == .down {
            openHeader()
        } else if lastScrollDirection == .up,
            (lastScrollValue >= 5 || !isHeaderAllowToOpen) {
            closeHeader()
        } else {
            openHeader()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetYValue = scrollView.contentOffset.y
        var scrollValue: CGFloat
        
        lastScrollDirection = lastScrollOffset > offsetYValue ? .down : .up
        
        switch lastScrollDirection {
        case .down:
            scrollValue = lastScrollOffset - offsetYValue
            
            if let headerViewBottomBorder = headerViewBottomBorder, scrollValue > headerViewBottomBorder - headerTopPosition {
                scrollValue = headerViewBottomBorder - headerTopPosition
            }
            if let border = headerViewBottomBorder,
                headerTopPosition <= border,
                scrollValue > 0,
                isDrugging {
                headerViewTopConstraint?.constant += scrollValue
                headerView.layoutIfNeeded()
            }
        case .up:
            scrollValue = offsetYValue - lastScrollOffset
            if let border = headerViewUpperBorder,
                headerView.frame.minY >= border,
                scrollValue > 0,
                isDrugging {
                headerViewTopConstraint?.constant -= scrollValue
                headerView.layoutIfNeeded()
            }
        default:
            return
        }

        lastScrollValue = scrollValue
        lastScrollOffset = offsetYValue
    }
    
    private func openHeader() {
        self.headerViewTopConstraint?.constant = self.headerViewBottomBorder! - view.safeAreaInsets.top
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        })
    }
    
    private func closeHeader() {
        self.headerViewTopConstraint?.constant = self.headerViewUpperBorder! - view.safeAreaInsets.top
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { [unowned self] in
            self.view.layoutIfNeeded()
        })
    }
    
}
