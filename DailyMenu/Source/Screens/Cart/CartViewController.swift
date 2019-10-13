//
//  CartViewController.swift
//


import Foundation
import UIKit

final class CartViewController: UIViewController {

  private var viewModel: CartViewModel

  init(viewModel: CartViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
    
    view.backgroundColor = .white
  }
}

//MARK: -  CartView
extension CartViewController: CartView {

}

//MARK: -  Private
private extension CartViewController {

}


