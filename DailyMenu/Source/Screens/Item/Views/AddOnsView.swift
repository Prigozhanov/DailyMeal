//
//  Created by Vladimir on 1/26/20.
//  Copyright © 2020 epam. All rights reserved.
//

import AloeStackView

class AddOnsView: UIView {
    
    private let itemViewModel: ItemViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.makeText()
        label.text = "Add ons"
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
    
    init(itemViewModel: ItemViewModel) {
        self.itemViewModel = itemViewModel
        
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
        
        itemViewModel.item.options.forEach { (addOn) in
            stackView.addArrangedSubview(AddOnView(option: addOn, itemViewModel: itemViewModel))
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        snp.remakeConstraints { $0.height.equalTo(stackView.frame.height + titleLabel.frame.height + 30) }
    }
    
    
}
