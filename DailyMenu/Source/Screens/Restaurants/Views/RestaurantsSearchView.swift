//
//  Created by Vladimir on 11/20/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class RestaurantsSearchView: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 10)
    
    var isActive: Bool = false
    
    var restaurantsViewModel: RestaurantsViewModel
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    init(viewModel: RestaurantsViewModel) {
        self.restaurantsViewModel = viewModel
        
        super.init(frame: .zero)
        
        returnKeyType = .done
        
        delegate = self
        
        let underlineView = UIView()
        addSubview(underlineView)
        underlineView.backgroundColor = Colors.gray.color
        underlineView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(CGFloat.onePixel)
        }
        
        let searchIcon = UIImageView(image: Images.Icons.search.image)
        addSubview(searchIcon)
        searchIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(20)
        }
        
        inputView?.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        placeholder = "Search Restaurent"
        font = FontFamily.regular
        textColor = Colors.black.color
        tintColor = Colors.gray.color
        backgroundColor = Colors.commonBackground.color
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}

extension RestaurantsSearchView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isActive = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isActive = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text else {
            return false
        }
        if string.isEmpty {
            text.removeLast()
            restaurantsViewModel.searchFilter = text
        } else {
            restaurantsViewModel.searchFilter = text + string
        }
        restaurantsViewModel.view?.reloadScreen()
        return true
    }
    
}
