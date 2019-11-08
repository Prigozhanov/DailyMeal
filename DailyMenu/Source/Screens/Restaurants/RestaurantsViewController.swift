//  Created by Vladimir on 11/5/19.
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
    collectionView.register(RestaurantsFilterCell.self, forCellWithReuseIdentifier: "FilterCell")
  }

}

//MARK: -  RestaurantsView
extension RestaurantsViewController: RestaurantsView {

}

//MARK: -  Private
private extension RestaurantsViewController {

}

extension RestaurantsViewController: UICollectionViewDataSource {
    private var filterItems: [(image: UIImage, title: String)] {
    return [
      (image: Images.iconBurger.image, "Burger"),
      (image: Images.iconChicken.image, "Chicken"),
      (image: Images.iconDeserts.image, "Desert"),
      (image: Images.iconFries.image, "Fries"),
      (image: Images.iconHotdog.image, "Hotdog"),
      (image: Images.iconLobstar.image, "Lobastar"),
      (image: Images.iconPizza.image, "Pizza"),
      (image: Images.iconSandwich.image, "Sandwich"),
      (image: Images.iconSteak.image, "Steak"),
      (image: Images.iconSushi.image, "Sushi"),
      (image: Images.iconTaco.image, "Taco"),
      (image: Images.iconPastry.image, "Pastry"),
      
    ]
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    filterItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let filterItem = filterItems[indexPath.item]
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! RestaurantsFilterCell
    cell.subviews.forEach { $0.removeFromSuperview() }
    
    cell.configureCellWith(image: filterItem.image, title: filterItem.title)
    
    if viewModel.filterDidSelected, !cell.isSelected {
      cell.setFocused(false)
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
    viewModel.filterDidSelected = true
    let cell = collectionView.cellForItem(at: indexPath) as! RestaurantsFilterCell
    collectionView.visibleCells.forEach {
      guard let cell = $0 as? RestaurantsFilterCell else { return }
      cell.setSelected(false)
      cell.setFocused(false)
    }
    cell.setSelected(true)
  }
  
}
