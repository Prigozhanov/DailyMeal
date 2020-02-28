//
//  AddCreditCardViewController.swift
//

import UIKit
import Extensions
import SnapKit
import RxSwift

final class AddCreditCardViewController: UIViewController, KeyboardObservable {
	
    private var viewModel: AddCreditCardViewModel
	
	var bag = DisposeBag()
	
	var observableConstraints: [ObservableConstraint] = []
	
    private lazy var cardInfoView = CardInfoView { [weak self] (details) in
        guard let self = self else { return }
        self.viewModel.saveCreditCardDetails(
            number: details.number,
            month: details.month,
            year: details.year,
            cvv: details.cvv
        )
        if self.viewModel.isValid {
            self.navigationController?.popViewController(animated: true)
        } else {
            
        }
    }
	
    init(viewModel: AddCreditCardViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        Style.addBlueCorner(self)
        
        let placeholderImage = UIImageView(image: Images.Placeholders.creditCard.image)
        placeholderImage.contentMode = .scaleAspectFit
        view.addSubview(placeholderImage)
        placeholderImage.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(cardInfoView)
        cardInfoView.snp.makeConstraints {
            $0.top.equalTo(placeholderImage.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
			observableConstraints.append(
          	  ObservableConstraint(
					constraint: $0.bottom.equalTo(view.safeAreaLayoutGuide).constraint,
					inset: 0)
			)
        }
        
        Style.addTitle(title: "Add Credit Card", self)
        Style.addBackButton(self) { [weak self] _ in
            self?.dismissController()
        }
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		startObserveKeyboard()
	}
    
}

// MARK: - AddCreditCardView
extension AddCreditCardViewController: AddCreditCardView {
    func dismissController() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Private
private extension AddCreditCardViewController {
    
}
