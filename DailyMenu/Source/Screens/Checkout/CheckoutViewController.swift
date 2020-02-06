//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class CheckoutViewController: UIViewController {
    
    private var viewModel: CheckoutViewModel
    
    private let stackView: AloeStackView = {
        let stack = AloeStackView()
        stack.hidesSeparatorsByDefault = true
        stack.separatorInset = .zero
        stack.rowInset = .zero
        return stack
    }()
    
    private lazy var cashRow: PaymentMethodView = {
        PaymentMethodView(item:
            PaymentMethodView.Item(
                title: "Cash",
                image: Images.Placeholders.cash.image,
                tapHandler: { [unowned self] view in
                    view.setSelected(true)
                    self.creditCardRow.setSelected(false)
                    self.viewModel.paymentMethod = .cash
                    view.tapAnimation()
            })
        )
    }()
    
    private lazy var creditCardRow: PaymentMethodView = {
        let view = PaymentMethodView(item:
            PaymentMethodView.Item(
                title: "Credit/Debt cart",
                image: Images.Placeholders.creditCardSecond.image,
                isSelected: viewModel.creditCard != nil,
                tapHandler: { [unowned self] view in
                    view.tapAnimation()
                    view.setSelected(true)
                    self.cashRow.setSelected(false)
                    self.viewModel.paymentMethod = .creditCard
                    if self.viewModel.creditCard == nil {
                        let vc = AddCreditCardViewController(viewModel: AddCreditCardViewModelImplementation())
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
            })
        )
        return view
    }()
    
    private lazy var submitButton = UIButton.makeActionButton("Submit Order") { [weak self] button in
        button.tapAnimation()
        let vc = OrderPlacedViewController()
        self?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        Style.addBlueCorner(self)
        
        creditCardRow.titleLabel.text = Formatter.CreditCard.hiddenNumber(string: viewModel.creditCard?.number) ?? "Credit/Debt cart"
        
        view.backgroundColor = Colors.commonBackground.color
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(150)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        let paymentMethodLabel = UILabel.makeText("Payment method")
        stackView.addRow(paymentMethodLabel)
        stackView.addRow(creditCardRow)
        stackView.addRow(cashRow)
        stackView.addRow(submitButton)
        
        stackView.setInset(forRow: paymentMethodLabel, inset: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        stackView.setInset(forRow: submitButton, inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        submitButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        Style.addTitle(title: "Checkout", self)
        Style.addNotificationButton(self) { (_) in
            
        }
        Style.addBackButton(self) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(submitButton)
    }
    
}

//MARK: -  CheckoutView
extension CheckoutViewController: CheckoutView {
    
}

//MARK: -  Private
private extension CheckoutViewController {
    
}


