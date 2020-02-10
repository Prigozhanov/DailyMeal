//
//  Created by Vladimir on 2/10/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public struct UserAddressMeta {
        
    public var addressName: String?
    public var streetName: String?
    public var areaId: Int?
    public var addressesId: Int?
    public var regionId: Int?
    public var streetId: Int?
    
    public init(addressName: String?, streetName: String?, areaId: Int?, addressesId: Int?, regionId: Int?, streetId: Int?) {
        self.addressName = addressName
        self.streetName = streetName
        self.areaId = areaId
        self.addressesId = addressesId
        self.regionId = regionId
        self.streetId = streetId
    }
    
}
