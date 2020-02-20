//
//  RestaurantsMapViewController.swift
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import MapKit

final class RestaurantsMapViewController: UIViewController {
    
    private var viewModel: RestaurantsMapViewModel
    
    private var mapController = MapViewController(viewModel: MapViewModelImplementation(shouldShowPin: false, onRegionDidChange: nil))
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapController.moveCameraToUserLocation()
    }
    
}

//MARK: -  RestaurantsMapView
extension RestaurantsMapViewController: RestaurantsMapView {
    func addAnnotations() {
        viewModel.restaurants.forEach { [weak self] rest in
            let annotation = RestaurantAnnotation(
            restaurant: rest,
            coordinate: CLLocationCoordinate2D(latitude: rest.latitude, longitude: rest.longitude)) { [weak self] rest in
                let vm = RestaurantViewModelImplementation(restaurant: rest, categories: [])
                let vc = RestaurantViewController(viewModel: vm)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            self?.mapController.addAnnotation(annotation)
        }
    }
}

//MARK: -  Private
private extension RestaurantsMapViewController {
    
}


