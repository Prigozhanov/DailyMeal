//
//  Created by Vladimir on 2/3/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class OrderStateRow: UIView {
    
    init(title: String, time: String, checked: Bool) {
        super.init(frame: .zero)
        
        let checkMark = UIImageView(image: checked ? Images.Icons.checkmarkChecked.image : Images.Icons.checkmarkNotMarked.image)
        addSubview(checkMark)
        checkMark.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        let titleLabel = UILabel.makeText(title)
        addSubview(titleLabel)
        titleLabel.font = checked ? FontFamily.semibold : FontFamily.regular
        titleLabel.textColor = checked ? Colors.smoke.color : Colors.gray.color
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(checkMark.snp.trailing).offset(Layout.largeMargin)
            $0.top.bottom.equalToSuperview()
        }
        
        let timeLabel = UILabel.makeSmallText(time)
        timeLabel.textColor = Colors.gray.color
        timeLabel.textAlignment = .right
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
