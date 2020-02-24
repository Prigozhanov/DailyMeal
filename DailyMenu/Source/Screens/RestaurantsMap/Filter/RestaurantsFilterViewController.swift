//
//  Created by Vladimir on 2/22/20.
//  Copyright © 2020 epam. All rights reserved.
//

import AloeStackView
import SnapKit

class RestaurantsFilterViewController: UIViewController {

    var viewModel: RestaurantFilterViewModel
    
    private var stackView: AloeStackView = {
        let stack = AloeStackView()
        stack.separatorHeight = 0
        stack.rowInset = .zero
        stack.backgroundColor = .clear
        stack.setBorder(width: 1, color: Colors.lightGray.color)
        stack.setRoundCorners(Layout.cornerRadius)
        return stack
    }()
    
    private lazy var restaurantsFilterHeader = RestaurantsFilterHeader(
        item: RestaurantsFilterHeader.Item(onHideControlsAction: { [weak self] in
            self?.dismiss(animated: true, completion: { [weak self] in
                self?.viewModel.onRemoveFilter()
            })
        })
    )
    
    private lazy var restaurantsFilterControls = RestaurantsFilterControls(
        item: RestaurantsFilterControls.Item(
            radiusValue: self.viewModel.radius,
            radiusMaximumValue: 50,
            priceRangeValues: self.viewModel.priceRange,
            priceRangeMaximumValue: 100,
            ratingRangeValues: self.viewModel.ratingRagne,
            raingRangeMaximumValue: 5,
            selectedCategories: self.viewModel.filterCategories,
            onRadiusValueChanged: { [weak self] value in
                self?.viewModel.radius = value
            },
            onPriceRangeValueChanged: { [weak self] (lowerValue, upperValue) in
                self?.viewModel.priceRange = (lowerValue, upperValue)
            },
            onFoodTypeCategoriesChanged: { [weak self] selectedCategories in
                self?.viewModel.filterCategories = selectedCategories
            },
            onRatingRangeValueChanged: { [weak self] lowerValue, upperValue in
                self?.viewModel.ratingRagne = (lowerValue, upperValue)
            }
        )
    )
    
    private lazy var filterSearchView = FilterSearchView(
        item: FilterSearchView.Item(
            placeholder: "Type restaurant name",
            onSearchAction: { [weak self] searchString in
                self?.viewModel.restaurantName = searchString
                self?.dismiss(animated: true) { [weak self] in
                    guard let self = self else { return }
                    self.viewModel.onApplyFilter(self.viewModel)
                }
        }))
    
    init(viewModel: RestaurantFilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.black.color.withAlphaComponent(0.2)
        
        view.addSubview(filterSearchView)
        filterSearchView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.height.equalTo(65)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.bottom.equalTo(filterSearchView.snp.top).offset(-40)
            $0.height.equalTo(400)
        }
        
        restaurantsFilterHeader.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        restaurantsFilterControls.snp.makeConstraints {
            $0.height.equalTo(350)
        }
        
        stackView.addRows([restaurantsFilterHeader, restaurantsFilterControls])

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filterSearchView.setupGradient()
    }
    
}
