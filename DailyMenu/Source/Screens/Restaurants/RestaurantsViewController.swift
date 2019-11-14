//
// Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import TableKit
import SnapKit

final class RestaurantsViewController: UIViewController {
    
    private var viewModel: RestaurantsViewModel
    
    private var tableView: UITableView!
    private var tableDirector: TableDirector!
    private var collectionView: UICollectionView!
    private var searchView: UIView!
    
    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.view = self
        
        setupFilterCollectionView()
        setupTableView()
        
        //    viewModel.onCategoryUpdate = {
        //
        //    }
        
    }
    
    func makeRowForRestaurant(restaurant: Restaurant) -> TableRow<RestaurantCell>{
        let row = TableRow<RestaurantCell>(item: RestaurantCellItem(name: restaurant.alias, rate: restaurant.rate, deliveryFee: "2.00"))
        return row
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.backgroundColor = Colors.lightGray.color
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        tableDirector = TableDirector(tableView: tableView, shouldUsePrototypeCellHeightCalculation: true)
        
        let rows = viewModel.restaurants.map { makeRowForRestaurant(restaurant: $0) }
        let section = TableSection(headerView: collectionView, footerView: nil)
        section.append(rows: rows)
        
        
        tableDirector.append(section: section)
        tableDirector.reload()
    }
    
    func setupFilterCollectionView() {
        let collectionViewFlow = UICollectionViewLayout()
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 100), collectionViewLayout: collectionViewFlow)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.backgroundColor = Colors.lightGray.color
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCategoryCell.self, forCellWithReuseIdentifier: "FilterCell")
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
            (image: Images.FilterIcons.burger.image, .Burger),
            (image: Images.FilterIcons.chicken.image, .Chicken),
            (image: Images.FilterIcons.deserts.image, .Desert),
            (image: Images.FilterIcons.fries.image, .Fries),
            (image: Images.FilterIcons.hotdog.image, .Hotdog),
            (image: Images.FilterIcons.lobstar.image, .Lobastar),
            (image: Images.FilterIcons.pizza.image, .Pizza),
            (image: Images.FilterIcons.sandwich.image, .Sandwich),
            (image: Images.FilterIcons.steak.image, .Steak),
            (image: Images.FilterIcons.sushi.image, .Sushi),
            (image: Images.FilterIcons.taco.image, .Taco),
            (image: Images.FilterIcons.pastry.image, .Pastry),
            
        ]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterItem = categoryItems[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FoodCategoryCell
        
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
            UIView.transition(with: cell.contentView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                cell.setState(.outOfFocus)
            })
        }
        UIView.transition(with: cell.contentView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            cell.setState(.selected)
        })
        
    }
    
}
