//
//  WeeklyScheduleViewController.swift
//  MineralWaterSupplier
//
//  Created by Zafran on 28/05/2023.
//

import UIKit

class WeeklyScheduleViewController: UIViewController {
    @IBOutlet weak var s1: UIButton!
    @IBOutlet weak var s2: UIButton!
    @IBOutlet weak var s3: UIButton!
    @IBOutlet weak var m1: UIButton!
    @IBOutlet weak var m2: UIButton!
    @IBOutlet weak var m3: UIButton!
    @IBOutlet weak var t1: UIButton!
    @IBOutlet weak var t2: UIButton!
    @IBOutlet weak var t3: UIButton!
    @IBOutlet weak var w1: UIButton!
    @IBOutlet weak var w2: UIButton!
    @IBOutlet weak var w3: UIButton!
    @IBOutlet weak var th1: UIButton!
    @IBOutlet weak var th2: UIButton!
    @IBOutlet weak var th3: UIButton!
    @IBOutlet weak var f1: UIButton!
    @IBOutlet weak var f2: UIButton!
    @IBOutlet weak var f3: UIButton!
    @IBOutlet weak var sa1: UIButton!
    @IBOutlet weak var sa2: UIButton!
    @IBOutlet weak var sa3: UIButton!
    
    
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tue: UIButton!
    @IBOutlet weak var wed: UIButton!
    @IBOutlet weak var thu: UIButton!
    @IBOutlet weak var fri: UIButton!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var orderid: UILabel!
    var Mondayshift = "NotSet"
    var Tuesdayshift = "NotSet"
    var Wednesdayshift = "NotSet"
    var Thursdayshift = "NotSet"
    var Fridayshift = "NotSet"
    var Saturdayshift = "NotSet"
    var Sundayshift = "NotSet"
    @IBAction func f1(_ sender: Any) {
        if sat.isSelected  {
            sa1.isSelected = true
            sa2.isSelected = false
            sa3.isSelected = false
            Saturdayshift = "Morning"
        }
    }
    
    @IBAction func f2(_ sender: Any) {
        if sat.isSelected  {
            sa1.isSelected = false
            sa2.isSelected = true
            sa3.isSelected = false
            Saturdayshift = "AfterNoon"
        }
    }
    @IBAction func f3(_ sender: Any) {
        if sat.isSelected  {
            sa1.isSelected = false
            sa2.isSelected = false
            sa3.isSelected = true
            Saturdayshift = "Evening"
        }
    }
    
    
    
    @IBAction func f4(_ sender: Any) {
        if sun.isSelected  {
            s1.isSelected = true
            s2.isSelected = false
            s3.isSelected = false
            Sundayshift = "Morning"
        }
    }
    
    
    @IBAction func f5(_ sender: Any) {
        if sun.isSelected  {
            s1.isSelected = false
            s2.isSelected = true
            s3.isSelected = false
            Sundayshift = "AfterNoon"
        }
        
    }
    
    @IBAction func f6(_ sender: Any) {
        if sun.isSelected  {
            s1.isSelected = false
            s2.isSelected = false
            s3.isSelected = true
            Sundayshift = "Evening"
        }
    }
    
    @IBAction func f7(_ sender: Any) {
        if mon.isSelected  {
            m1.isSelected = true
            m2.isSelected = false
            m3.isSelected = false
            Mondayshift = "Morning"
        }
    }
    
    @IBAction func f8(_ sender: Any) {
        if mon.isSelected  {
            m1.isSelected = false
            m2.isSelected = true
            m3.isSelected = false
            Mondayshift = "AfterNoon"
        }
    }
    @IBAction func f9(_ sender: Any) {
        if mon.isSelected  {
            m1.isSelected = false
            m2.isSelected = false
            m3.isSelected = true
            Mondayshift = "Evening"
        }
    }
    @IBAction func f10(_ sender: Any) {
        if tue.isSelected  {
            t1.isSelected = true
            t2.isSelected = false
            t3.isSelected = false
            Tuesdayshift = "Morning"
        }
    }
    @IBAction func f11(_ sender: Any) {
        if tue.isSelected  {
            t1.isSelected = false
            t2.isSelected = true
            t3.isSelected = false
            Tuesdayshift = "AfterNoon"
        }
    }
    @IBAction func f12(_ sender: Any) {
        if wed.isSelected  {
            t1.isSelected = false
            t2.isSelected = false
            t3.isSelected = true
            Tuesdayshift = "Evening"
        }
    }
    @IBAction func f13(_ sender: Any) {
        if wed.isSelected  {
            w1.isSelected = true
            w2.isSelected = false
            w3.isSelected = false
            Wednesdayshift = "Morning"
        }
    }
    @IBAction func f14(_ sender: Any) {
        if wed.isSelected  {
            w1.isSelected = false
            w2.isSelected = true
            w3.isSelected = false
            Wednesdayshift = "AfterNoon"
        }}
    @IBAction func f15(_ sender: Any) {
        if wed.isSelected  {
            w1.isSelected = false
            w2.isSelected = false
            w3.isSelected = true
            Wednesdayshift = "Evening"
        }
    }
    @IBAction func f16(_ sender: Any) {
        if thu.isSelected  {
            th1.isSelected = true
            th2.isSelected = false
            th3.isSelected = false
            Thursdayshift = "Morning"
        }
    }
    @IBAction func f17(_ sender: Any) {
        if thu.isSelected  {
            th1.isSelected = false
            th2.isSelected = true
            th3.isSelected = false
            Thursdayshift = "AfterNoon"
        }
    }
    @IBAction func f18(_ sender: Any) {
        if thu.isSelected  {
            th1.isSelected = false
            th2.isSelected = false
            th3.isSelected = true
            Thursdayshift = "Evening"
        }
    }
    @IBAction func f19(_ sender: Any) {
        if fri.isSelected  {
            f1.isSelected = true
            f2.isSelected = false
            f3.isSelected = false
            Fridayshift = "Morning"
            
        }}
    @IBAction func f20(_ sender: Any) {
        if fri.isSelected  {
            f1.isSelected = false
            f2.isSelected = true
            f3.isSelected = false
            Fridayshift = "AfterNoon"
        }
    }
    @IBAction func f21(_ sender: Any) {
        if fri.isSelected  {
            f1.isSelected = false
            f2.isSelected = false
            f3.isSelected = true
            Fridayshift = "Evening"
        }
    }
    @IBAction func btnsaturday(_ sender: UIButton) {
        if sender.tag == 1 {
                
            }
            else if sender.tag == 2 {
                    
                }
            else if sender.tag == 3 {
                   
                }
        }
    @IBAction func btnsunday(_ sender1: UIButton) {
        if sender1.tag == 4 {
               
            }
            else if sender1.tag == 5 {
                }
            else if sender1.tag == 6 {
                   
                }
        }
    @IBAction func btnmonday(_ sender2: UIButton) {
        if sender2.tag == 7 {
               
            }
            else if sender2.tag == 8 {
                    
                }
            else if sender2.tag == 9 {
                   
                }
        }
    @IBAction func btntuesday(_ sender3: UIButton) {
        if sender3.tag == 10 {
                
            }
            else if sender3.tag == 11 {
                   
                }
            else if sender3.tag == 12 {
                  
                }
        }

    @IBAction func btnwednesday(_ sender4: UIButton) {
        if sender4.tag == 13 {
               
            }
            else if sender4.tag == 14 {
                    
                }
            else if sender4.tag == 15 {
                   
                }
        }
    @IBAction func btnthusrday(_ sender5: UIButton) {
        if sender5.tag == 16 {
               
            }
            else if sender5.tag == 17 {
                    
                }
            else if sender5.tag == 18 {
                 
                }
        }
    @IBAction func btnfriday(_ sender6: UIButton) {
        if sender6.tag == 19 {
                
            }
            else if sender6.tag == 20 {
                   
                }
            else if sender6.tag == 21 {
                   
                }
        }
    
    
    
    
    var sunday = false
    var monday = false
    var tuesday = false
    var wednesday = false
    var thusrday = false
    var friday = false
    var saturday = false
    var oid = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderid.text = "OrderNo:\(oid)"
    }
    @IBAction func chkboxClick(_ sender: UIButton) {
        if sender.tag == 1 {
            if sun.isSelected {
                sun.isSelected = false
                sunday = false
            }else{
                sun.isSelected = true
                sunday = true
            }
        }else if sender.tag == 2 {
            if mon.isSelected {
                mon.isSelected = false
                monday = false
            }else{
                mon.isSelected = true
                monday = true
            }
        }else if sender.tag == 3 {
            if tue.isSelected {
                tue.isSelected = false
                tuesday = false
            }else{
                tue.isSelected = true
                tuesday = true
            }
        }else if sender.tag == 4 {
            if wed.isSelected {
                wed.isSelected = false
                wednesday = false
            }else{
                wed.isSelected = true
                wednesday = true
            }
        }else if sender.tag == 5 {
            if thu.isSelected {
                thu.isSelected = false
                thusrday = false
            }else{
                thu.isSelected = true
                thusrday = true
            }
        }else if sender.tag == 6 {
            if fri.isSelected {
                fri.isSelected = false
                friday = false
            }else{
                fri.isSelected = true
                friday = true
                
            }
        }else if sender.tag == 7 {
            if sat.isSelected {
                sat.isSelected = false
                saturday = false
            }else{
                sat.isSelected = true
                saturday = true
            }
        }
        
    }
    @IBAction func SaveClick(_ sender: UIButton) {
        
        print(sunday)
        print(monday)
        print(tuesday)
        print(wednesday)
        print(thusrday)
        print(friday)
        print(saturday)
        let cid = UserSession.shared.user?.acountId ?? 0
        let order_id = oid
        let api = APIWrapper()
        //var date:Date? = Date()
        let userinfo = WeeklySchedule(CustomerID: cid, OrderID: order_id, Package: "Weekly",Sat: saturday, Sun: sunday, Mon: monday, Tue: tuesday, Wed: wednesday, Thu: thusrday, Fri: friday,Saturdayshift: Saturdayshift,Sundayshift: Sundayshift,Mondayshift: Mondayshift,Tuesdayshift: Tuesdayshift,Wednesdayshift: Wednesdayshift,Thursdayshift: Thursdayshift,Fridayshift: Fridayshift)
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
    @IBAction private func back(_ sender: UIButton){
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "Customertabbar") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
}
