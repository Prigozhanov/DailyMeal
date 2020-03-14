//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import MapKit
import UIKit
import Extensions
import Services
import SnapKit
import RxSwift

final class DeliveryLocationViewController: UIViewController, KeyboardObservable {
    
    private var viewModel: DeliveryLocationViewModel
    
    private var alertDialogIsVisible: Bool = false
    
	let bag = DisposeBag()
	
	var observableConstraints: [ObservableConstraint] = []
	
    private let headerView = MapHeaderView(
		title: Localizable.DeliveryLocation.deliveryLocation,
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
    
    private var locationSearchViewBottomConstraint: Constraint?
    private let locationSearchBottomInset: CGFloat = 60
	
	private lazy var addressDetailsView = AddressDetailsView(
		item: AddressDetailsView.Item(
			onSelectAddress: { [weak self] address in
				self?.viewModel.requestGeodcode(string: address, onSuccess: { address in
					self?.showConfiramtionDialog(address: address)
				})
			},
			onLocationButtonTap: { [weak self] in
				self?.mapController.moveCameraToUserLocation()
				let currentLocation = self?.mapController.viewModel.getUserLocation()
				
				let formattedPositionString = "\(currentLocation?.longitude ?? 0),\(currentLocation?.latitude ?? 0)"
				
				self?.viewModel.requestGeodcode(string: formattedPositionString, onSuccess: { [weak self] address in
					self?.showConfiramtionDialog(address: address)
				})
			},
			shouldChangeCharacters: { [weak self] string, searchView in
				self?.viewModel.getAddressesList(string: string, completion: { addresses in
					searchView?.updateResults(with: addresses, searchString: string)
				})
			},
			onSaveDetails: { [weak self] address, apartments, floor in
				self?.viewModel.userAddressMeta?.apartments = apartments
				self?.viewModel.userAddressMeta?.floor = floor
				self?.viewModel.userAddressMeta?.addressName = address
				self?.viewModel.saveAddressInfo()
				NotificationCenter.default.post(name: .userAddressChanged, object: nil)
				self?.dismiss(animated: true, completion: nil)
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
        
        addChild(mapController)
        
		view.addSubview(mapController.view)
		mapController.view.snp.makeConstraints {
			$0.leading.trailing.top.equalToSuperview()
			observableConstraints.append(
				ObservableConstraint(
					constraint: $0.bottom.equalToSuperview().constraint,
					inset: 0
				)
			)
		}
		
		view.addSubview(headerView)
		headerView.snp.makeConstraints {
			$0.leading.trailing.equalToSuperview()
			$0.height.equalTo(150)
		}
		
		view.addSubview(addressDetailsView)
		addressDetailsView.snp.makeConstraints {
			observableConstraints.append(
				ObservableConstraint(
					constraint: $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(60).constraint,
					inset: 60,
					keyboardOffset: 20
				)
			)
			$0.leading.trailing.equalToSuperview().inset(20)
		}
        
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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		startObserveKeyboard()
	}
    
    func showConfiramtionDialog(address: String) {
		let vc = ConfirmationDiaglogViewController(title: Localizable.DeliveryLocation.addressConfirmation, subtitle: "", onConfirm: { [weak self] in
			self?.addressDetailsView.item.address = address
			self?.addressDetailsView.showDetailedView()
            }, onDismiss: { [weak self] in
                self?.alertDialogIsVisible = false
        })
        vc.subtitleLabel.attributedText = Formatter.getHighlightedAttributtedString(
            string: Localizable.DeliveryLocation.doYouWantToChooseAddress(address),
            keyWord: address,
            font: FontFamily.smallMedium!,
            highlightingFont: FontFamily.Avenir.black.font(size: 12),
            highlightingColor: Colors.charcoal.color)
        if alertDialogIsVisible == false {
            alertDialogIsVisible = true
            show(vc, sender: nil)
        }
    }
	
}

// MARK: - DeliveryLocationView
extension DeliveryLocationViewController: DeliveryLocationView {
	func showErrorMessage(_ message: String) {
		let vc = AlertDiaglogViewController(title: Localizable.Common.error, subtitle: message, onDismiss: { [weak self] in
			self?.alertDialogIsVisible = false
		})
		if alertDialogIsVisible == false {
			alertDialogIsVisible = true
			show(vc, sender: nil)
		}
	}
}

// MARK: - Private
private extension DeliveryLocationViewController {
    
	func updateConstraint(constraint: Constraint?, inset: CGFloat) {
		constraint?.update(inset: inset)
		UIView.transition(with: self.view, duration: 0.3, options: [], animations: { [weak self] in
			self?.view.layoutSubviews()
			self?.mapController.view.layoutSubviews()
			}, completion: nil)
	}
	
}
