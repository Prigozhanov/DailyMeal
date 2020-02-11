//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import MapKit
import UIKit
import Extensions
import Services
import SnapKit

final class DeliveryLocationViewController: UIViewController {
    
    private var viewModel: DeliveryLocationViewModel
    
    private let headerView = MapHeaderView(
        title: "Delivery location",
        shouldShowBackButton: false,
        shouldShowNotificationsButton: false
    )
    
    private var mapControllerViewBottomConstraint: Constraint?
    private lazy var mapController = MapViewController(
        viewModel: MapViewModelImplementation(shouldShowPin: true, onRegionDidChange: { [weak self] coordinates in
            self?.viewModel.requestGeodcode(string: "\(coordinates.longitude),\(coordinates.latitude)", onSuccess: { [weak self] string in
                self?.showConfiramtionDialog(address: string)
            })
        })
    )
    
    private var notificationTokens: [Token] = []
    
    private var locationSearchViewBottomConstraint: Constraint?
    private let locationSearchBottomInset: CGFloat = 60
    private lazy var locationSearchView = LocationSearchView(
        item: LocationSearchView.Item(
            results: [],
            onSelectItem: { [weak self] address, searchView in
                searchView?.selectAddress(string: address)
                self?.viewModel.requestGeodcode(string: address, onSuccess: { address in
                    self?.showConfiramtionDialog(address: address)
                })
        }, onLocationButtonTap: { [weak self] in
            self?.mapController.moveCameraToUserLocation()
            let currentLocation = self?.mapController.viewModel.getUserLocation()
            
            let formattedPostionString = "\(currentLocation?.longitude ?? 0),\(currentLocation?.latitude ?? 0)"
            
            self?.viewModel.requestGeodcode(string: formattedPostionString, onSuccess: { [weak self] address in
                self?.showConfiramtionDialog(address: address)
            })
        }, shouldChangeCharacters: { [weak self] string, searchView in
            self?.viewModel.getAddressesList(string: string, completion: { addresses in
                searchView?.updateResults(with: addresses)
            })
        })
    )
    
    init(viewModel: DeliveryLocationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.white.color
        
        notificationTokens.append(Token.make(descriptor: .keyboardWillShowDescriptor, using: { [weak self] keyboardFrame in
            guard let self = self else { return }
            self.mapControllerViewBottomConstraint?.update(
                inset: keyboardFrame.height + Layout.commonInset - self.locationSearchBottomInset
            )
            self.locationSearchViewBottomConstraint?.update(inset: keyboardFrame.height)
            UIView.transition(with: self.view, duration: 0.3, options: [], animations: { [weak self] in
                self?.view.layoutSubviews()
                self?.mapController.view.layoutSubviews()
            }, completion: nil)
        }))
        
        notificationTokens.append(Token.make(descriptor: .keyboardWillHideDescriptor, using: { [weak self] _ in
            guard let self = self else { return }
            self.mapControllerViewBottomConstraint?.update(inset: 0)
            self.locationSearchViewBottomConstraint?.update(inset: self.locationSearchBottomInset)
            UIView.transition(with: self.view, duration: 0.3, options: [], animations: { [weak self] in
                self?.view.layoutSubviews()
                self?.mapController.view.layoutSubviews()
                }, completion: nil)
        }))
        
        addChild(mapController)
        
        view.addSubview(mapController.view)
        mapController.view.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            self.mapControllerViewBottomConstraint = $0.bottom.equalToSuperview().constraint
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        view.addSubview(locationSearchView)
        locationSearchView.snp.makeConstraints {
            self.locationSearchViewBottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(locationSearchBottomInset).constraint
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        Style.addShadow(for: locationSearchView, in: self.view, cornerRadius: Layout.cornerRadius)
        
        headerView.backButton.setActionHandler(controlEvents: .touchUpInside) { [weak self] _ in
            self?.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: .userLoggedOut, object: nil)
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.setupGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mapController.moveCameraToUserLocation()
        
        if let userCoordinates = mapController.viewModel.getUserLocation() {
            viewModel.requestGeodcode(string: "\(userCoordinates.longitude),\(userCoordinates.latitude)") { [weak self] string in
                self?.showConfiramtionDialog(address: string)
            }
        }
    }
    
    func showConfiramtionDialog(address: String) {
        let vc = ConfirmationDiagloViewController(title: "Address confirmation", subtitle: "") { [weak self] in
            self?.viewModel.saveAddressInfo()
            NotificationCenter.default.post(name: .userAddressChanged, object: nil)
            self?.dismiss(animated: true)
        }
        vc.subtitleLabel.attributedText = Formatter.getHighlightedAttributtedString(
            string: "Do you want to choose \(address) as your delivery address, please confirm if it's correct, and start to choose your meal.",
            keyWord: address,
            font: FontFamily.smallMedium!,
            highlightingFont: FontFamily.Poppins.semiBold.font(size: 12),
            highlightingColor: Colors.charcoal.color)
        show(vc, sender: nil)
    }
    
}

//MARK: -  DeliveryLocationView
extension DeliveryLocationViewController: DeliveryLocationView {
    
}

//MARK: -  Private
private extension DeliveryLocationViewController {
    
}


