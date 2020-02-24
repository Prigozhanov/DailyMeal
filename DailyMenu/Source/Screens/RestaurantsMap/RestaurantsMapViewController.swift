//
//  RestaurantsMapViewController.swift
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import Networking

final class RestaurantsMapViewController: UIViewController {
    
    private var viewModel: RestaurantsMapViewModel
    
    private lazy var mapHeaderView: MapHeaderView = {
        let view = MapHeaderView(
            title: "Nearby restaurants",
            shouldShowBackButton: true,
            shouldShowNotificationsButton: true
        )
        view.backButton.setActionHandler(controlEvents: .touchUpInside) { [weak self] _ in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
        return view
    }()
    
    private var mapController = MapViewController(
        viewModel: MapViewModelImplementation(shouldShowPin: false, onRegionDidChange: nil)
    )
    
    private lazy var searchView: MapSearchView = {
        let view = MapSearchView(
            item: MapSearchView.Item(
                placeholder: "Type restaurant name",
                results: [],
                onSelectItem: { [weak self] (string, view) in
                    if let annotation = self?
                        .mapController
                        .restaurantAnnotations
                        .first(where: { $0.restaurant.chainLabel == string }) {
                        self?.mapController.selectAnnotation(annotation)
                    }
                },
                onLocationButtonTap: { [weak self] in
                    self?.mapController.moveCameraToUserLocation(fromDistance: 15000)
                },
                onFilterButtonTap: { [weak self] in
                    self?.showFilterConfigurationView()
                },
                shouldChangeCharacters: { [weak self] (string, view) in
                    guard let self = self else { return }
                    let result = self.viewModel.restaurants
                        .filter({ $0.chainLabel.containsCaseIgnoring(string) })
                        .map({ $0.chainLabel })
                    view?.updateResults(with: result, searchString: string)
                }
            )
        )
        return view
    }()
    
    private lazy var filterAppliedView = FilterAppliedView(
        item: FilterAppliedView.Item(
            onHideButtonTapAction: { [weak self] in
                self?.removeFilter()
        },
            onTapAction: { [weak self] in
                self?.showFilterConfigurationView()
        }))
    
    private lazy var filteredRestaurantsPreview = FilteredRestaurantsPreview(
        items: self.viewModel.filteredRestaurants.map { rest in
            FilteredRestaurantsPreviewCell.Item(
                title: rest.chainLabel,
                rating: Double(rest.rate) ?? 0,
                imageSrc: rest.src,
                categories: self.viewModel.categories[rest.id]?
                    .compactMap({ FoodCategory.fromProductCategory(category: $0) }) ?? [],
                minOrderPrice: String(rest.minAmountOrder)) { [weak self] in
                    let vc = RestaurantViewController(
                        viewModel: RestaurantViewModelImplementation(
                            restaurant: rest,
                            categories: []
                        )
                    )
                    self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    )
    
    init(viewModel: RestaurantsMapViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        viewModel.loadRestaurants()
        addChild(mapController)
        view.addSubview(mapController.mapView)
        mapController.mapView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        view.addSubview(mapHeaderView)
        mapHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        mapController.moveCameraToUserLocation(fromDistance: 15000)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapHeaderView.setupGradient()
    }
    
}

//MARK: -  RestaurantsMapView
extension RestaurantsMapViewController: RestaurantsMapView {
    
    func reloadScreen() {
        filteredRestaurantsPreview.removeFromSuperview()
        filterAppliedView.removeFromSuperview()
        
        mapController.removeRestaurants()
        mapController.removeRadiusCircle()
        
        if viewModel.isFilterApplied {
            searchView.isHidden = true
            filterAppliedView.isHidden = false
            filteredRestaurantsPreview.isHidden = false
            
            view.addSubviews([filteredRestaurantsPreview, filterAppliedView])
            filteredRestaurantsPreview.snp.makeConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Layout.commonInset)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(150)
            }
            
            filterAppliedView.snp.makeConstraints {
                $0.top.equalTo(mapHeaderView.snp.bottom)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Layout.commonInset)
                $0.height.equalTo(50)
            }
            
            filteredRestaurantsPreview.configure(items: viewModel.filteredRestaurants.map {
                makeRestaurantsPreviewItem(restaurant: $0)
            })
            
            mapController.addRestaurants(viewModel.filteredRestaurants)
            mapController.addRadiusCircle(radius: (viewModel.filterViewModel?.radius ?? 0) * 1000)
        } else {
            searchView.isHidden = false
            mapController.addRestaurants(viewModel.restaurants)
        }
    }
    
}

//MARK: -  Private
private extension RestaurantsMapViewController {
    
    func makeRestaurantsPreviewItem(restaurant: Restaurant) -> FilteredRestaurantsPreviewCell.Item {
        FilteredRestaurantsPreviewCell.Item(
            title: restaurant.chainLabel,
            rating: Double(restaurant.rate) ?? 0,
            imageSrc: restaurant.src,
            categories: viewModel.categories[restaurant.id]?
                .compactMap({ FoodCategory.fromProductCategory(category: $0) }) ?? [],
            minOrderPrice: Formatter.Currency.toString(restaurant.minAmountOrder)) { [weak self] in
                let vc = RestaurantViewController(
                    viewModel: RestaurantViewModelImplementation(
                        restaurant: restaurant,
                        categories: []
                    )
                )
                self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showFilterConfigurationView() {
        let filterViewController = RestaurantsFilterViewController(
            viewModel: self.viewModel.filterViewModel ?? RestaurantFilterViewModelImplementation(onRemoveFilter: { [weak self] in
                self?.removeFilter()
                }, onApplyFilter: { [weak self] filterViewModel in
                    self?.applyFilter(filterViewModel)
            })
        )
        searchView.isHidden = true
        filterAppliedView.isHidden = true
        filteredRestaurantsPreview.isHidden = true
        present(filterViewController, animated: true, completion: nil)
    }
    
    func applyFilter(_ filterViewModel: RestaurantFilterViewModel) {
        self.viewModel.filterViewModel = filterViewModel
        reloadScreen()
    }
    
    func removeFilter() {
        viewModel.filterViewModel = nil
        reloadScreen()
    }

}


