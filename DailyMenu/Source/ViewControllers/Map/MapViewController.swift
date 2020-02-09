//
//  Created by Vladimir on 2/8/20.
//  Copyright © 2020 epam. All rights reserved.
//

import MapKit

class MapViewController: UIViewController {
    
    private let viewModel: MapViewModel
    
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .mutedStandard
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
        
        self.mapView.addGestureRecognizer(BlockTap(action: { [weak self] _ in
            self?.view.becomeFirstResponder()
        }))
    }
    
    func moveCameraToUserLocation() {
        if let userCoordinates = viewModel.getUserLocation() {
            mapView.setCamera(MKMapCamera(lookingAtCenter: userCoordinates, fromDistance: 1500, pitch: 0, heading: 0), animated: true)
        }
    }
    
    func moveToCoordinates(lat: Double, lon: Double) {
        mapView.setCamera(MKMapCamera(lookingAtCenter: CLLocationCoordinate2D(latitude: lat, longitude: lon), fromDistance: 1500, pitch: 0, heading: 0), animated: true)
    }
    
    func getCameraLocation() -> CLLocationCoordinate2D {
        return mapView.camera.centerCoordinate
    }
    
}
