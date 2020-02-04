//
//  Created by Vladimir on 1/26/20.
//  Copyright © 2020 epam. All rights reserved.
//

import AloeStackView
import Networking

class OptionsStackView: UIView {
    
    struct Item {
        let options: [Option]
        let onSelectOption: (Option) -> Void
    }
    
    private var item: Item
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText()
        label.text = "Options"
        label.font = FontFamily.Poppins.medium.font(size: 14)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    init(item: Item) {
        self.item = item
        
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(Layout.commonInset)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Layout.largeMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        item.options.forEach {
            let optionView = OptionView(item: OptionView.Item(
                option: $0,
                onSelectOption: item.onSelectOption,
                isSelected: $0.active == 1)
            )
            stackView.addArrangedSubview(optionView)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
