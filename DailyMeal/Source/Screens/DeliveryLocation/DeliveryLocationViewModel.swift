//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation
import Networking
import Services

// MARK: - View
protocol DeliveryLocationView: class {
    
}

// MARK: - ViewModel
protocol DeliveryLocationViewModel {
    
    var view: DeliveryLocationView? { get set }
    
    func requestGeodcode(string: String, onSuccess: @escaping (String) -> Void)
    
    func getAddressesList(string: String, completion: @escaping ([String]) -> Void)
    
	var userAddressMeta: UserAddressMeta? { get set }
	
    func saveAddressInfo()
}

// MARK: - Implementation
final class DeliveryLocationViewModelImplementation: DeliveryLocationViewModel {
    
    weak var view: DeliveryLocationView?
    
    private let context: AppContext
    private let locationService: LocationService
    private let userDefaultsService: UserDefaultsService
    
	var userAddressMeta: UserAddressMeta?
    
    private var lastGeoDataExistRequestUUID: String = ""
    
    init() {
        context = AppDelegate.shared.context
        locationService = context.locationService
        userDefaultsService = context.userDefaultsService
    }
    
    // Search addresses
    func getAddressesList(string: String, completion: @escaping ([String]) -> Void) {
        let req = context.networkService.requestFactory.getGeodataByString(string: "Minsk, Belarus \(string)")
        
        context.networkService.send(request: req) { [weak self] result, _ in
            guard let self = self else { return }
            switch result {
            case let .success(geodata):
                if let featureMembers = geodata?.response?.geoObjectCollection?.featureMember {
                    if let pos = featureMembers.first?.geoObject?.point?.pos {
                        let req = self.context.networkService.requestFactory.getGeodataByString(string: pos)
                        
                        self.context.networkService.send(request: req) { (result, _) in
                            switch result {
                            case let .success(geodata):
                                let addresses = geodata?.response?.geoObjectCollection?.featureMember?.compactMap({ $0.geoObject?.metaDataProperty?.geocoderMetaData?.text })
                                completion(addresses ?? [])
                            case .failure:
                                completion([])
                            }
                        }
                    }
                    
                }
            case .failure:
                completion([])
            }
        }
    }
    
    /**
     Before confirming address, we must be sure that address for found geodata is exists
     in Menu.by database, so before confirming address we should call requestGeodataExist method
     to check if address exists and valid
     
     For lat lon geocode request use format %lon,lat%
     */
    func requestGeodcode(string: String, onSuccess: @escaping (String) -> Void) {
        let req = context.networkService.requestFactory.getGeocode(string: string)
        lastGeoDataExistRequestUUID = ""
        context.networkService.send(request: req) { [weak self] result, uuid in
            self?.lastGeoDataExistRequestUUID = uuid
            switch result {
            case let .success(geodata):
                guard let featureMember = geodata?
                    .response?
                    .geoObjectCollection?
                    .featureMember?
                    .first,
                    let geoObject = featureMember.geoObject else {
                        return
                }
                if self?.lastGeoDataExistRequestUUID == uuid {
                    self?.requestGeodataExist(geoObject: geoObject, onSuccess: onSuccess, uuid: uuid)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func requestGeodataExist(geoObject: GeoObject, onSuccess: @escaping (String) -> Void, uuid: String) {
        
        let geodataRequestObject = MenuV2GeodataRequest(geodata: [
            MenuV2Geodata(
                data: geoObject,
                lang: "en_US")
        ])
        
        let networkRequest = context.networkService.requestFactory.geodataIsExists(
            geodataRequest: geodataRequestObject
        )
        
        context.networkService.send(request: networkRequest) { [weak self] result, _ in
            switch result {
            case let .success(response):
                if let address = response.isAddressExists?.lng7 {
                    if self?.lastGeoDataExistRequestUUID == uuid {
                        onSuccess(address)
                    }
                }
                if let addressExists = response.isAddressExists {
                    self?.userAddressMeta = UserAddressMeta(
                        addressName: addressExists.lng7,
                        streetName: addressExists.streetLabel7,
                        areaId: addressExists.areaID,
                        addressesId: addressExists.id,
                        regionId: addressExists.regionID,
						streetId: addressExists.streetID,
						addressLat: Double(addressExists.lat ?? ""),
						addressLon: Double(addressExists.long ?? ""),
						apartments: "",
						floor: ""
                    )
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func saveAddressInfo() {
        userDefaultsService.updateUserAddressMeta(userAddressMeta)
    }
    
}
