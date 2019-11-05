//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
//


import UIKit

final class ItemViewController: UIViewController {

  private var viewModel: ItemViewModel

  init(viewModel: ItemViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  ItemView
extension ItemViewController: ItemView {

}

//MARK: -  Private
private extension ItemViewController {

}


