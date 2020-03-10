//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import AloeStackView

final class OrderStatusViewController: UIViewController {
    
    private var viewModel: OrderStatusViewModel
    
    private var stackView: AloeStackView = {
       let stack = AloeStackView()
        stack.rowInset = UIEdgeInsets(top: 20, left: 30, bottom: 20, right: 30)
        stack.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        stack.hidesSeparatorsByDefault = true
		stack.backgroundColor = .clear
        return stack
    }()
    
	private lazy var orderIdView = OrderIdView(id: viewModel.orderId ?? "")
	
	private let emptyStateLabel = UILabel.makeSmallText(Localizable.OrderStatus.noOrdersFound)
    
    init(viewModel: OrderStatusViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        Style.addBlueCorner(self)
        
        setupScreen()
		if let orderId = viewModel.orderId, !orderId.isEmpty {
        	setupStackView()
		} else {
			setupEmptyView()
		}
    }
    
    private func setupScreen() {
		let placeholderImageView = UIImageView(
			image: viewModel.isDelivered ? Images.Placeholders.orderDelivered.image : Images.Placeholders.orderPlaced.image
		)
		
        placeholderImageView.contentMode = .scaleAspectFit
        view.addSubview(placeholderImageView)
        placeholderImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.size.equalTo(150)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(placeholderImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
		Style.addTitle(title: Localizable.OrderStatus.orderStatus, self)
        Style.addBackButton(self) { [weak self] _ in
			if let navigationController = self?.navigationController {
            	navigationController.dismiss(animated: true, completion: nil)
			} else {
				self?.dismiss(animated: true, completion: nil)
			}
        }
    }
    
    private func setupStackView() {
		let orderConfirmedRow = OrderStateRow(title: Localizable.OrderStatus.orderConfirmed, time: viewModel.orderDate.toString(formatter: Date.timeFormatter), checked: true)
		let deliveredToYouRow = OrderStateRow(
			title: Localizable.OrderStatus.deliveredToYou,
			time: viewModel.deliveredToYouStatus.time,
			checked: viewModel.deliveredToYouStatus.done
		)
		
        stackView.addRow(orderIdView)
        stackView.addRow(orderConfirmedRow)
        stackView.addRow(deliveredToYouRow)
        
        stackView.showSeparator(forRow: orderIdView)
        stackView.showSeparator(forRow: orderConfirmedRow)
        stackView.showSeparator(forRow: deliveredToYouRow)
    }
	
	private func setupEmptyView() {
		view.addSubview(emptyStateLabel)
		emptyStateLabel.snp.makeConstraints { $0.center.equalToSuperview() }
	}
    
}

// MARK: - OrderStatusView
extension OrderStatusViewController: OrderStatusView {
    
}

// MARK: - Private
private extension OrderStatusViewController {
    
}
