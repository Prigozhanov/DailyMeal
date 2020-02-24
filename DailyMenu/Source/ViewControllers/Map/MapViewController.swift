//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit
import Networking

class MapViewController: UIViewController {
    
    let viewModel: MapViewModel
    
    private var userIteractionStarted: Bool = false
    
    private var standardCameraDistance: Double = 1500
    private lazy var currentCameraDistance = standardCameraDistance
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .mutedStandard
        view.showsPointsOfInterest = true
        view.showsUserLocation = true
        view.showsCompass = false
        view.delegate = self
        view.register(RestaurantAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        return view
    }()
    
    private let pinImageView = UIImageView(image: Images.Icons.mapPinBlue.image)
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    var restaurantAnnotations: [RestaurantAnnotation] {
        return mapView.annotations.compactMap { $0 as? RestaurantAnnotation }
    }
    
    var radiusOverlay: MKOverlay? {
        return mapView.overlays.first(where: { $0 is MKCircle })
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        if viewModel.shouldShowPin {
            let pinShadow = UIImageView(image: Images.Icons.pinShadow.image)
            pinShadow.alpha = 0.5
            view.addSubviews([pinShadow, pinImageView])
            pinImageView.contentMode = .scaleAspectFit
            pinImageView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.size.equalTo(44)
            }
            pinShadow.snp.makeConstraints {
                $0.top.equalTo(pinImageView.snp.bottom).inset(5)
                $0.width.equalTo(pinImageView)
                $0.height.equalTo(10)
                $0.center.equalToSuperview()
            }
        }
    }
    
    func moveCameraToUserLocation(fromDistance: Double? = nil) {
        currentCameraDistance = fromDistance ?? standardCameraDistance
        if let userCoordinates = viewModel.getUserLocation() {
            mapView.setCamera(
                MKMapCamera(
                    lookingAtCenter: userCoordinates,
                    fromDistance: fromDistance ?? standardCameraDistance,
                    pitch: 0,
                    heading: 0
                ), animated: true
            )
        }
    }
    
    func moveToCoordinates(lat: Double, lon: Double) {
        mapView.setCamera(
            MKMapCamera(
                lookingAtCenter: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                fromDistance: currentCameraDistance,
                pitch: 0, heading: 0
            ), animated: true
        )
    }
    
    func getCameraLocation() -> CLLocationCoordinate2D {
        return mapView.camera.centerCoordinate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.userIteractionStarted = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.pinImageView.transform = CGAffineTransform(translationX: 0, y: -10)
        }
    }
    
}

extension MapViewController {
    
    func addRestaurants(_ restaurants: [Restaurant]) {
        mapView.addAnnotations(restaurants.map {
            RestaurantAnnotation(
                restaurant: $0,
                coordinate: CLLocationCoordinate2D(
                    latitude: $0.latitude,
                    longitude: $0.longitude
            )) { [weak self] rest in
                let vm = RestaurantViewModelImplementation(restaurant: rest, categories: [])
                let vc = RestaurantViewController(viewModel: vm)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        })
    }
    
    func removeRestaurants() {
        mapView.removeAnnotations(restaurantAnnotations)
    }
    
    func selectAnnotation(_ annotation: RestaurantAnnotation) {
        moveToCoordinates(lat: annotation.coordinate.latitude, lon: annotation.coordinate.longitude)
        mapView.selectAnnotation(annotation, animated: true)
    }
    
}

extension MapViewController {
    
    func addRadiusCircle(radius: Int) {
        let radius = CLLocationDistance(radius)
        if let center = viewModel.getUserLocation() {
            let circle = MKCircle(center: center,
                                  radius: radius)
            
            mapView.addOverlay(circle)
        }
    }
    
    func removeRadiusCircle() {
        if let radiusOverlay = radiusOverlay {
            mapView.removeOverlay(radiusOverlay)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKUserLocation {
           return UserLocationAnnotationView(annotation: annotation, reuseIdentifier: "User")
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if userIteractionStarted {
            viewModel.onRegionDidChange?(mapView.camera.centerCoordinate)
        }
        userIteractionStarted = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.pinImageView.transform = .identity
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.fillColor = Colors.blue.color
            circleRenderer.alpha = 0.1
            
            return circleRenderer
        }
        return MKOverlayRenderer()
    }
    
}
