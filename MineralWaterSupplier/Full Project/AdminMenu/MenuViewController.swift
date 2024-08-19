// MenuViewController
//  MineralWaterSupplier
//
//  Created by Zafran on 19/01/2023.
//

import UIKit

protocol MenuViewControllerDelegate{
    func didPressHome()
    func didPressProfile()
    func didPressLogout()
}

class MenuViewController: UIViewController {
    
    // MARK: - Outlets
 
    // MARK: - Variables
    var delegate:MenuViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func closeAction(_ sender: UIButton){
        self.dismiss(animated: true)
    }

    @IBAction private func homeAction(_ sender: UIButton){
        self.delegate?.didPressHome()
        self.dismiss(animated: true)
    }
    
    @IBAction private func profileAction(_ sender: UIButton){
        self.delegate?.didPressProfile()
        self.dismiss(animated: true)
    }
    
    @IBAction private func logoutAction(_ sender: UIButton){
        self.delegate?.didPressLogout()
        self.dismiss(animated: true)
        //UserSession.shared.logout()
    }
}


class SlideInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: .to)!
        let fromViewController = transitionContext.viewController(forKey: .from)!
        
        let x: CGFloat = -containerView.frame.width
        let y: CGFloat = 0
        let width: CGFloat = containerView.frame.width / 2
        let height: CGFloat = containerView.frame.height
        
        if isPresenting {
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(x: x, y: y, width: width, height: height)
        }
        print(transitionDuration(using: transitionContext))
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            if self.isPresenting {
                toViewController.view.frame = CGRect(x: 0, y: y, width: width, height: height)
            } else {
                fromViewController.view.frame = CGRect(x: x, y: y, width: width, height: height)
            }
        }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}


