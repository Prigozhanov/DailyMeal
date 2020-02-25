//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class ProductViewController: UIViewController {
    
    private var viewModel: ProductViewModel
    
    private lazy var scrollDelegate: StretchScrollDelegate = StretchScrollDelegate(view: navigationBarBackground) { [weak self] shouldBeAppeared in
        self?.navigationBarControls.alpha = !shouldBeAppeared ? 0 : 1
        self?.navigationBarControls.isUserInteractionEnabled = shouldBeAppeared
        self?.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return navigationBarBackground.alpha < 0.3 ? .default : .lightContent
    }
    
    private lazy var stackView: AloeStackView = {
        let stack = AloeStackView()
        stack.separatorHeight = 0
        stack.separatorInset = .zero
        stack.rowInset = .zero
        stack.backgroundColor = .clear
        stack.contentInset = UIEdgeInsets(top: 130, left: 0, bottom: 0, right: 0)
        stack.contentOffset = CGPoint(x: 0, y: -90)
        stack.delegate = scrollDelegate
        stack.alwaysBounceVertical = true
        stack.contentInsetAdjustmentBehavior = .automatic
        return stack
    }()
    
    private var navigationBarBackground: UIImageView = {
        let image = UIImageView(image: Images.itemImagePlaceholder.image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var navigationBarControls = NavigationBarControls(title: viewModel.restaurant.chainLabel)
    
    private lazy var productHeader = ProductHeaderView(item: ProductHeaderView.Item(
        title: viewModel.product.label,
        price: Formatter.Currency.toString(viewModel.product.price),
        onChangeCount: { [weak self] value in
            self?.viewModel.count = value
            self?.updateTotalValue()
        }
    ))
    
    private lazy var sliderView = SliderView(title: "Spicy Level", sliderValues: ["Regular", "Spicy", "Naga"]) // TODO
    
    private var totalLabel: UILabel = {
        let label = UILabel.makeSmallText("Total")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var totalValueLabel: UILabel = {
        let label = UILabel.makeText()
        label.textColor = Colors.blue.color
        label.textAlignment = .center
        label.font = FontFamily.Poppins.medium.font(size: 36)
        label.text = Formatter.Currency.toString(viewModel.product.overallPrice * Double(viewModel.count))
        return label
    }()
    
    private lazy var addToCartButton = UIButton.makeActionButton("Add to Cart") { [weak self] view in
        guard let self = self else { return }
        let item = CartItem(id: self.viewModel.product.id, product: self.viewModel.product, count: self.viewModel.count)
        self.viewModel.cartService.addItem(item: item)
        view.tapAnimation()
        self.navigationController?.popViewController(animated: true)
    }
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Style.addBlackGradient(navigationBarBackground)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Style.addBlueGradient(addToCartButton)
    }
    
    private func setupScreen() {
        view.backgroundColor = Colors.commonBackground.color
        
        view.addSubview(navigationBarBackground)
        if let url = URL(string: viewModel.product.src.orEmpty) {
            navigationBarBackground.kf.setImage(with: url)
        }
        navigationBarBackground.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        view.addSubview(navigationBarControls)
        navigationBarControls.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(100)
        }
        
        setupStackView()
    }
    
    private func setupStackView() {
        stackView.addRow(productHeader)
        
        if let options = viewModel.originalProduct.options {
            stackView.addRows(
                options.map({ option in
                    OptionView(
                        item: OptionView.Item(
                            id: option.id,
                            title: option.optionTitle,
                            minChoices: option.minimum,
                            maxChoices: option.maximum,
                            free: option.free,
                            freeMaxChoices: option.freemax,
                            choices: option.choices.map({
                                ChoiceRow.Item(id: $0.id, optionId: option.id, title: $0.label, price: $0.price, isSelected: false ) { [weak self] choiceItem in
                                    if let choice = self?.viewModel.availableChoices.first(where: { $0.id == choiceItem.id }) {
                                        if choiceItem.isSelected {
                                            self?.viewModel.product.addChoiceForOption(choice, optionId: choiceItem.optionId)
                                        } else {
                                            self?.viewModel.product.removeChoiceForOption(choice, optionId: choiceItem.optionId)
                                        }
                                        self?.updateTotalValue()
                                    }
                                }
                            })
                        )
                    )
                })
            )
        }
        
        stackView.addRow(totalLabel)
        stackView.addRow(totalValueLabel)
        stackView.addRow(addToCartButton)
        addToCartButton.snp.makeConstraints { $0.height.equalTo(50) }
        
        stackView.setInset(forRow: totalLabel, inset: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        stackView.setInset(forRow: addToCartButton, inset: UIEdgeInsets(top: 30, left: 30, bottom: 50, right: 30))
    }
}

// MARK: - ProductView
extension ProductViewController: ProductView {
    func updateTotalValue() {
        totalValueLabel.text = Formatter.Currency.toString(viewModel.product.overallPrice * Double(viewModel.count))
    }
}

// MARK: - Private
private extension ProductViewController {
    
}
