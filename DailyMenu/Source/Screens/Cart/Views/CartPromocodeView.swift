//
//  Created by Vladimir on 1/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class CartPromocodeView: UIView {
    
    private let onApplyPromocode: VoidClosure
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Promo Code"
        return field
    }()
    
    private lazy var applyButton = UIButton.makeActionButton("Apply") { [weak self] button in
        button.tapAnimation()
        self?.onApplyPromocode()
    }
    
    init(onApplyPromocode: @escaping VoidClosure){
        self.onApplyPromocode = onApplyPromocode
        
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        let background = UIView()
        addSubview(background)
        background.backgroundColor = Colors.white.color
        background.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.top.equalToSuperview().inset(Layout.commonInset)
            $0.bottom.equalToSuperview().inset(Layout.largeMargin)
        }
        background.setRoundCorners(Layout.cornerRadius)
        background.setShadow(offset: CGSize(width: 0, height: 5.0), opacity: 0.05, radius: 10)
        
        background.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(Layout.commonInset)
        }
        
        background.addSubview(applyButton)
        applyButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(7)
            $0.leading.equalTo(textField.snp.trailing).inset(Layout.commonInset)
            $0.width.equalTo(116)
        }
        
    }
    
    public func setupGradient() {
        Style.addBlueGradient(applyButton)
    }
    
}
