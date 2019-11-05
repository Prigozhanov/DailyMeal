//  Created by Uladzimir Pryhazhanau
//  2019


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


