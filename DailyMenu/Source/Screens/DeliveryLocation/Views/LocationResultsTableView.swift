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
    
    func reloadTableWithData(data: [String], searchString: String) {
        tableDirector.clear()
        let rows = data.map {
            TableRow<LocationResultRow>(item: LocationResultRow.Item(string: $0, searchText: searchString))
                .on(.click) { [weak self] data in
                    self?.item(data.item.string)
            }
            
        }
        
        tableDirector.append(rows: rows)
        tableDirector.reload()
        layoutHeight()
    }
    
    private func layoutHeight() {
        heightConstraint?.update(
            offset: self.contentSize.height < maxHeight ? self.contentSize.height : maxHeight //TODO acnhor to top constraint
        )
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
}
