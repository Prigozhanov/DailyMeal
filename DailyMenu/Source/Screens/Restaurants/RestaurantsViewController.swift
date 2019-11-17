//
// Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import TableKit
import SnapKit

final class RestaurantsViewController: UIViewController {
    
    private let filterCellIdentifier = "FilterCell"
    
    private var viewModel: RestaurantsViewModel
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Colors.lightGray.color
        
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        return tableView
    }()
    
    private lazy var tableDirector: TableDirector = TableDirector(tableView: self.tableView, shouldUsePrototypeCellHeightCalculation: true)
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewFlow = UICollectionViewLayout()
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 100), collectionViewLayout: collectionViewFlow)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.backgroundColor = Colors.lightGray.color
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: self.filterCellIdentifier)
        return collectionView
    }()
    
    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewModel.view = self
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        let rows = viewModel.restaurants.map {
            TableRow<RestaurantCell>(item: RestaurantCell.Item(name: $0.alias, rate: $0.rate, deliveryFee: "2.00"))
        }
        let section = TableSection(headerView: collectionView, footerView: nil)
        section.append(rows: rows)
        
        tableDirector.append(section: section)
        tableDirector.reload()
    }
    
}

//MARK: -  RestaurantsView
extension RestaurantsViewController: RestaurantsView {
    
}

//MARK: -  Private
private extension RestaurantsViewController {
    
}

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
