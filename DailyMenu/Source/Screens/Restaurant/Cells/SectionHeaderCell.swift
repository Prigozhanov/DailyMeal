//
//  Created by Vladimir on 12/10/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class SectionHeaderCell: UIView {
    
    struct Item {
        let section: String
        let itemsCount: Int
    }
    
    private let sectionLabel: UILabel = {
        let label = UILabel.makeLargeText()
        label.font = FontFamily.Poppins.semiBold.font(size: 18)
		label.numberOfLines = 2
        return label
    }()
    
    private let itemsCountLabel = UILabel.makeSmallText()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Layout.largeMargin * 2)
            $0.bottom.equalToSuperview().inset(Layout.commonInset)
        }

        addSubview(itemsCountLabel)
        itemsCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(sectionLabel.snp.bottom).inset(4)
			$0.leading.equalTo(sectionLabel.snp.trailing).offset(Layout.largeMargin)
			$0.trailing.lessThanOrEqualToSuperview().inset(Layout.commonInset)
        }
		itemsCountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    func configure(item: Item) {
        sectionLabel.text = item.section
		let localizedString = NSLocalizedString("items_count", comment: "Plural localized string")
		let formattedString = String.localizedStringWithFormat(localizedString, item.itemsCount)
		itemsCountLabel.text = formattedString
    }
    
}
