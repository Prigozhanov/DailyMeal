//
//  Created by Vladimir on 11/20/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class RestaurantsSearchView: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 10)
    
    init() {
        super.init(frame: .zero)
        
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
    
    required init?(coder: NSCoder) { super.init(frame: .zero) }
    
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
