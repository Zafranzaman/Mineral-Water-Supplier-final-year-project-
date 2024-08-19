//
//  Orders.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 05/05/2023.
//

import Foundation
struct AllOrder:Codable{
    let oid:Int?
    let customerID:Int?
    let name:String?
    let totalPrice:Int?
    let contact:String?
    let date:String?
    let orderStatus:Int?
    
    
}
struct GetStock:Codable{
    let order_detailsid:Int?
    let customerID:Int?
    let productID:Int?
    let orderID:Int?
    let quantity:Int?
    let price:Int?
    
}
struct SendStock:Codable{
    let Order_detailsid:Int?
    let CustomerID:Int?
    let ProductID:Int?
    let OrderID:Int?
    let Quantity:Int?
    let Price:Int?
    
}
struct DeliveryBoyOrder:Codable{
    let oid:Int?
    let deliveryboyID:Int?
    let customerID:Int?
    let name:String?
    let totalPrice:Int?
    let contact:String?
    let date:String?
    let orderStatus:Int?
    let latitude:Float?
    let longitude:Float?
    let package:String?
    let mondayshift:String?
    let tuesdayshift:String?
    let wednesdayshift:String?
    let thursdayshift:String?
    let fridayshift:String?
    let saturdayshift:String?
    let sundayshift:String?
    let mon:Bool?
    let tue:Bool?
    let wed:Bool?
    let thu:Bool?
    let fri:Bool?
    let sat:Bool?
    let sun:Bool?
}
struct OrderLocationData:Codable{
    let Oid:Int?
    let Did:Int?
    let OrderLat:Float?
    let OrderLong:Float?
    let dLat:Float?
    let dlong:Float?
    let DeliveryBoyname:String?
    let DeliveryBoyContact:String?
    
}
struct GetOrderLocationData:Codable{
    let orderLocationId:Int?
    let oid:Int?
    let did:Int?
    let orderLat:Float?
    let orderlong:Float?
    let dLat:Float?
    let dlong:Float?
    let deliveryBoyname:String?
    let deliveryBoyContact:String?
}
struct OrderDetailList:Codable{
    let orderId:Int?
    let productName:String?
    let quantity:Int?
    let price:Int?
    let size:String?
    
    
}
struct Location:Codable{
    let customerID:Int?
    let title:String?
    let longitude:Double?
    let latitude:Double?
    
    
}

