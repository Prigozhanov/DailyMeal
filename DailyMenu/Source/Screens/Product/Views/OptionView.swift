//
//  Created by Vladimir on 2/11/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class OptionView: UIView {
    
    struct Item {
        let id: Int
        let title: String
        let minChoices: Int
        let maxChoices: Int
        let free: Int
        let freeMaxChoices: Int
        let choices: [ChoiceRow.Item]
    }
    
    private var item: Item
    
    private var selectedChoicesCount: Int
    
    private var choicesStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.distribution = .fillEqually
        stack.axis = .vertical
        return stack
    }()
    
    init(item: Item) {
        self.item = item
        
        selectedChoicesCount = item.choices.filter({ $0.isSelected }).count
        
        super.init(frame: .zero)
        
        let titleLabel = UILabel.makeSmallTitle(item.title)
        addSubviews([titleLabel, choicesStack])
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        choicesStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        
        item.choices.forEach {
            let choiceView = ChoiceRow(item: $0) { [weak self] choiceView in
                guard let self = self else { return }
                if self.item.maxChoices == 1 {
                    (self.choicesStack.arrangedSubviews as? [ChoiceRow])?.forEach({ $0.setSelected(false) })
                    choiceView.setSelected()
                } else if self.selectedChoicesCount >= self.item.maxChoices, !choiceView.item.isSelected {
                    print("TODO")
                } else if self.selectedChoicesCount <= self.item.minChoices, choiceView.item.isSelected {
                    print("TODO")
                } else {
                    choiceView.setSelected()
                    self.selectedChoicesCount = choiceView.item.isSelected ? self.selectedChoicesCount + 1 : self.selectedChoicesCount - 1
                }
            }
            self.choicesStack.addArrangedSubview(choiceView)
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
}
