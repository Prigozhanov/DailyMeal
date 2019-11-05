//  Created by Uladzimir Pryhazhanau
//  2019


import UIKit

final class OrderPlacedViewController: UIViewController {

  private var viewModel: OrderPlacedViewModel

  init(viewModel: OrderPlacedViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  OrderPlacedView
extension OrderPlacedViewController: OrderPlacedView {

}

//MARK: -  Private
private extension OrderPlacedViewController {

}


