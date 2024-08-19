//
//  Cart.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 04/04/2023.
//

import Foundation
struct AddToCart:Codable{
    let ProductID:Int?
    let CustomerID:Int?
    let Price:Int?
    let Quantity:Int? 
}
struct CustomerCart:Codable{
    
    let customerID:Int?
    let productID:Int?
    let productname:String?
    let size:String?
    
    let quantity:Int?
    let image:String?
    let price:Double?
    
}
struct deletecartproduct:Codable{
    
    let cart_Id:Int?
    let price:Int?
    let quantity:Int?
}
struct Addqty:Codable{
    let cart_Id:Int?
    let productID:Int?
    let customerID:Int?
    let price:Int?
    let quantity:Int?
}
struct AddOrder: Codable {
    let CustomerID: Int?
    let Contact: String?
    let TotalPrice: Double?
    let Quantity: Int?
    let City : String?
    let Longitude: Float?
    let Latitude: Float?
    let carts: [OrderDetail]
}

struct OrderDetail: Codable {
    let cart_Id :Int?
    let customerID: Int?
    let productID: Int?
    let quantity: Int?
    let price: Int?
}

