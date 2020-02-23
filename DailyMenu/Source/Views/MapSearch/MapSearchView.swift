//
//  Created by Vladimir on 2/9/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class MapSearchView: UIView {
    
    struct Item {
        let placeholder: String
        let results: [String]
        let onSelectItem: (String, MapSearchView?) -> Void
        let onLocationButtonTap: VoidClosure
        var onFilterButtonTap: VoidClosure? = nil
        let shouldChangeCharacters: (String, MapSearchView?) -> Void
    }
    
    private var item: Item
    
    private lazy var searchTextField = MapSearchInputView(
        item: MapSearchInputView.Item(
            placeholder: item.placeholder,
            onFilterButtonTap: item.onFilterButtonTap,
            onUserLocationButtonTapped: { [weak self] in
                self?.item.onLocationButtonTap()
            },
            shouldChangeCharacters: { [weak self] string in
                self?.item.shouldChangeCharacters(string, self)
            }, shouldReturn: { [weak self] in
                self?.updateResults(with: [])
            }
        )
    )
    
    private lazy var resultsTableView = MapResultsTableView { [weak self] value in
        self?.selectValue(string: value)
        self?.item.onSelectItem(value, self)
    }
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        setRoundCorners(Layout.cornerRadius)
        setBorder(width: 1, color: Colors.lightGray.color.cgColor)
        
        addSubviews([searchTextField, resultsTableView])
        
        searchTextField.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        resultsTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(searchTextField.snp.top)
        }
    }
    
    func updateResults(with results: [String], searchString: String = "") {
        resultsTableView.reloadTableWithData(data: results, searchString: searchString)
    }
    
    func selectValue(string: String) {
        updateResults(with: [])
        searchTextField.text = string
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
