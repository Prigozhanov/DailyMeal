//
//  Created by Vladimir on 1/30/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class LoadingIndicator {
    
    private class LoadingIndicatorViewController: UIViewController {
        
        private let spinnerImageView = UIImageView(image: Images.spinner.image)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.isUserInteractionEnabled = false
            view.addSubview(spinnerImageView)
            spinnerImageView.snp.makeConstraints {
                $0.center.equalToSuperview()
                $0.size.equalTo(44)
            }
            spinnerImageView.startRotating()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            spinnerImageView.startRotating()
        }
        
    }
    
    private static var loadingIndicatorViewController: LoadingIndicatorViewController!
    
    static func show(_ vc: UIViewController? = UIApplication.topViewController) {
        guard let presentingViewController = vc else {
            return
        }
        
        guard loadingIndicatorViewController == nil else { return }
        
        loadingIndicatorViewController = LoadingIndicatorViewController()
        
        presentingViewController.addChild(loadingIndicatorViewController)
        presentingViewController.view.addSubview(loadingIndicatorViewController.view)
        loadingIndicatorViewController.didMove(toParent: presentingViewController)
        presentingViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    static func hide() {
        loadingIndicatorViewController?.view.removeFromSuperview()
        loadingIndicatorViewController?.removeFromParent()
        loadingIndicatorViewController = nil
    }
    
}
