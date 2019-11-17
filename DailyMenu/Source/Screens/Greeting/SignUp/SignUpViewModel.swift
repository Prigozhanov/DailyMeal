//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

//MARK: - View
protocol SignUpView: class {

}

//MARK: - ViewModel
protocol SignUpViewModel {

var view: SignUpView? { get set }

}

//MARK: - Implementation
final class SignUpViewModelImplementation: SignUpViewModel {

  weak var view: SignUpView?

  init() {
  }

}


