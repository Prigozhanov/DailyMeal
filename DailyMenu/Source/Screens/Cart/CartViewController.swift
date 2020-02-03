//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class CartViewController: UIViewController {
    
    private var cartSerivce: CartService = AppDelegate.shared.context.cartService
    
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
        let title = UILabel.makeText("Your Food Cart")
        title.font = FontFamily.Poppins.bold.font(size: 18)
        view.addSubview(title)
        title.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Layout.commonInset)
        }
        return view
    }()
    
    private lazy var emptyCartRow: UILabel = {
        let label = UILabel.makeText("Cart is empty")
        label.font = FontFamily.smallMedium
        label.textColor = Colors.gray.color
        label.textAlignment = .center
        return label
    }()
    
    private var itemRows: [CartItemView] = []
    
    private lazy var promocodeView = CartPromocodeView { _ in 
        //TODO
    }
    
    private var calculationRows: [UIView] = []
    
    private lazy var proceedActionButton = UIButton.makeActionButton("Proceed to Checkout") { [weak self] button in
        let vm = CheckoutViewModelImplementation()
        let vc = CheckoutViewController(viewModel: vm)
        let navigation = UINavigationController(rootViewController: vc)
        navigation.setNavigationBarHidden(true, animated: false)
        navigation.modalPresentationStyle = .overCurrentContext
        button.tapAnimation()
        UIApplication.topViewController?.show(navigation, sender: nil)
    }
    
    private lazy var separator = UIView.makeSeparator()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        cartSerivce.view = self
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        reloadScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadScreen()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(proceedActionButton)
        promocodeView.setupGradient()
    }
    
    private func setupScreen() {
        Style.addBlueCorner(self)
        
        view.backgroundColor = Colors.commonBackground.color
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(aloeStackView)
        aloeStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
        if !cartSerivce.items.isEmpty {
            aloeStackView.hideRow(emptyCartRow)
        }
    }
    
    private func setupItemsRows() {
        itemRows = cartSerivce.items.values.map({ item -> CartItemView in
            CartItemView(item: CartItemView.Item(
                cartItem: item,
                onRemoveItem: { [weak self] (itemView) in
                    self?.cartSerivce.removeItem(item: item)
                    self?.reloadCalculationsRows()
                    self?.aloeStackView.removeRow(itemView, animated: true)
                    if let self = self, self.cartSerivce.items.isEmpty {
                        self.aloeStackView.showRow(self.emptyCartRow, animated: true)
                    }
                    
                },
                onChangeCount: { [weak self] (value) in
                    self?.reloadCalculationsRows()
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
        let cartTotalRow = CartTitleValueView(item: CartTitleValueView.Item(title: "Cart total", value: Formatter.Currency.toString(cartSerivce.cartTotal)))
        let taxRow = CartTitleValueView(item: CartTitleValueView.Item(title: "Tax", value: Formatter.Currency.toString(cartSerivce.tax)))
        let deliveryRow = CartTitleValueView(item: CartTitleValueView.Item(title: "Delivery", value: Formatter.Currency.toString(cartSerivce.deliveryPrice)))
        let promoDiscauntRow = CartTitleValueView(item: CartTitleValueView.Item(title: "Promo discaunt", value: Formatter.Currency.toString(cartSerivce.promoDiscount)))
        let subtotalRow = CartTitleValueView(item: CartTitleValueView.Item(title: "Subtotal", value: Formatter.Currency.toString(cartSerivce.subtotal), preferesLargeValueLabel: true))
        
        calculationRows.append(contentsOf: [cartTotalRow, taxRow, deliveryRow, promoDiscauntRow, separator, subtotalRow])
        aloeStackView.insertRows(calculationRows, after: promocodeView)
    }
    
    private func setupCheckoutRow() {
        aloeStackView.addRow(proceedActionButton)
        proceedActionButton.snp.makeConstraints { $0.height.equalTo(50) }
        if let lastRow = aloeStackView.lastRow {
            aloeStackView.setInset(forRow: lastRow, inset: UIEdgeInsets(top: 10, left: 45, bottom: 30, right: 45))
        }
    }
    
}

//MARK: -  Private
private extension CartViewController {
    
}

extension CartViewController: CartView {
    
    func reloadCalculationsRows() {
        aloeStackView.removeRows(calculationRows)
        calculationRows = []
        setupCalculationsRows()
    }
    
}

