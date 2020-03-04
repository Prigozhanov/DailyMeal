//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class CartViewController: UIViewController {
    
    private var cartService: CartService = AppDelegate.shared.context.cartService
    
    private var aloeStackView: AloeStackView = {
        let stack = AloeStackView()
        stack.separatorHeight = 0
        stack.backgroundColor = .clear
        stack.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        stack.rowInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        return stack
    }()
    
    private lazy var titleRow: UIView = {
        let view = UIView()
		let title = UILabel.makeText(Localizable.Cart.yourCart)
        title.font = FontFamily.Poppins.bold.font(size: 18)
        view.addSubview(title)
        title.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Layout.commonInset)
        }
        return view
    }()
    
    private lazy var emptyCartRow: UILabel = {
		let label = UILabel.makeText(Localizable.Cart.cartIsEmpty)
        label.font = FontFamily.smallMedium
        label.textColor = Colors.gray.color
        label.textAlignment = .center
        return label
    }()
    
    private var itemRows: [CartItemView] = []
    
    private lazy var promocodeView = CartPromocodeView { _ in  // TODO
    }
    
    private var calculationRows: [UIView] = []
    
	private lazy var proceedActionButton = ActionButton(Localizable.Cart.proceedToCheckout) { _ in
		let vm = CheckoutViewModelImplementation()
		let vc = CheckoutViewController(viewModel: vm)
		let navigation = UINavigationController(rootViewController: vc)
		navigation.setNavigationBarHidden(true, animated: false)
		navigation.modalPresentationStyle = .overCurrentContext
		UIApplication.topViewController?.show(navigation, sender: nil)
	}
    
    private lazy var separator = UIView.makeSeparator()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        cartService.view = self
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        reloadScreen()
        
        view.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.promocodeView.resignFirstResponder()
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadScreen()
    }
	
    private func setupScreen() {
        Style.addBlueCorner(self)
		
        view.backgroundColor = Colors.commonBackground.color
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(aloeStackView)
        aloeStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
			$0.bottom.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func reloadScreen() {
        aloeStackView.removeAllRows()
        calculationRows = []
        setupTitleRow()
        setupEmptyCartRow()
        setupItemsRows()
        setupPromoRow()
        setupCalculationsRows()
        setupCheckoutRow()
    }
    
    private func setupTitleRow() {
        aloeStackView.addRow(titleRow)
    }
    
    private func setupEmptyCartRow() {
        aloeStackView.addRow(emptyCartRow)
        aloeStackView.setInset(forRow: emptyCartRow, inset: UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0))
        if !cartService.items.isEmpty {
            aloeStackView.hideRow(emptyCartRow)
        }
    }
    
    private func setupItemsRows() {
        itemRows = cartService.items.values.map({ item -> CartItemView in
            CartItemView(item: CartItemView.Item(
                cartItem: item,
                onRemoveItem: { [weak self] (itemView) in
					guard let self = self else { return }
                    self.cartService.removeItem(item: item)
                    self.aloeStackView.removeRow(itemView, animated: true)
                    if self.cartService.items.isEmpty {
                        self.aloeStackView.showRow(self.emptyCartRow, animated: true)
						self.tabBarController?.mainTabBar?.setBadgeVisible(false, at: 0)
						self.cartService.restaurant = nil
                    }
					self.reloadCalculationsRows()
					self.proceedActionButton.isEnabled = self.cartService.isValid
                },
                onChangeCount: { [weak self] value in
					guard let self = self else { return }
                    item.count = value
                    self.reloadCalculationsRows()
					self.proceedActionButton.isEnabled = self.cartService.isValid
            })
            )
        })
        aloeStackView.addRows(itemRows)
        if let lastRow = itemRows.last {
            aloeStackView.setInset(forRow: lastRow, inset: UIEdgeInsets(top: 0, left: 15, bottom: 30, right: 15))
        }
    }
    
    private func setupPromoRow() {
        aloeStackView.addRow(promocodeView)
    }
    
    private func setupCalculationsRows() {
		let cartTotalRow = CartTitleValueView(item: CartTitleValueView.Item(title: Localizable.Cart.cartTotal, value: Formatter.Currency.toString(cartService.cartTotal)))
		let deliveryRow = CartTitleValueView(item: CartTitleValueView.Item(title: Localizable.Cart.delivery, value: Formatter.Currency.toString(cartService.deliveryPrice)))
		let promoDiscauntRow = CartTitleValueView(item: CartTitleValueView.Item(title: Localizable.Cart.promoDiscaunt, value: Formatter.Currency.toString(cartService.promoDiscount)))
		let subtotalRow = CartTitleValueView(item: CartTitleValueView.Item(title: Localizable.Cart.subtotal, value: Formatter.Currency.toString(cartService.subtotal), preferesLargeValueLabel: true))
        
        calculationRows.append(contentsOf: [cartTotalRow, deliveryRow, promoDiscauntRow, separator, subtotalRow])
        aloeStackView.insertRows(calculationRows, after: promocodeView)
    }
    
    private func setupCheckoutRow() {
        aloeStackView.addRow(proceedActionButton)
        proceedActionButton.snp.makeConstraints { $0.height.equalTo(50) }
        if let lastRow = aloeStackView.lastRow {
            aloeStackView.setInset(forRow: lastRow, inset: UIEdgeInsets(top: 10, left: 45, bottom: 30, right: 45))
        }
		
		proceedActionButton.isEnabled = cartService.isValid
    }
    
}

// MARK: - Private
private extension CartViewController {
    
}

extension CartViewController: CartView {
    
    func reloadCalculationsRows() {
        aloeStackView.removeRows(calculationRows)
        calculationRows = []
        setupCalculationsRows()
    }
    
}
