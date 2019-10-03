//
//  CheckoutViewController.swift
//


import Foundation
import UIKit

final class CheckoutViewController: UIViewController {

  private var viewModel: CheckoutViewModel

  init(viewModel: CheckoutViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }
}

//MARK: -  CheckoutView
extension CheckoutViewController: CheckoutView {

}

//MARK: -  Private
private extension CheckoutViewController {

}


