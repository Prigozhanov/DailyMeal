//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import UIKit

final class RegistrationViewController: UIViewController {

  private var viewModel: RegistrationViewModel

  init(viewModel: RegistrationViewModel) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) { fatalError() }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.view = self
  }

}

//MARK: -  RegistrationView
extension RegistrationViewController: RegistrationView {

}

//MARK: -  Private
private extension RegistrationViewController {

}


