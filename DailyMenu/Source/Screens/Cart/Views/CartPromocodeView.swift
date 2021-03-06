//
//  Created by Vladimir on 1/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class CartPromocodeView: UIView {
    
    typealias Item = (String?) -> Void
    
    private let item: Item
    
    private var promoCode: String?
    
    private lazy var textField: UITextField = {
        let field = UITextField()
		field.placeholder = Localizable.Cart.promo
        field.delegate = self
        return field
    }()
    
	private lazy var applyButton = ActionButton(Localizable.Cart.apply) { [weak self] _ in
        self?.item(self?.promoCode)
    }
    
    init(item: @escaping Item){
        self.item = item
        
        super.init(frame: .height(30))
        
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        let cardView = CardView(shadowSize: .medium, customInsets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardView.contentView.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(Layout.commonInset)
        }
        
        cardView.contentView.addSubview(applyButton)
        applyButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(7)
            $0.leading.equalTo(textField.snp.trailing).inset(Layout.commonInset)
            $0.width.equalTo(116)
        }
        
		applyButton.isEnabled = false // temporary
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
}

extension CartPromocodeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
