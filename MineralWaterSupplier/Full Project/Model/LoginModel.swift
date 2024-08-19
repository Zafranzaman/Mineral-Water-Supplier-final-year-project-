//
//  LoginModel.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 10/01/2023.
//

import Foundation

struct SignUpModel:Codable{
    //let Id:Int?
    let Name:String?
    let Address:String?
    let PhoneNo:String?
    let Email:String?
    let Password:String?
    let City:String?
    let UserType:String?
}
struct LoginModel:Codable{
    let acountId:Int?
    let name:String?
    let phoneNo:String?
    let email:String?
    let status:Bool?
    let city:String?
    let userType:UserType?
}

enum UserType:String, Codable {
    case Agency
    case Vendor
    case Customer
    case DeliveryBoy
    case superAdmin
}
struct AssignOrder:Codable{
    let Oid:Int?
    let DeliveryboyID:Int?
}
struct WeeklySchedule:Codable{
    //let Id:Int?
    let CustomerID:Int?
    let OrderID:Int?
    let Package:String?
    //let Date:Date?
    let Sat:Bool?
    let Sun:Bool?
    let Mon:Bool?
    let Tue:Bool?
    let Wed:Bool?
    let Thu:Bool?
    let Fri:Bool?
    let Saturdayshift:String?
    let Sundayshift:String?
    let Mondayshift:String?
    let Tuesdayshift:String?
    let Wednesdayshift:String?
    let Thursdayshift:String?
    let Fridayshift:String?
    
}
struct addSchedule:Codable{
    //let Id:Int?
    let CustomerID:Int?
    let OrderID:Int?
    let Package:String?
    //let Date:Date?
    let Sat:Bool?
    let Sun:Bool?
    let Mon:Bool?
    let Tue:Bool?
    let Wed:Bool?
    let Thu:Bool?
    let Fri:Bool?
    
}
struct addScheduleMonthly:Codable{
    //let Id:Int?
    let CustomerID:Int?
    let OrderID:Int?
    let Package:String?
    let Sat:Bool?
    let Sun:Bool?
    let Mon:Bool?
    let Tue:Bool?
    let Wed:Bool?
    let Thu:Bool?
    let Fri:Bool?
    let Date:String?
}
struct AllSchedule:Codable{
    let sChedule1:Int?
    let orderID:Int?
    let customerID:Int?
    let package:String?
    let status:Bool?
    let name:String?
    let phoneNo:String?
}
