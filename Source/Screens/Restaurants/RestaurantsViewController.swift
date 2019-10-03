//
//  RestaurantsViewController.swift
//


import Foundation
import UIKit

final class RestaurantsViewController: UIViewController {

  private var viewModel: RestaurantsViewModel

  init(viewModel: RestaurantsViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    
    viewModel.view = self
  }
}

//MARK: -  RestaurantsView
extension RestaurantsViewController: RestaurantsView {

}

//MARK: -  Private
private extension RestaurantsViewController {

}


