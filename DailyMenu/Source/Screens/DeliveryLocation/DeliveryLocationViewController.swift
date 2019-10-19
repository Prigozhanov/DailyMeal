//
//  DeliveryLocationViewController.swift
//  Daily Menu
//


import UIKit

final class DeliveryLocationViewController: UIViewController {

  private var viewModel: DeliveryLocationViewModel

  init(viewModel: DeliveryLocationViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  DeliveryLocationView
extension DeliveryLocationViewController: DeliveryLocationView {

}

//MARK: -  Private
private extension DeliveryLocationViewController {

}


