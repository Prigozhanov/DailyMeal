//
//  RestaurantViewController.swift
//  Daily Menu
//


import UIKit

final class RestaurantViewController: UIViewController {

  private var viewModel: RestaurantViewModel

  init(viewModel: RestaurantViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  RestaurantView
extension RestaurantViewController: RestaurantView {

}

//MARK: -  Private
private extension RestaurantViewController {

}


