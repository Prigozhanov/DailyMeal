//
//  Created by Vladimir on 1/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class CartTitleValueView: UIView {
    
    private var title: String
    private var value: String
    private var preferesLargeValueLabel: Bool
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText(title)
        label.font = FontFamily.regular
        label.textColor = Colors.smoke.color
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel.makeText(value)
        label.textAlignment = .right
        label.font = FontFamily.regular
        if preferesLargeValueLabel {
            label.font = FontFamily.Poppins.semiBold.font(size: 20)
        }
        return label
    }()
    
    
    init(title: String, value: String, preferesLargeValueLabel: Bool = false) {
        self.title = title
        self.value = value
        self.preferesLargeValueLabel = preferesLargeValueLabel
        
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(Layout.commonInset)
        }
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(titleLabel.snp.trailing)
        }
    }
    
}
