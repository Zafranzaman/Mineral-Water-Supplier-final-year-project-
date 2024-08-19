//
//  AddScheduleViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 26/05/2023.
//

import UIKit

class AddScheduleViewController: UIViewController {
    @IBOutlet weak var DateText: UITextField!
    @IBOutlet weak var datePicker1: UIDatePicker!
    let dateFormatter = DateFormatter()
    @IBOutlet weak var daily: UIButton!
    @IBOutlet weak var weekly: UIButton!
    @IBOutlet weak var monthly: UIButton!
    @IBOutlet weak var orderid: UILabel!
    @IBOutlet weak var txtdate: UITextField!
    var sunday = false
    var monday = false
    var tuesday = false
    var wednesday = false
    var thusrday = false
    var friday = false
    var saturday = false
    
    var oid = 0
    var lastorder = [AllOrder]()
    var Package = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteCart()
        Allorder()
//        orderid.text = "OrderNo:\(oid)"
        datePicker1.locale = .current
        datePicker1.date = Date()
        datePicker1.locale = Locale(identifier: "en_US")
        datePicker1.preferredDatePickerStyle = .compact
        //datePicker1.addTarget(self, action: #selector(startdate), for: .valueChanged)
        
        datePicker1.addTarget(self, action: #selector(startdate(sender:)), for: UIControl.Event.valueChanged)
        DateText.inputView = datePicker1
    }
    var sdate: Date?

    @objc func startdate(sender: UIDatePicker) {
        let selectedDate = sender.date
        let timeZoneOffset = TimeZone.current.secondsFromGMT()
        let adjustedDate = selectedDate.addingTimeInterval(TimeInterval(timeZoneOffset))
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        DateText.text = dateFormatter.string(from: adjustedDate)
        sdate = adjustedDate
        print(sdate!)
    }


    @objc func deleteCart()
    {
        let api = APIWrapper()
        
        let response = api.DeleteMethod(controllerName: "Cart", actionName: "DeleteCartRecords",id: UserSession.shared.user?.acountId ?? 0)
        
        if response.ResponseCode == 200 {
            
            print(response.ResponseMessage)
        }
    }
    @objc func Allorder() {
        let endpoint = "ManageOrder/lastorder"
        
        let params: [String: Any] = ["cid":UserSession.shared.user?.acountId ?? 0]
        NetworkManager.shared.request(endpoint, decoder: [AllOrder].self, method: .get, parameters: params, headers: nil) { results in
            switch results {
            case .success(let data):
                self.lastorder = data
                self.orderid.text = "OrderNo:\(self.lastorder[0].oid!)"
                self.oid = self.lastorder[0].oid!
            case .failure(let error):
                Utility.showAlertWithOkAndCancel(title: "Oops..!, error \(error.localizedDescription)")
            }
        }
    }
    
}
extension AddScheduleViewController {
    @IBAction func dailyClick(_ sender: Any) {
        daily.isSelected = true
        weekly.isSelected = false
        monthly.isSelected = false
        Package = "Daily"
        print(Package)
        datePicker1.isUserInteractionEnabled = false
        
    }
    
    @IBAction func weeklyClick(_ sender: Any) {
        daily.isSelected = false
        weekly.isSelected = true
        monthly.isSelected = false
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "WeeklyScheduleViewController") as! WeeklyScheduleViewController
        vc.oid = oid
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
        
    }
    @IBAction func monthlyClick(_ sender: Any) {
        datePicker1.isUserInteractionEnabled = true
        daily.isSelected = false
        weekly.isSelected = false
        monthly.isSelected = true
        Package = "Monthly"
        print(Package)
        
    }
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    @IBAction private func SaveSchdule(_ sender: UIButton){
        if(Package == "Daily"){
           // var date:Date? = Date()

            let cid = UserSession.shared.user?.acountId ?? 0
            let order_id = oid
            let api = APIWrapper()
            let userinfo = addSchedule(CustomerID: cid, OrderID: order_id, Package: "Daily", Sat: saturday, Sun: sunday, Mon: monday, Tue: tuesday, Wed: wednesday, Thu: thusrday, Fri: friday)
            let json = try! JSONEncoder().encode(userinfo)
            
            let response = api.postMethodCall(controllerName: "Schedule", actionName: "AddSchedule", httpBody: json)
            var message = ""
            if response.ResponseCode == 200 {
                
                
                message = response.ResponseMessage
            }else{
                message = response.ResponseMessage
            }
            let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
        }
        else if(Package == "Monthly")  {
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = dateFormatter.string(from: sdate ?? Date())
            let cid = UserSession.shared.user?.acountId ?? 0
            let order_id = oid
            print(sdate!)
            print(order_id)
            print(dateString)
            let api = APIWrapper()
            let userinfo = addScheduleMonthly(CustomerID: cid, OrderID: order_id, Package: "Monthly", Sat: saturday, Sun: sunday, Mon: monday, Tue: tuesday, Wed: wednesday, Thu: thusrday, Fri: friday, Date: dateString)
            let json = try! JSONEncoder().encode(userinfo)
            
            let response = api.postMethodCall(controllerName: "Schedule", actionName: "AddSchedule", httpBody: json)
            var message = ""
            if response.ResponseCode == 200 {
                
                
                message = response.ResponseMessage
            }else{
                message = response.ResponseMessage
            }
            let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
        }
    }
}
