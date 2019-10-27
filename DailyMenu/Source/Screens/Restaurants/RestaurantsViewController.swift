//
//  RestaurantsViewController.swift
//  Daily Menu
//


import UIKit
import TableKit
import SnapKit

final class RestaurantsViewController: UIViewController {

  private var viewModel: RestaurantsViewModel
  
  private var tableView: UITableView!
  private var tableDirector: TableDirector!

  init(viewModel: RestaurantsViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    viewModel.view = self
  
    tableView = UITableView()
    tableView.backgroundColor = Colors.lightGray.color
    
    self.view.addSubview(tableView)
    tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    
    tableDirector = TableDirector(tableView: tableView, shouldUsePrototypeCellHeightCalculation: true)
    
    let rows = viewModel.restaurants.map { makeRowForRestaurant(restaurant: $0) }
   
    tableDirector.append(rows: rows)
    tableDirector.reload()
  }
  
  func makeRowForRestaurant(restaurant: Restaurant) -> TableRow<RestaurantCell>{
    let row = TableRow<RestaurantCell>(item: RestaurantCellItem(name: restaurant.alias, rate: restaurant.rate, deliveryFee: "2.00"))
    return row
  }

}

//MARK: -  RestaurantsView
extension RestaurantsViewController: RestaurantsView {

}

//MARK: -  Private
private extension RestaurantsViewController {

}


