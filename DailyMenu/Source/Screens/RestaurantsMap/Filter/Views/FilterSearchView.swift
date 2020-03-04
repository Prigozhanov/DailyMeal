//
//  Created by Vladimir on 2/23/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class FilterSearchView: UIView {
    
    struct Item {
        let placeholder: String
        let onSearchAction: StringClosure
    }
    
    private let item: Item
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = Colors.lightGray.color
        textField.textColor = Colors.charcoal.color
        textField.placeholder = item.placeholder
        textField.font = FontFamily.regular
		textField.delegate = self
        return textField
    }()
    
	private lazy var searchActionButton = ActionButton(Localizable.RestaurantsMap.search) { [weak self] _ in
		self?.item.onSearchAction(self?.textField.text ?? "")
	}
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        backgroundColor = Colors.white.color
        setRoundCorners(Layout.cornerRadius)
        setBorder(width: 1, color: Colors.lightGray.color)
        
        addSubviews([textField, searchActionButton])
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(Layout.commonInset)
            $0.trailing.equalTo(searchActionButton.snp.leading).inset(-Layout.largeMargin)
        }
        
        searchActionButton.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(100).priority(.required)
        }
        
        addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.textField.becomeFirstResponder()
        }))
    }
    
    required init?(coder: NSCoder) { fatalError() }

}

extension FilterSearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
        return true
    }
    
}
