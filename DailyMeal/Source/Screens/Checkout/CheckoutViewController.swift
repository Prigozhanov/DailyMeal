//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class CheckoutViewController: UIViewController {
    
    private var viewModel: CheckoutViewModel

	private var orderRouteViewController: OrderRouteViewController?
	
    private let stackView: AloeStackView = {
        let stack = AloeStackView()
        stack.hidesSeparatorsByDefault = true
        stack.separatorInset = .zero
		stack.rowInset = .zero
		stack.backgroundColor = .clear
        return stack
    }()
    
    private lazy var creditCardRow: PaymentMethodView = {
        PaymentMethodView(item:
            PaymentMethodView.Item(
				title: Localizable.OrderCheckout.creditCard,
                image: Images.Placeholders.creditCardSecond.image,
                isSelected: false,
                tapHandler: { [unowned self] view in
                    view.tapAnimation()
                    self.viewModel.paymentMethod = .creditCard
                    if self.viewModel.creditCard == nil {
                        let vc = AddCreditCardViewController(viewModel: AddCreditCardViewModelImplementation(onSaveSuccess: { [weak self] cardNumber in
                            self?.updateCreditCardLabel(with: cardNumber)
							self?.deselectAll()
							view.setSelected(true)
                        }))
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
						self.deselectAll()
						view.setSelected(true)
                    }
            })
        )
    }()
    
    private lazy var cashRow: PaymentMethodView = {
        PaymentMethodView(item:
            PaymentMethodView.Item(
				title: Localizable.OrderCheckout.cash,
                image: Images.Placeholders.cash.image,
                tapHandler: { [unowned self] view in
                    self.deselectAll()
					view.setSelected(true)
                    self.viewModel.paymentMethod = .cash
                    view.tapAnimation()
            })
        )
    }()
	
	private lazy var creditCardOnDeliveryRow: PaymentMethodView = {
		PaymentMethodView(item:
			PaymentMethodView.Item(
				title: Localizable.OrderCheckout.creditCardOnDelviery,
				image: Images.Placeholders.creditCardOnDelivery.image,
				tapHandler: { [unowned self] view in
					self.deselectAll()
					view.setSelected(true)
					self.viewModel.paymentMethod = .creditCardOnDelivery
					view.tapAnimation()
			})
		)
	}()
    
	private lazy var submitButton = ActionButton(Localizable.OrderCheckout.submitOrder) { [weak self] _ in
        self?.viewModel.checkoutOrder()
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
		
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
			$0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
		
		if let restaurant = viewModel.restaurant {
			orderRouteViewController = OrderRouteViewController(item: restaurant)
			addChild(orderRouteViewController!)
			orderRouteViewController!.didMove(toParent: self)
			orderRouteViewController!.view.snp.makeConstraints { $0.height.equalTo(340) }
			stackView.addRow(orderRouteViewController!.view)
		}
		
		let paymentMethodLabel = UILabel.makeText(Localizable.OrderCheckout.paymentMethod)
        stackView.addRow(paymentMethodLabel)
//        stackView.addRow(creditCardRow) // TODO: Will be imlemented in future
        stackView.addRow(cashRow)
		stackView.addRow(creditCardOnDeliveryRow)
        stackView.addRow(submitButton)
        
        submitButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
		
		stackView.setInset(forRow: paymentMethodLabel, inset: UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20))
		stackView.setInset(forRow: submitButton, inset: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
		
        updateCreditCardLabel(with: self.viewModel.creditCard?.number)
		
		switch viewModel.paymentMethod {
		case .creditCard:
			creditCardRow.setSelected(true)
		case .cash:
			cashRow.setSelected(true)
		case .creditCardOnDelivery:
			creditCardOnDeliveryRow.setSelected(true)
		}
		
		Style.addTitle(title: Localizable.OrderCheckout.checkout, self)
        Style.addNotificationButton(self) { (_) in
            
        }
        Style.addBackButton(self) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
	
	private func deselectAll() {
		cashRow.setSelected(false)
//		creditCardRow.setSelected(false)
		creditCardOnDeliveryRow.setSelected(false)
	}
    
    private func updateCreditCardLabel(with cardNumber: String?) {
//		creditCardRow.titleLabel.text = Formatter.CreditCard.hiddenNumber(string: cardNumber) ?? Localizable.OrderCheckout.creditCard
    }
    
}

// MARK: - CheckoutView
extension CheckoutViewController: CheckoutView {
	func onSuccessSubmit() {
		let vc = OrderPlacedViewController(deliveryTime: viewModel.restaurant?.orderDelayFirst ?? 0)
		UINotificationFeedbackGenerator.impact(.success)
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func onFailedSubmit() {
		UINotificationFeedbackGenerator.impact(.error)
	}
	
}

// MARK: - Private
private extension CheckoutViewController {
    
}
