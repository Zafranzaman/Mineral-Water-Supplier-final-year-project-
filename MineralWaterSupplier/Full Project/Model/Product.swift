//
//  Product.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 06/03/2023.
//

import Foundation
struct Product:Codable{
    let werehouseID:Int?
    let title:String?
    let longitude:Double?
    let latitude:Double?
    
}

struct AddProduct:Codable{
    let WerehouseID:Int?
    let name:String?
    let Size:String?
    let Price:Int?
    let qty:Int?
    //let Image:String?
    let VendorID:Int?
    let SpecialOffer:Bool?
    
    
}
struct Products:Codable {
    let productID:Int?
    let werehouseID:Int?
    let productname:String?
    let size:String?
    var price : Int? = 0
    let qty:Int?
    let image:String?
    let vendorID:Int?
    }
struct RatingProducts:Codable {
    let productID:Int?
    let werehouseID:Int?
    let productname:String?
    let size:String?
    var price : Int? = 0
    let qty:Int?
    let image:String?
    let vendorID:Int?
    let ratingCount:Int?
    let averageRating:Float?
    }
struct vendorProducts:Codable {
    let productID:Int?
    let werehouseID:Int?
    let title:String?
    let productname:String?
    let size:String?
    var price : Int? = 0
    let qty:Int?
    let image:String?
    let vendorID:Int?
    }
struct searchProducts:Codable{
    let productname:String?
    let size:String?
    var price : Int? = 0
    let image:String?
}
struct SearchData:Codable{
    let StartDate:Date?
    let EndDate:Date?
    let Vid : Int? = 0
    
}


struct ExportData: Codable {
    let name: String?
    let productname: String?
    let price: Int?
    let quantity: Int?
    let totalPrice: Int?
    let date: Date?
    let remainingStock: Int?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case productname
        case price
        case quantity
        case totalPrice
        case date
        case remainingStock
    }
    
    init(name: String?, productname: String?, price: Int?, quantity: Int?, totalPrice: Int?, date: Date?, remainingStock: Int?) {
        self.name = name
        self.productname = productname
        self.price = price
        self.quantity = quantity
        self.totalPrice = totalPrice
        self.date = date
        self.remainingStock = remainingStock
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        productname = try container.decodeIfPresent(String.self, forKey: .productname)
        price = try container.decodeIfPresent(Int.self, forKey: .price)
        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
        totalPrice = try container.decodeIfPresent(Int.self, forKey: .totalPrice)
        remainingStock = try container.decodeIfPresent(Int.self, forKey: .remainingStock)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let dateString = try container.decodeIfPresent(String.self, forKey: .date),
            let formattedDate = dateFormatter.date(from: dateString) {
            date = formattedDate
        } else {
            date = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(productname, forKey: .productname)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(quantity, forKey: .quantity)
        try container.encodeIfPresent(totalPrice, forKey: .totalPrice)
        try container.encodeIfPresent(remainingStock, forKey: .remainingStock)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = date {
            let dateString = dateFormatter.string(from: date)
            try container.encode(dateString, forKey: .date)
        } else {
            try container.encodeNil(forKey: .date)
        }
    }
}
