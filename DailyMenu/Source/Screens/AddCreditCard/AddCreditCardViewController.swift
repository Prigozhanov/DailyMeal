//
//  AddCreditCardViewController.swift
//

import UIKit
import Extensions
import SnapKit

final class AddCreditCardViewController: UIViewController {
    
    private var viewModel: AddCreditCardViewModel
    
    private lazy var cardInfoView = CardInfoView { [weak self] (details) in
        guard let self = self else { return }
        self.viewModel.saveCreditCardDetails(
            number: details.number,
            month: details.month,
            year: details.year,
            cvv: details.cvv
        )
        if self.viewModel.isValid {
            self.navigationController?.popViewController(animated: true)
        } else {
            
        }
    }
    
    private var notificationTokens: [Token] = []
    
    private var bottomConstraint: Constraint?
    
    init(viewModel: AddCreditCardViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        Style.addBlueCorner(self)
        
        notificationTokens.append(Token.make(descriptor: .keyboardWillChangeFrameDescriptor, using: { [weak self] frame in
            self?.updateBottomConstraint(offset: frame.height - (self?.view.safeAreaInsets.bottom ?? 0))
        }))
        
        notificationTokens.append(Token.make(descriptor: .keyboardWillHideDescriptor, using: { [weak self] frame in
            self?.updateBottomConstraint(offset: 0)
        }))
        
        let placeholderImage = UIImageView(image: Images.Placeholders.creditCard.image)
        placeholderImage.contentMode = .scaleAspectFit
        view.addSubview(placeholderImage)
        placeholderImage.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        var bottomConstraint: Constraint?
        view.addSubview(cardInfoView)
        cardInfoView.snp.makeConstraints {
            $0.top.equalTo(placeholderImage.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            bottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
        }
        self.bottomConstraint = bottomConstraint
        
        Style.addTitle(title: "Add Credit Card", self)
        Style.addBackButton(self) { [weak self] _ in
            self?.dismissController()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cardInfoView.setupGradient()
    }
    
    private func updateBottomConstraint(offset: CGFloat) {
        UIView.transition(with: self.cardInfoView, duration: 0.3, options: [], animations: { [weak self] in
            self?.bottomConstraint?.update(inset: offset)
            self?.view.layoutIfNeeded()
            }, completion: nil)
    }
    
}

//MARK: -  AddCreditCardView
extension AddCreditCardViewController: AddCreditCardView {
    func dismissController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: -  Private
private extension AddCreditCardViewController {
    
}


