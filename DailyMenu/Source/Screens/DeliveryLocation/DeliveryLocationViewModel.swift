//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking
import Services

//MARK: - View
protocol DeliveryLocationView: class {
    
}

//MARK: - ViewModel
protocol DeliveryLocationViewModel {
    
    var view: DeliveryLocationView? { get set }
    
    func requestGeodcode(lat: Double, lon: Double)
    
    func getAddressesList(string: String, completion: @escaping ([String]) -> Void)
    
    func requestGeodataExist(address: String, position: String, language: String, onSuccess: @escaping VoidClosure)
}

//MARK: - Implementation
final class DeliveryLocationViewModelImplementation: DeliveryLocationViewModel {
    
    weak var view: DeliveryLocationView?
    
    private let context: AppContext
    private let locationService: LocationService
    
    init() {
        context = AppDelegate.shared.context
        locationService = context.locationService
    }
    
    func requestGeodcode(lat: Double, lon: Double) {
        let req = context.networkService.requestFactory.getGeocode(lat: lat, lon: lon)
        
        context.networkService.send(request: req) { [weak self] result in
            switch result {
            case let .success(geodata):
                guard let address = geodata?
                    .response?
                    .geoObjectCollection?
                    .featureMember?
                    .first?
                    .geoObject?
                    .metaDataProperty?
                    .geocoderMetaData?
                    .text,
                    let position = geodata?
                        .response?
                        .geoObjectCollection?
                        .metaDataProperty?
                        .geocoderResponseMetaData?
                        .point?
                        .pos else {
                        return
                }
                
                self?.requestGeodataExist(address: address, position: position, language: "en_US", onSuccess: {})
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // for search
    func getAddressesList(string: String, completion: @escaping ([String]) -> Void) {
        let req = context.networkService.requestFactory.getGeodataByString(string: string)
        
        context.networkService.send(request: req) { result in
            switch result {
            case let .success(geodata):
                if let featureMembers = geodata?.response?.geoObjectCollection?.featureMember {
                    let addresses = featureMembers
                        .filter({ $0.geoObject?.metaDataProperty?.geocoderMetaData?.text != nil })
                        .map { $0.geoObject?.metaDataProperty?.geocoderMetaData?.text ?? "" }
                    completion(addresses)
                }
            case .failure:
                completion([])
            }
        }
    }
    
    func requestGeodataExist(address: String, position: String, language: String, onSuccess: @escaping VoidClosure) {
        
        let geodataRequestObject = MenuV2GeodataRequest(geodata: [
            MenuV2Geodata(
                data: MenuV2Data(point: MenuV2Point(pos: position),
                                 metaDataProperty: GeoObjectMetaDataProperty(
                                    geocoderMetaData: GeocoderMetaData(
                                        precision: nil,
                                        text: address,
                                        kind: nil,
                                        address: nil,
                                        addressDetails: nil)
                    )
                ),
                lang: "en_US")
        ])
        
        let networkRequest = context.networkService.requestFactory.geodataIsExists(
            geodataRequest: geodataRequestObject
        )
        
        context.networkService.send(request: networkRequest) { result in
            switch result {
            case let .success(response):
                print(response)
            case let .failure(error):
                print(error)
            }
        }
    }
    
}


