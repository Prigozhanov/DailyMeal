//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit

class MapViewController: UIViewController {
    
    let viewModel: MapViewModel
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .mutedStandard
        view.showsPointsOfInterest = true
        view.showsUserLocation = true
        view.showsCompass = false
        view.delegate = self
        return view
    }()
    
    private var pinImageView = UIImageView(image: Images.Icons.mapPin.image)
    
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
            view.addSubview(pinImageView)
            pinImageView.snp.makeConstraints {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.pinImageView.transform = CGAffineTransform(translationX: 0, y: -10)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        viewModel.onRegionDidChange?(mapView.camera.centerCoordinate)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.pinImageView.transform = .identity
        }
    }
    
}
