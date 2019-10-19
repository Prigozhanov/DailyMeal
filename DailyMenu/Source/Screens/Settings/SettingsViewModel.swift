//
//  SettingsViewModel.swift
//  Daily Menu
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


