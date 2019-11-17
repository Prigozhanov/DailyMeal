//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

  private var viewModel: HomeViewModel

  init(viewModel: HomeViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  HomeView
extension HomeViewController: HomeView {

}

//MARK: -  Private
private extension HomeViewController {

}


