// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let geodata = try? newJSONDecoder().decode(Geodata.self, from: jsonData)

import Foundation

// MARK: - Geodata
public struct Geodata: Codable {
    public let response: Response?
    
    public init(response: Response?) {
        self.response = response
    }
}

// MARK: - Response
public struct Response: Codable {
    public let geoObjectCollection: GeoObjectCollection?
    
    enum CodingKeys: String, CodingKey {
        case geoObjectCollection = "GeoObjectCollection"
    }
    
    public init(geoObjectCollection: GeoObjectCollection?) {
        self.geoObjectCollection = geoObjectCollection
    }
}

// MARK: - GeoObjectCollection
public struct GeoObjectCollection: Codable {
    public let metaDataProperty: GeoObjectCollectionMetaDataProperty?
    public let featureMember: [FeatureMember]?
    
    public init(metaDataProperty: GeoObjectCollectionMetaDataProperty?, featureMember: [FeatureMember]?) {
        self.metaDataProperty = metaDataProperty
        self.featureMember = featureMember
    }
}

// MARK: - FeatureMember
public struct FeatureMember: Codable {
    public let geoObject: GeoObject?
    
    enum CodingKeys: String, CodingKey {
        case geoObject = "GeoObject"
    }
    
    public init(geoObject: GeoObject?) {
        self.geoObject = geoObject
    }
}

// MARK: - GeoObject
public struct GeoObject: Codable {
    public let metaDataProperty: GeoObjectMetaDataProperty?
    public let name, geoObjectDescription: String?
    public let boundedBy: BoundedBy?
    public let point: Point?
    
    enum CodingKeys: String, CodingKey {
        case metaDataProperty, name
        case geoObjectDescription = "description"
        case boundedBy
        case point = "Point"
    }
    
    public init(metaDataProperty: GeoObjectMetaDataProperty?, name: String?, geoObjectDescription: String?, boundedBy: BoundedBy?, point: Point?) {
        self.metaDataProperty = metaDataProperty
        self.name = name
        self.geoObjectDescription = geoObjectDescription
        self.boundedBy = boundedBy
        self.point = point
    }
}

// MARK: - BoundedBy
public struct BoundedBy: Codable {
    public let envelope: Envelope?
    
    enum CodingKeys: String, CodingKey {
        case envelope = "Envelope"
    }
    
    public init(envelope: Envelope?) {
        self.envelope = envelope
    }
}

// MARK: - Envelope
public struct Envelope: Codable {
    public let lowerCorner, upperCorner: String?
    
    public init(lowerCorner: String?, upperCorner: String?) {
        self.lowerCorner = lowerCorner
        self.upperCorner = upperCorner
    }
}

// MARK: - GeoObjectMetaDataProperty
public struct GeoObjectMetaDataProperty: Codable {
    public let geocoderMetaData: GeocoderMetaData?
    
    enum CodingKeys: String, CodingKey {
        case geocoderMetaData = "GeocoderMetaData"
    }
    
    public init(geocoderMetaData: GeocoderMetaData?) {
        self.geocoderMetaData = geocoderMetaData
    }
}

// MARK: - GeocoderMetaData
public struct GeocoderMetaData: Codable {
    public let precision: Precision?
    public let text, kind: String?
    public let address: Address?
    public let addressDetails: AddressDetails?
    
    enum CodingKeys: String, CodingKey {
        case precision, text, kind
        case address = "Address"
        case addressDetails = "AddressDetails"
    }
    
    public init(precision: Precision?, text: String?, kind: String?, address: Address?, addressDetails: AddressDetails?) {
        self.precision = precision
        self.text = text
        self.kind = kind
        self.address = address
        self.addressDetails = addressDetails
    }
}

// MARK: - Address
public struct Address: Codable {
    public let countryCode: String?
    public let formatted, postalCode: String?
    public let components: [Component]?
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case formatted
        case postalCode = "postal_code"
        case components = "Components"
    }
    
    public init(countryCode: String?, formatted: String?, postalCode: String?, components: [Component]?) {
        self.countryCode = countryCode
        self.formatted = formatted
        self.postalCode = postalCode
        self.components = components
    }
}

// MARK: - Component
public struct Component: Codable {
    public let kind, name: String?
    
    public init(kind: String?, name: String?) {
        self.kind = kind
        self.name = name
    }
}

// MARK: - AddressDetails
public struct AddressDetails: Codable {
    public let country: Country?
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
    }
    
    public init(country: Country?) {
        self.country = country
    }
}

// MARK: - Country
public struct Country: Codable {
    public let addressLine: String?
    public let countryNameCode: String?
    public let countryName: String?
    public let administrativeArea: AdministrativeArea?
    
    enum CodingKeys: String, CodingKey {
        case addressLine = "AddressLine"
        case countryNameCode = "CountryNameCode"
        case countryName = "CountryName"
        case administrativeArea = "AdministrativeArea"
    }
    
    public init(addressLine: String?, countryNameCode: String?, countryName: String?, administrativeArea: AdministrativeArea?) {
        self.addressLine = addressLine
        self.countryNameCode = countryNameCode
        self.countryName = countryName
        self.administrativeArea = administrativeArea
    }
}

// MARK: - AdministrativeArea
public struct AdministrativeArea: Codable {
    public let administrativeAreaName: String?
    public let locality: Locality?
    public let subAdministrativeArea: SubAdministrativeArea?
    
    enum CodingKeys: String, CodingKey {
        case administrativeAreaName = "AdministrativeAreaName"
        case locality = "Locality"
        case subAdministrativeArea = "SubAdministrativeArea"
    }
    
    public init(administrativeAreaName: String?, locality: Locality?, subAdministrativeArea: SubAdministrativeArea?) {
        self.administrativeAreaName = administrativeAreaName
        self.locality = locality
        self.subAdministrativeArea = subAdministrativeArea
    }
}

// MARK: - Locality
public struct Locality: Codable {
    public let localityName: String?
    public let thoroughfare: Thoroughfare?
    public let dependentLocality: LocalityDependentLocality?
    
    enum CodingKeys: String, CodingKey {
        case localityName = "LocalityName"
        case thoroughfare = "Thoroughfare"
        case dependentLocality = "DependentLocality"
    }
    
    public init(localityName: String?, thoroughfare: Thoroughfare?, dependentLocality: LocalityDependentLocality?) {
        self.localityName = localityName
        self.thoroughfare = thoroughfare
        self.dependentLocality = dependentLocality
    }
}

// MARK: - LocalityDependentLocality
public struct LocalityDependentLocality: Codable {
    public let dependentLocalityName: String?
    public let dependentLocality: PurpleDependentLocality?
    
    enum CodingKeys: String, CodingKey {
        case dependentLocalityName = "DependentLocalityName"
        case dependentLocality = "DependentLocality"
    }
    
    public init(dependentLocalityName: String?, dependentLocality: PurpleDependentLocality?) {
        self.dependentLocalityName = dependentLocalityName
        self.dependentLocality = dependentLocality
    }
}

// MARK: - PurpleDependentLocality
public struct PurpleDependentLocality: Codable {
    public let dependentLocalityName: String?
    public let dependentLocality: FluffyDependentLocality?
    
    enum CodingKeys: String, CodingKey {
        case dependentLocalityName = "DependentLocalityName"
        case dependentLocality = "DependentLocality"
    }
    
    public init(dependentLocalityName: String?, dependentLocality: FluffyDependentLocality?) {
        self.dependentLocalityName = dependentLocalityName
        self.dependentLocality = dependentLocality
    }
}

// MARK: - FluffyDependentLocality
public struct FluffyDependentLocality: Codable {
    public let dependentLocalityName: String?
    
    enum CodingKeys: String, CodingKey {
        case dependentLocalityName = "DependentLocalityName"
    }
    
    public init(dependentLocalityName: String?) {
        self.dependentLocalityName = dependentLocalityName
    }
}

// MARK: - Thoroughfare
public struct Thoroughfare: Codable {
    public let thoroughfareName: String?
    public let premise: Premise?
    
    enum CodingKeys: String, CodingKey {
        case thoroughfareName = "ThoroughfareName"
        case premise = "Premise"
    }
    
    public init(thoroughfareName: String?, premise: Premise?) {
        self.thoroughfareName = thoroughfareName
        self.premise = premise
    }
}

// MARK: - Premise
public struct Premise: Codable {
    public let premiseNumber: String?
    public let postalCode: PostalCode?
    
    enum CodingKeys: String, CodingKey {
        case premiseNumber = "PremiseNumber"
        case postalCode = "PostalCode"
    }
    
    public init(premiseNumber: String?, postalCode: PostalCode?) {
        self.premiseNumber = premiseNumber
        self.postalCode = postalCode
    }
}

// MARK: - PostalCode
public struct PostalCode: Codable {
    public let postalCodeNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case postalCodeNumber = "PostalCodeNumber"
    }
    
    public init(postalCodeNumber: String?) {
        self.postalCodeNumber = postalCodeNumber
    }
}

// MARK: - SubAdministrativeArea
public struct SubAdministrativeArea: Codable {
    public let subAdministrativeAreaName: String?
    
    enum CodingKeys: String, CodingKey {
        case subAdministrativeAreaName = "SubAdministrativeAreaName"
    }
    
    public init(subAdministrativeAreaName: String?) {
        self.subAdministrativeAreaName = subAdministrativeAreaName
    }
}

public enum Precision: String, Codable {
    case exact, other, street
}

// MARK: - Point
public struct Point: Codable {
    public let pos: String?
    
    public init(pos: String?) {
        self.pos = pos
    }
}

// MARK: - GeoObjectCollectionMetaDataProperty
public struct GeoObjectCollectionMetaDataProperty: Codable {
    public let geocoderResponseMetaData: GeocoderResponseMetaData?
    
    enum CodingKeys: String, CodingKey {
        case geocoderResponseMetaData = "GeocoderResponseMetaData"
    }
    
    public init(geocoderResponseMetaData: GeocoderResponseMetaData?) {
        self.geocoderResponseMetaData = geocoderResponseMetaData
    }
}

// MARK: - GeocoderResponseMetaData
public struct GeocoderResponseMetaData: Codable {
    public let point: Point?
    public let request, results, found: String?
    
    enum CodingKeys: String, CodingKey {
        case point = "Point"
        case request, results, found
    }
    
    public init(point: Point?, request: String?, results: String?, found: String?) {
        self.point = point
        self.request = request
        self.results = results
        self.found = found
    }
}

///----------------------------------------///
///------- MENU BY GEODATA REQUEST --------///
///----------------------------------------///

// MARK: - MenuV2GeodataRequest
public struct MenuV2GeodataRequest: Codable {
    public let geodata: [MenuV2Geodata]?
    
    public init(geodata: [MenuV2Geodata]?) {
        self.geodata = geodata
    }
    
    func encoded() -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try! encoder.encode(self)
        let jsonOutput = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        return jsonOutput
    }
}

// MARK: - MenuV2Geodata
public struct MenuV2Geodata: Codable {
    public let data: GeoObject?
    public let lang: String?
    
    public init(data: GeoObject?, lang: String?) {
        self.data = data
        self.lang = lang
    }
}

// MARK: - MenuV2Data
public struct MenuV2Data: Codable {
    public let point: MenuV2Point?
    public let metaDataProperty: GeoObjectMetaDataProperty?
    
    enum CodingKeys: String, CodingKey {
        case point = "Point"
        case metaDataProperty
    }
    
    public init(point: MenuV2Point?, metaDataProperty: GeoObjectMetaDataProperty?) {
        self.point = point
        self.metaDataProperty = metaDataProperty
    }
}

// MARK: - MenuV2Point
public struct MenuV2Point: Codable {
    public let pos: String?
    
    public init(pos: String?) {
        self.pos = pos
    }
}
