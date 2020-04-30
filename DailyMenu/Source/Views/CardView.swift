//
//  Created by Vladimir on 1/26/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    enum ShadowSize {
        case small, medium, large
    }
    
    private let shadowSize: ShadowSize
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white.color
        view.setRoundCorners(Layout.cornerRadius)
        switch shadowSize {
        case .small:
            view.setShadow(offset: CGSize(width: 0, height: 3.0), opacity: 0.1, radius: 5)
        case .medium:
            view.setShadow(offset: CGSize(width: 0, height: 3.0), opacity: 0.1, radius: 10)
        case .large:
            view.setShadow(offset: CGSize(width: 0, height: 3.0), opacity: 0.1, radius: 15)
        }
        return view
    }()
    
    init(shadowSize: ShadowSize, customInsets: UIEdgeInsets? = nil) {
        self.shadowSize = shadowSize
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubview(contentView)
        if let customInsets = customInsets {
            contentView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(customInsets.top)
                $0.bottom.equalToSuperview().inset(customInsets.bottom)
                $0.leading.equalToSuperview().inset(customInsets.left)
                $0.trailing.equalToSuperview().inset(customInsets.right)
            }
        } else {
            contentView.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(Layout.commonInset)
            }
        }
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
}
