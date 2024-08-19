
import UIKit
//import FlagPhoneNumber

@IBDesignable
class UITextFieldX: UITextField {
    
    var isPresenting: Bool = false
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        self.clearButtonMode = .whileEditing
        setLeftImage()
        setRightImage()
        
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -10, dy: 0)
    }
    
    func setLeftImage() {
        
        leftViewMode = UITextField.ViewMode.always
        var view: UIView
        
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 18, height: 18))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            imageView.contentMode = .scaleAspectFit
            
            var width = imageView.frame.width + leftPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
        }
        view.addTapGesture {
            self.delegate?.textFieldDidBeginEditing?(self)
            _ = self.delegate?.textFieldShouldBeginEditing?(self)
        }
        leftView = view
    }
    
    func setRightImage() {
        rightViewMode = UITextField.ViewMode.unlessEditing
        
        var view: UIView
        
        if let image = rightImage, isRightViewVisible {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            imageView.contentMode = .scaleAspectFit
            
            var width = imageView.frame.width + rightPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            view.addTapGesture {
                self.delegate?.textFieldDidBeginEditing?(self)
                _ = self.delegate?.textFieldShouldBeginEditing?(self)
            }
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
        }
        
        rightView = view
    }
    
    private var _isRightViewVisible: Bool = true
    
    var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    @IBInspectable open var maxLength: Int = 0{
        didSet{
            NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: self)
        }
    }
     
     // Limit the length of text
    
     @objc func textDidChange(notification: Notification) {
         if let sender = notification.object as? UITextFieldX, sender == self {
             let text = text ?? ""
             if maxLength > 0 && text.count > maxLength {
                 let endIndex = text.index(text.startIndex, offsetBy: maxLength)
                 self.text = String(text[..<endIndex])
                 undoManager?.removeAllActions()
                 print("Max character limit is \(maxLength)")
                 }
             setNeedsDisplay()
         }
     }
    
}


extension UITextFieldX {

    func hideErrorInTextfiled(){
        self.borderWidth = 0
    }

}

