//
//  SelectDeliveryLocationViewController.swift
//

import UIKit

final class SelectDeliveryLocationViewController: UIViewController {
    
    private var viewModel: SelectDeliveryLocationViewModel
    
    init(viewModel: SelectDeliveryLocationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
    }
    
}

//MARK: -  SelectDeliveryLocationView
extension SelectDeliveryLocationViewController: SelectDeliveryLocationView {
    
}

//MARK: -  Private
private extension SelectDeliveryLocationViewController {
    
}


