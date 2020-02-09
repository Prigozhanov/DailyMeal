//
//  Created by Vladimir on 2/9/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class LocationSearchView: UIView {
    
    struct Item {
        let results: [String]
        let onSelectItem: (String, LocationSearchView?) -> Void
        let onLocationButtonTap: VoidClosure
        let shouldChangeCharacters: (String, LocationSearchView?) -> Void
    }
    
    private var item: Item
    
    private lazy var searchTextField = LocationSearchInputView(
        item: LocationSearchInputView.Item(
            onUserLocationButtonTapped: { [weak self] in
                self?.item.onLocationButtonTap()
        },
            shouldChangeCharacters: { [weak self] string in
                self?.item.shouldChangeCharacters(string, self)
        })
    )
    
    private lazy var locationResultsTableView = LocationResultsTableView { [weak self] address in
        self?.item.onSelectItem(address, self)
    }
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        setRoundCorners(Layout.cornerRadius)
        setBorder(width: 1, color: Colors.lightGray.color.cgColor)
        
        addSubviews([searchTextField, locationResultsTableView])
        
        searchTextField.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        locationResultsTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(searchTextField.snp.top)
        }
    }
    
    func updateResults(with results: [String]) {
        locationResultsTableView.reloadTableWithData(data: results)
    }
    
    func selectAddress(string: String) {
        updateResults(with: [])
        searchTextField.text = string
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
