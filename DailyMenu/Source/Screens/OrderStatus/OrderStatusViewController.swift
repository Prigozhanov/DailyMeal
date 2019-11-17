//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class OrderStatusViewController: UIViewController {

  private var viewModel: OrderStatusViewModel

  init(viewModel: OrderStatusViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }
}

//MARK: -  OrderStatusView
extension OrderStatusViewController: OrderStatusView {

}

//MARK: -  Private
private extension OrderStatusViewController {

}


