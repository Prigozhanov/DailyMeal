//
//  Created by Vladimir on 3/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class AddressDetailsView: UIView {
	
	struct Item {
		let onSelectAddress: StringClosure
		let onLocationButtonTap: VoidClosure
		let shouldChangeCharacters: (String, MapSearchView?) -> Void
		let onSaveDetails: (String?, String?, String?) -> Void
		
		var address: String?
		var apartments: String?
		var floor: String?
	}
	
	var item: Item
	
	private lazy var locationSearchView = MapSearchView(
		item: MapSearchView.Item(
			placeholder: Localizable.DeliveryLocation.typeDeliveryLocation,
			results: [],
			onSelectItem: { [weak self] address, searchView in
				self?.item.onSelectAddress(address)
			}, onLocationButtonTap: { [weak self] in
				self?.item.onLocationButtonTap()
			}, shouldChangeCharacters: { [weak self] string, searchView in
				self?.item.shouldChangeCharacters(string, searchView)
		})
	)
	
	private lazy var selectedAddresInput: TextField = {
		let  textField = TextField(
			placeholder: "",
			image: Images.Icons.mapPin1.image,
			shouldShowClearButton: false,
			textAlignment: .center,
			shouldChangeCharacters: { _, _, _ in
				return false
		})
		textField.leftImageView.tintColor = Colors.blue.color
		textField.isUserInteractionEnabled = false
		textField.backgroundColor = Colors.white.color
		return textField
	}()
	
	private lazy var apartamentsInput: TextField = {
		let  textField = TextField(
			placeholder: Localizable.DeliveryLocation.apartments,
			image: nil,
			shouldShowClearButton: false,
			textAlignment: .center,
			shouldChangeCharacters: { [weak self] textField, _, string -> Bool in
				if let text = textField.text?.appending(string) {
					self?.item.apartments = text
				}
				return true
		})
		textField.keyboardType = .numberPad
		textField.backgroundColor = Colors.white.color
		return textField
	}()
	
	private lazy var floorInput: TextField = {
		let  textField = TextField(
			placeholder: Localizable.DeliveryLocation.floor,
			image: nil,
			shouldShowClearButton: false,
			textAlignment: .center,
			shouldChangeCharacters: { [weak self] textField, _, string -> Bool in
				if let text = textField.text?.appending(string) {
					self?.item.floor = text
				}
				return true
		})
		textField.keyboardType = .numberPad
		textField.backgroundColor = Colors.white.color
		return textField
	}()
	
	private lazy var saveButton = ActionButton("Save") { [weak self] _ in
		self?.item.onSaveDetails(self?.item.address, self?.item.apartments, self?.item.floor)
	}
	
	init(item: Item) {
		self.item = item
		super.init(frame: .zero)
		addSubviews([locationSearchView, apartamentsInput, floorInput, saveButton])
		
		locationSearchView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.leading.trailing.equalToSuperview()
			$0.bottom.equalToSuperview().offset(20).priority(.medium)
		}
		
	}
	
	required init?(coder: NSCoder) {
		fatalError()
	}
	
	func showDetailedView() {
		locationSearchView.removeFromSuperview()
		
		selectedAddresInput.text = item.address ?? ""
		selectedAddresInput.setBorder(width: 1, color: Colors.blue.color)
		
		addSubviews([selectedAddresInput, apartamentsInput, floorInput, saveButton])
		selectedAddresInput.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview()
			$0.height.equalTo(50)
		}
		
		apartamentsInput.snp.makeConstraints {
			$0.top.equalTo(selectedAddresInput.snp.bottom).offset(Layout.largeMargin).priority(.high)
			$0.leading.equalToSuperview()
			$0.width.equalTo(selectedAddresInput).dividedBy(2.2)
			$0.height.equalTo(50)
		}
		
		floorInput.snp.makeConstraints {
			$0.top.equalTo(selectedAddresInput.snp.bottom).offset(Layout.largeMargin).priority(.high)
			$0.trailing.equalToSuperview()
			$0.width.equalTo(selectedAddresInput).dividedBy(2.2)
			$0.height.equalTo(50)
		}
		
		saveButton.snp.makeConstraints {
			$0.top.equalTo(apartamentsInput.snp.bottom).offset(Layout.largeMargin)
			$0.leading.trailing.bottom.equalToSuperview()
			$0.height.equalTo(50)
		}
		
		layoutIfNeeded()
	}
	
}
