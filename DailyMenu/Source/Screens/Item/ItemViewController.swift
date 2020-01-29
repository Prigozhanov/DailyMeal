//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class ItemViewController: UIViewController {
    
    private var viewModel: ItemViewModel
    
    private var stackViewInsets = UIEdgeInsets(top: 130, left: 0, bottom: 0, right: 0)
    private lazy var scrollDelegate: StretchScrollDelegate = StretchScrollDelegate(view: navigationBarBackground) { [weak self] shouldBeAppeared in
        self?.navigationBarControls.isHidden = !shouldBeAppeared
        self?.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return navigationBarControls.isHidden ? .default : .lightContent
    }
    
    private lazy var stackView: AloeStackView = {
        let stack = AloeStackView()
        stack.separatorHeight = 0
        stack.separatorInset = .zero
        stack.rowInset = .zero
        stack.backgroundColor = .clear
        stack.contentInset = stackViewInsets
        stack.contentOffset = CGPoint(x: 0, y: -90)
        stack.delegate = scrollDelegate
        return stack
    }()
    
    private var navigationBarBackground: UIImageView = {
        let image = UIImageView(image: Images.itemImagePlaceholder.image)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private var navigationBarControls = NavigationBarControls()
    
    private lazy var itemHeader = ItemHeaderView(title: viewModel.item.name, price: Formatter.Currency.toString(viewModel.item.price), itemViewModel: self.viewModel)
    
    private lazy var sliderView = SliderView(title: "Spicy Level", sliderValues: ["Regular", "Spicy", "Naga"]) // TODO
    
    private lazy var addOnsView = AddOnsView(itemViewModel: viewModel)
    
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
        label.text = Formatter.Currency.toString(viewModel.item.overallPrice * Double(viewModel.item.count))
        return label
    }()
    
    private lazy var addToCartButton = UIButton.makeActionButton("Add to Cart") { [weak self] view in
        view.tapAnimation()
        guard let self = self, let item = self.viewModel.item.copy() as? CartItem else { return }
        self.viewModel.cartService.addItem(item: item)
    }
    
    init(viewModel: ItemViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        view.addSubview(navigationBarBackground)
        view.addSubview(stackView)
        view.addSubview(navigationBarControls)
        navigationBarControls.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(100)
        }
        
        stackView.addRow(itemHeader)
        stackView.addRow(sliderView)
        stackView.addRow(addOnsView)
        stackView.addRow(totalLabel)
        stackView.addRow(totalValueLabel)
        stackView.addRow(addToCartButton)
        
        stackView.setInset(forRow: totalLabel, inset: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        stackView.setInset(forRow: addToCartButton, inset: UIEdgeInsets(top: 30, left: 30, bottom: 50, right: 30))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Style.addBlackGradient(navigationBarBackground)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationBarBackground.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
//            $0.height.equalTo(150 + (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0))
        }
    
        stackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }
        
        Style.addBlueGradient(addToCartButton)
    }
}

//MARK: -  ItemView
extension ItemViewController: ItemView {
    func reloadTotalLabelView() {
        totalValueLabel.text = Formatter.Currency.toString(viewModel.item.overallPrice * Double(viewModel.item.count))
    }
}

//MARK: -  Private
private extension ItemViewController {
    
}



