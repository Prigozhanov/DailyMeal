//
//  Created by Vladimir on 2/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import TableKit

class MapResultRow: BaseTableCell, ConfigurableCell {
    typealias CellData = Item
    
    struct Item {
        let string: String
        let searchText: String
    }
    
    static var estimatedHeight: CGFloat? {
        return 50.0
    }
    
    private var label: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Avenir.medium.font(size: 14)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalToSuperview().inset(40 + Layout.commonInset)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func configure(with item: MapResultRow.Item) {
        label.attributedText = Formatter.getHighlightedAttributtedString(
            string: item.string,
            keyWord: item.searchText,
            font: FontFamily.Avenir.book.font(size: 14),
            highlightingFont: FontFamily.Avenir.black.font(size: 14)
        )
    }
    
}
