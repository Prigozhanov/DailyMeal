//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol LoginView: class {

}

//MARK: - ViewModel
protocol LoginViewModel {

var view: LoginView? { get set }

}

//MARK: - Implementation
final class LoginViewModelImplementation: LoginViewModel {

  weak var view: LoginView?

  init() {
  }

}


