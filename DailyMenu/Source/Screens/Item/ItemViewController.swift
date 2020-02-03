//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class ItemViewController: UIViewController {
    
    private var viewModel: ItemViewModel
    
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
    
    private lazy var itemHeader = ItemHeaderView(item: ItemHeaderView.Item(
        title: viewModel.item.label,
        price: Formatter.Currency.toString(viewModel.item.price),
        onChangeCount: { [weak self] value in
            self?.viewModel.count = value
            self?.updateTotalValue()
        }
    ))
    
    private lazy var sliderView = SliderView(title: "Spicy Level", sliderValues: ["Regular", "Spicy", "Naga"]) // TODO
    
    private lazy var optionsStackView = OptionsStackView(item: OptionsStackView.Item(options: self.viewModel.item.options ?? [], onSelectOption: { option in
        //TODO
    }))
    
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
        label.text = Formatter.Currency.toString((Double(viewModel.item.price) ?? 0.0) * Double(viewModel.count)) //FIXME: price calculation
        return label
    }()
    
    private lazy var addToCartButton = UIButton.makeActionButton("Add to Cart") { [weak self] view in
        guard let self = self, let item = CartItem.fromProduct(self.viewModel.item, count: self.viewModel.count) else { return }
        self.viewModel.cartService.addItem(item: item)
        view.tapAnimation { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    init(viewModel: ItemViewModel) {
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
        if let url = URL(string: viewModel.item.src) {
            navigationBarBackground.sd_setImage(with: url)
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
        stackView.addRow(itemHeader)
        stackView.addRow(sliderView)
        stackView.addRow(optionsStackView)
        stackView.addRow(totalLabel)
        stackView.addRow(totalValueLabel)
        stackView.addRow(addToCartButton)
        addToCartButton.snp.makeConstraints { $0.height.equalTo(50) }
        
        stackView.setInset(forRow: totalLabel, inset: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        stackView.setInset(forRow: addToCartButton, inset: UIEdgeInsets(top: 30, left: 30, bottom: 50, right: 30))
    }
}

//MARK: -  ItemView
extension ItemViewController: ItemView {
    func updateTotalValue() {
        totalValueLabel.text = Formatter.Currency.toString((Double(viewModel.item.price) ?? 0) * Double(viewModel.count)) //FIXME: price calculation
    }
}

//MARK: -  Private
private extension ItemViewController {
    
}



