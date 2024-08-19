//
//  Utility.swift
//  MineralWaterSupplier
//
//  Created by Zafran zaman on 21/02/2023.
//

import UIKit

class Utility {
    public static func GetImageFromURL (name:String)->UIImage?{
        let _url = URL(string: "http://192.168.250.48/FypFinalApi/Images/\(name)")
        guard let url = _url else {
            return nil
        }
        let _data = try? Data(contentsOf: url)
        guard let data = _data else {
            return nil
        }
        let image = UIImage(data: data)
        return image
    }
    public typealias EmptyCompletion = () -> Void
    
    static func alertMessage(title: String, message: String, completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert
            )
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                completion?()
            }))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    class func showAlertWithTryAgain(title: String, message: String = "Something wrong", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {_ in
                completion?()
            }))
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(
                alert,
                animated: true,
                completion: nil
            )
        }
    }
    
    class func showAlertWithOkAndCancel(title: String, message: String = "", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                completion?()
            }))
            alert.addAction(UIAlertAction(
                title: "Cancel",
                style: UIAlertAction.Style.default,
                handler: nil
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithCustomButton(buttonTitle: String, title: String, message: String = "", completion: EmptyCompletion? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
                completion?()
            }))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithCustomButtons(title: String, message: String = "", firstbuttonTitle: String = "OK", secondbuttonTitle: String = "Cancel", firstCompletion: EmptyCompletion? = nil, secondCompletion: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: firstbuttonTitle, style: .default, handler: {_ in
                firstCompletion?()
            }))
            alert.addAction(UIAlertAction(
                title: secondbuttonTitle,
                style: UIAlertAction.Style.default,
                handler: secondCompletion
            ))
            guard let window : UIWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            var presentVC = window.rootViewController
            while let next = presentVC?.presentedViewController {
                presentVC = next
            }
            presentVC?.present(alert, animated: true, completion: nil)
        }
    }
    
}
