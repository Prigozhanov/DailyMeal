//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit

class MapViewController: UIViewController {
    
    let viewModel: MapViewModel
    
    private var userIteractionStarted: Bool = false
    
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
    
    func moveCameraToUserLocation() {
        if let userCoordinates = viewModel.getUserLocation() {
            mapView.setCamera(
                MKMapCamera(
                    lookingAtCenter: userCoordinates,
                    fromDistance: 1500,
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
                fromDistance: 1500,
                pitch: 0, heading: 0
            ), animated: true
        )
    }
    
    func getCameraLocation() -> CLLocationCoordinate2D {
        return mapView.camera.centerCoordinate
    }
    
    func addAnnotation(_ annotation: RestaurantAnnotation) {
        mapView.addAnnotation(annotation)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.userIteractionStarted = true
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.pinImageView.transform = CGAffineTransform(translationX: 0, y: -10)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if userIteractionStarted {
            viewModel.onRegionDidChange?(mapView.camera.centerCoordinate)
        }
        userIteractionStarted = false
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.pinImageView.transform = .identity
        }
    }
    
}
