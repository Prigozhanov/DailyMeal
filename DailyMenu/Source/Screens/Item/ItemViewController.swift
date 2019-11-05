//  Created by Uladzimir Pryhazhanau
//  2019


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


