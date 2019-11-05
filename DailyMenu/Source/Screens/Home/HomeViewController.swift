//  Created by Uladzimir Pryhazhanau
//  2019


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


