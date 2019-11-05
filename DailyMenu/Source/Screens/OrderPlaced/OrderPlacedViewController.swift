//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
//


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


