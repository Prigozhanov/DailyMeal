//
//  RestaurantsMapViewController.swift
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import MapKit

final class RestaurantsMapViewController: UIViewController {
    
    private var viewModel: RestaurantsMapViewModel
    
    private var mapController = MapViewController(viewModel: MapViewModelImplementation(shouldShowPin: false, onRegionDidChange: nil))
    
    private lazy var searchView: MapSearchView = {
        let view = MapSearchView(
            item: MapSearchView.Item(
                placeholder: "Type restaurant name",
                results: [],
                onSelectItem: { [weak self] (string, view) in
                    if let annotation = self?.mapController.restaurantAnnotations.first(where: { $0.restaurant.chainLabel == string }) {
                        self?.mapController.selectAnnotation(annotation)
                    }
                },
                onLocationButtonTap: { [weak self] in
                    self?.mapController.moveCameraToUserLocation(fromDistance: 15000)
                },
                onFilterButtonTap: { [weak self] in
                    self?.showFilter()
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
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        
        mapController.moveCameraToUserLocation(fromDistance: 15000)
    }
    
    private func showFilter() {
        let filterViewController = RestaurantsFilterViewController(
            viewModel: self.viewModel.filterViewModel ?? RestaurantFilterViewModelImplementation(onRemoveFilter: { [weak self] in
                self?.viewModel.filterViewModel = nil
                self?.removeFilter()
            }, onApplyFilter: { [weak self] filterViewModel in
                self?.viewModel.filterViewModel = filterViewModel
                self?.applyFilter()
            })
        )
        self.present(filterViewController, animated: true, completion: nil)
    }
    
    private func applyFilter() {
        mapController.removaAnnotations()
        mapController.addAnnotations(viewModel.filteredRestaurants.map { [weak self] rest in
            RestaurantAnnotation(
                restaurant: rest,
                coordinate: CLLocationCoordinate2D(latitude: rest.latitude, longitude: rest.longitude)) { [weak self] rest in
                    let vm = RestaurantViewModelImplementation(restaurant: rest, categories: [])
                    let vc = RestaurantViewController(viewModel: vm)
                    self?.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    private func removeFilter() {
        mapController.removaAnnotations()
        displayAvailableRestaurants()
    }
    
}

//MARK: -  RestaurantsMapView
extension RestaurantsMapViewController: RestaurantsMapView {
    func displayAvailableRestaurants() {
        mapController.removaAnnotations()
        mapController.addAnnotations(viewModel.restaurants.map { [weak self] rest in
            RestaurantAnnotation(
                restaurant: rest,
                coordinate: CLLocationCoordinate2D(latitude: rest.latitude, longitude: rest.longitude)) { [weak self] rest in
                    let vm = RestaurantViewModelImplementation(restaurant: rest, categories: [])
                    let vc = RestaurantViewController(viewModel: vm)
                    self?.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
}

//MARK: -  Private
private extension RestaurantsMapViewController {
    
}


