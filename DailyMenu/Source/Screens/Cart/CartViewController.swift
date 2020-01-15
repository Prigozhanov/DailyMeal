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
        let title = UILabel.makeLargeText("Your Food Cart")
        title.font = FontFamily.Poppins.bold.font(size: 18)
        view.addSubview(title)
        title.snp.makeConstraints {
            $0.bottom.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Layout.commonInset)
        }
        return view
    }()
    
    private lazy var promocodeRow: UIView = {
        let view = UIView()
        
        let background = UIView()
        view.addSubview(background)
        background.backgroundColor = Colors.white.color
        background.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.trailing.top.equalToSuperview().inset(Layout.commonInset)
            $0.bottom.equalToSuperview().inset(Layout.largeMargin)
        }
        background.setRoundCorners(Layout.cornerRadius)
        background.setShadow(offset: CGSize(width: 0, height: 5.0), opacity: 0.05, radius: 10)
        
        background.addSubview(promocodeTextField)
        promocodeTextField.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(Layout.commonInset)
        }
        
        background.addSubview(promocodeApplyButton)
        promocodeApplyButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(7)
            $0.leading.equalTo(promocodeTextField.snp.trailing).inset(Layout.commonInset)
            $0.width.equalTo(116)
        }
        
        return view
    }()
    
    private lazy var promocodeTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Promo Code"
        return field
    }()
    
    private lazy var promocodeApplyButton: UIButton = {
        let button = UIButton.makeActionButton("Apply") { _ in
            // TODO
        }
        button.titleLabel?.font = FontFamily.Poppins.medium.font(size: 14)
        return button
    }()
    
    private var calculationRows: [UIView] = []
    
    private lazy var proceedActionButton: UIButton = {
        let button = UIButton.makeActionButton("Proceed to Checkout") { [weak self] _ in
            // TODO
        }
        button.titleLabel?.font = FontFamily.semibold
        return button
    }()
    
    private lazy var emptyCartRow: UILabel = {
        let label = UILabel.makeText("Cart is empty")
        label.font = FontFamily.smallMedium
        label.textColor = Colors.gray.color
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.lightGray.color
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        reloadScreen()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(promocodeApplyButton)
        Style.addBlueGradient(proceedActionButton)
    }
    
    private func setupScreen() {
        Style.addBlueCorner(self)
        
        view.backgroundColor = Colors.commonBackground.color
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.addSubview(aloeStackView)
        aloeStackView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.snp_topMargin)
        }
    }
    
    private func reloadScreen() {
        aloeStackView.removeAllRows()
        calculationRows = []
        setupTitleRow()
        setupItemsRows()
        setupPromoRow()
        setupCalculationsRows()
        setupCheckoutRow()
    }
    
    func reloadCalculationsRows() {
        aloeStackView.removeRows(calculationRows)
        aloeStackView.removeRow(separator)
        calculationRows = []
        setupCalculationsRows()
    }
    
    private func setupTitleRow() {
        aloeStackView.addRow(titleRow)
    }
    
    private func setupItemsRows() {
        aloeStackView.addRow(emptyCartRow)
        aloeStackView.setInset(forRow: emptyCartRow, inset: UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0))
        if !cartSerivce.items.isEmpty {
            aloeStackView.hideRow(emptyCartRow)
        }
        
        aloeStackView.addRows(cartSerivce.items.map({ item -> UIView in
            makeItemRow(item)
        }))
        if let lastRow = aloeStackView.lastRow {
            aloeStackView.setInset(forRow: lastRow, inset: UIEdgeInsets(top: 0, left: 15, bottom: 30, right: 15))
        }
    }
    
    private func setupPromoRow() {
        aloeStackView.addRow(promocodeRow)
    }
    
    private func setupCalculationsRows() {
        let cartTotalRow = makeTitleValueRow(title: "Cart total", value: Formatter.Currency.toString(cartSerivce.cartTotal))
        let taxRow = makeTitleValueRow(title: "Tax", value: Formatter.Currency.toString(cartSerivce.tax))
        let deliveryRow = makeTitleValueRow(title: "Delivery", value: Formatter.Currency.toString(cartSerivce.deliveryPrice))
        let promoDiscauntRow = makeTitleValueRow(title: "Promo discaunt", value: Formatter.Currency.toString(cartSerivce.promoDiscount))
        let subtotalRow = makeTitleValueRow(title: "Subtotal", value: Formatter.Currency.toString(cartSerivce.subtotal), largeValueTitle: true)
        
        calculationRows.append(contentsOf: [cartTotalRow, taxRow, deliveryRow, promoDiscauntRow, subtotalRow])
        aloeStackView.insertRows(calculationRows, after: promocodeRow)
        aloeStackView.insertRow(separator, before: subtotalRow)
        separator.snp.makeConstraints { $0.height.equalTo(1) }
    }
    
    private func setupCheckoutRow() {
        aloeStackView.addRow(proceedActionButton)
        if let lastRow = aloeStackView.lastRow {
            aloeStackView.setInset(forRow: lastRow, inset: UIEdgeInsets(top: 10, left: 45, bottom: 30, right: 45))
        }
    }
    
    private func makeItemRow(_ item: CartItem) -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.white.color
        view.setRoundCorners(Layout.cornerRadius)
        view.setShadow(offset: CGSize(width: 0, height: 5.0), opacity: 0.05, radius: 20)
        view.snp.makeConstraints { $0.height.equalTo(100) }
        let counter = ItemCounter { [weak self] value in
            item.count = value
            self?.reloadCalculationsRows()
        }
        counter.updateValue(item.count)
        view.addSubview(counter)
        counter.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.width.equalTo(50)
        }
        
        let shadow = UIView()
        view.addSubview(shadow)
        shadow.setRoundCorners(Layout.cornerRadius)
        shadow.setShadow(offset: CGSize(width: 0, height: 5), opacity: 0.1, radius: 10)
        shadow.backgroundColor = .white
        shadow.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(counter.snp.trailing).offset(Layout.largeMargin)
            $0.size.equalTo(view.snp.height).inset(Layout.commonInset)
        }
        
        let itemImage = UIImageView(image: Images.foodItemPlaceholder.image)
        view.addSubview(itemImage)
        itemImage.setRoundCorners(Layout.cornerRadius)
        itemImage.contentMode = .scaleAspectFit
        itemImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(counter.snp.trailing).offset(Layout.largeMargin)
            $0.size.equalTo(view.snp.height).inset(Layout.commonInset)
        }
        
        let itemNameLabel = UILabel.makeMediumText(item.name)
        itemNameLabel.font = FontFamily.semibold
        view.addSubview(itemNameLabel)
        itemNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemImage.snp.trailing).offset(Layout.largeMargin)
        }
        
        let itemPrice = UILabel.makeText(Formatter.Currency.toString(item.price))
        itemPrice.font = FontFamily.semibold
        itemPrice.textColor = Colors.blue.color
        view.addSubview(itemPrice)
        itemPrice.snp.makeConstraints {
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.equalTo(itemNameLabel)
        }
        
        let removeButton = UIButton()
        removeButton.setImage(Images.Icons.cross.image, for: .normal)
        removeButton.backgroundColor = Colors.lightRed.color
        removeButton.setRoundCorners(4)
        removeButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        removeButton.setActionHandler(controlEvents: .touchUpInside) { [weak self] _ in
            self?.cartSerivce.removeItem(item: item)
            self?.reloadCalculationsRows()
            self?.aloeStackView.removeRow(view, animated: true)
            if let self = self, self.cartSerivce.items.isEmpty {
                self.aloeStackView.showRow(self.emptyCartRow, animated: true)
            }
        }
        view.addSubview(removeButton)
        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemNameLabel.snp.trailing)
            $0.size.equalTo(18)
        }
        
        let optionsStackView = AloeStackView()
        optionsStackView.separatorHeight = 0
        optionsStackView.rowInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        optionsStackView.axis = .horizontal
        view.addSubview(optionsStackView)
        optionsStackView.snp.makeConstraints {
            $0.leading.equalTo(itemImage.snp.trailing).offset(Layout.largeMargin)
            $0.bottom.trailing.equalToSuperview().inset(Layout.commonInset)
        }
        
        let optionRows = item.options.map({ (option) -> UIView in
            let view = UIView()
            
            let label = UILabel.makeText(option.rawValue)
            label.font = FontFamily.Poppins.regular.font(size: 11)
            label.textColor = Colors.smoke.color
            view.addSubview(label)
            label.snp.makeConstraints {
                $0.leading.top.bottom.equalToSuperview()
            }
            
            let optionRemoveButton = UIButton.makeImageButton(image: Images.Icons.cross.image) { [weak self] _ in
                item.options.removeAll { (localOption) -> Bool in
                    option == localOption
                }
                self?.reloadScreen()
            }
            optionRemoveButton.tintColor = .red
            optionRemoveButton.imageView?.contentMode = .scaleAspectFit
            optionRemoveButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            view.addSubview(optionRemoveButton)
            optionRemoveButton.snp.makeConstraints {
                $0.top.bottom.trailing.equalToSuperview()
                $0.leading.equalTo(label.snp.trailing)
            }
            return view
        })
        optionsStackView.addRows(optionRows)
        return view
    }
    
    private func makeTitleValueRow(title: String, value: String, largeValueTitle: Bool = false) -> UIView {
        let view = UIView()
        
        let title = UILabel.makeText(title)
        view.addSubview(title)
        title.font = FontFamily.regular
        title.textColor = Colors.smoke.color
        title.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(Layout.commonInset)
        }
        
        
        let value = UILabel.makeText(value)
        view.addSubview(value)
        value.textAlignment = .right
        value.font = FontFamily.regular
        value.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(title.snp.trailing)
        }
        if largeValueTitle {
            value.font = FontFamily.Poppins.semiBold.font(size: 20)
        }
        
        return view
    }
    
    
}

//MARK: -  Private
private extension CartViewController {
    
}


