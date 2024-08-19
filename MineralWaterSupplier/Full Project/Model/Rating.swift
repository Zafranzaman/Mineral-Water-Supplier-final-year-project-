//
//  Rating.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 21/05/2023.
//

import Foundation
struct Addarating:Codable{
    let CustomerID:Int?
    let VendorID:Int?
    let ProductID:Int?
    let Packing:Int?
    let Quality:Int?
    let DeliveryTime:Int?
}
struct SetLocation:Codable{
    let CustomerID:Int?
    let Title:String?
    let Longitude:Double?
    let Latitude:Double?
}
