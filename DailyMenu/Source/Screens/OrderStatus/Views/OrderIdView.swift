//
//  Created by Vladimir on 2/3/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class OrderIdView: UIView {
    
    init(id: String) {
        super.init(frame: .zero)
        
		let titleLabel = UILabel.makeSmallText(Localizable.OrderStatus.yourOrderId)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        let idLabel = UILabel.makeText(id)
        idLabel.font = FontFamily.Poppins.semiBold.font(size: 30)
        idLabel.textColor = Colors.blue.color
        addSubview(idLabel)
        idLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
