//
//  SelectDeliveryLocationViewModel.swift
//

import Foundation

//MARK: - View
protocol SelectDeliveryLocationView: class {
    
}

//MARK: - ViewModel
protocol SelectDeliveryLocationViewModel {
    
    var view: SelectDeliveryLocationView? { get set }
    
}

//MARK: - Implementation
final class SelectDeliveryLocationViewModelImplementation: SelectDeliveryLocationViewModel {
    
    weak var view: SelectDeliveryLocationView?
    
    init() {
    }
    
}


