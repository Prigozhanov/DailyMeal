//  Created by Vladimir on 11/5/19.
//  Copyright © 2019 epam. All rights reserved.
//


import Foundation

//MARK: - View
protocol SettingsView: class {

}

//MARK: - ViewModel
protocol SettingsViewModel {

var view: SettingsView? { get set }

}

//MARK: - Implementation
final class SettingsViewModelImplementation: SettingsViewModel {

  weak var view: SettingsView?

  init() {
  }

}


