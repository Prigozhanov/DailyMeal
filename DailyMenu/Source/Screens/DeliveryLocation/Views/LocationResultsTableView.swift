//
//  Created by Vladimir on 2/9/20.
//  Copyright © 2020 epam. All rights reserved.
//

import TableKit
import SnapKit

class LocationResultsTableView: UITableView {
    
    typealias Item = StringClosure
    
    private let item: Item
    
    private lazy var tableDirector = TableDirector(tableView: self)
    
    private var heightConstraint: Constraint?
    private let maxHeight: CGFloat = 250
    
    init(item: @escaping Item) {
        self.item = item
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100), style: .plain)
        backgroundColor = Colors.white.color
        estimatedSectionFooterHeight = 0
        estimatedSectionHeaderHeight = 0
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        snp.makeConstraints {
            self.heightConstraint = $0.height.equalTo(0).constraint
        }
    }
    
    func reloadTableWithData(data: [String]) {
        tableDirector.clear()
        let rows = data.map {
            TableRow<LocationResultRow>(item: $0)
                .on(.click) { [weak self] data in
                    self?.item(data.item)
            }
            
        }
        
        tableDirector.append(rows: rows)
        tableDirector.reload()
        layoutHeight()
    }
    
    private func layoutHeight() {
        heightConstraint?.update(
            offset: self.contentSize.height < maxHeight ? self.contentSize.height : maxHeight
        )
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
}

class LocationResultRow: BaseTableCell, ConfigurableCell {
    typealias CellData = String
    
    private var addressLabel: UILabel = {
        let label = UILabel.makeText()
        label.font = FontFamily.Poppins.medium.font(size: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        contentView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalToSuperview().inset(40 + Layout.commonInset)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func configure(with string: String) {
        addressLabel.text = string
    }
    
}
