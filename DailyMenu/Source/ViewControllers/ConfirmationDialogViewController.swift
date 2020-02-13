//
//  Created by Vladimir on 2/9/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class ConfirmationDiagloViewController: UIViewController {
    
    private let dialogTitle: String
    private let dialogSubtitle: String
    private let onConfirm: VoidClosure
    private let onDismiss: VoidClosure
    
    private let cardView = CardView(shadowSize: .large, customInsets: .zero)
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.makeLargeText(self.dialogTitle)
        label.textAlignment = .center
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel.makeText(self.dialogSubtitle)
        label.font = FontFamily.Poppins.regular.font(size: 12)
        label.textColor = Colors.gray.color
        label.textAlignment = .center
        label.numberOfLines = 10
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton.makeActionButton("Confirm") { [weak self] button in
            button.tapAnimation()
            self?.dismiss(animated: true, completion: { [weak self] in
                self?.onConfirm()
            })
        }
        return button
    }()
    
   
    private lazy var cancelButton: UIButton = {
        let button = UIButton.makeCommonButton("Cancel") { [weak self] button in
            self?.dismiss(animated: true, completion: nil)
        }
        button.setTitleColor(Colors.gray.color, for: .normal)
        button.titleLabel?.font = FontFamily.Poppins.regular.font(size: 12)
        return button
    }()
    
    init(title: String, subtitle: String, onConfirm: @escaping VoidClosure, onDismiss: @escaping VoidClosure = {}) {
        dialogTitle = title
        dialogSubtitle = subtitle
        self.onConfirm = onConfirm
        self.onDismiss = onDismiss
        
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.black.color.withAlphaComponent(0.2)
        
        
        view.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.center.equalToSuperview()
        }
        
        cardView.contentView.addSubviews([titleLabel, subtitleLabel, confirmButton, cancelButton])
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            $0.trailing.leading.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(50)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(confirmButton.snp.bottom).offset(Layout.commonMargin)
            $0.height.equalTo(50)
            $0.trailing.bottom.leading.equalToSuperview().inset(Layout.commonInset)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(confirmButton)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: { [weak self] in
            self?.onDismiss()
            completion?()
        })
    }
    
}
