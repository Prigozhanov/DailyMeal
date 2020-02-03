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
    
    private let navigationBarControls = NavigationBarControls(title: "Checkout", appearance: .dark)
    
    private lazy var cashRow: PaymentMethodView = {
        PaymentMethodView(item:
            PaymentMethodView.Item(
                title: "Cash",
                image: Images.cash.image,
                tapHandler: { [unowned self] view in
                    self.creditCardRow.setSelected(false)
                    self.viewModel.paymentMethod = .cash
                    view.tapAnimation()
            })
        )
    }()
    
    private lazy var creditCardRow: PaymentMethodView = {
        PaymentMethodView(item:
            PaymentMethodView.Item(
                title: "Credit/Debt cart",
                image: Images.creditCard.image,
                tapHandler: { [unowned self] view in
                    self.cashRow.setSelected(false)
                    self.viewModel.paymentMethod = .creditCard
                    view.tapAnimation()
            })
        )
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
        
        view.backgroundColor = Colors.commonBackground.color
        
        navigationBarControls.titleLabel.font = FontFamily.largeRegular
        
        view.addSubview(navigationBarControls)
        navigationBarControls.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(navigationBarControls.snp.bottom)
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


