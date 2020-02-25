//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

// MARK: - View
protocol RegistrationView: class {

}

// MARK: - ViewModel
protocol RegistrationViewModel {

var view: RegistrationView? { get set }

}

// MARK: - Implementation
final class RegistrationViewModelImplementation: RegistrationViewModel {

  weak var view: RegistrationView?

  init() {
  }

}
