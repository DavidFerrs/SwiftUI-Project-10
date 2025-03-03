//
//  Order.swift
//  CupcakeCorner
//
//  Created by David Ferreira on 03/03/25.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnable = "specialRequestEnable"
        case _addSprinkles = "addSprinkles"
        case _extraFrosting = "extraFrosting"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnable = false {
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = true
    var addSprinkles = true
    
    var address = Address() {
        didSet {
            if let encoded = try? JSONEncoder().encode(address) {
                UserDefaults.standard.set(encoded, forKey: "Address")
            }
        }
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
}

@Observable
class Address: Codable  {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
        case _streetName = "streetName"
        case _city = "city"
        case _zip = "zip"
    }
    
    var name = ""
    var streetName = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetName.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    init() {
        if let savedAddress = UserDefaults.standard.data(forKey: "Address") {
            if let decoded = try? JSONDecoder().decode(Address.self, from: savedAddress) {
                name.self = decoded.name
                streetName.self = decoded.streetName
                city.self = decoded.city
                zip.self = decoded.zip
            }
        }
    }
}
