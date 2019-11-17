//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {

  private var viewModel: SettingsViewModel

  init(viewModel: SettingsViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  SettingsView
extension SettingsViewController: SettingsView {

}

//MARK: -  Private
private extension SettingsViewController {

}


