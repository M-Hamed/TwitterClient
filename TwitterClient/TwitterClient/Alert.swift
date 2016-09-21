import Foundation
import UIKit

class Alert
{
    
    
    
    class func showAlert(VC : UIViewController , alertType : AlertType)
    {
        switch alertType
        {
            
        case AlertType.Error :
            let alert = UIAlertController(title: "Something went wrong!", message:"We are working on it " , preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(
                UIAlertAction(title:  "Something went wrong!", style: UIAlertActionStyle.Default, handler:nil)//end handler
            )
            VC.presentViewController(alert, animated : true , completion : nil)
            
            
        default:
            print("Default")
            
        }
    }
    
    class func showAlert(VC : UIViewController ,  message : String , title : String)
    {
        showAlert(VC, message: message, title: title, completion: nil)
    }
    
    class func showAlert(VC : UIViewController ,  message : String , title : String , completion : ((UIAlertAction!) -> Void)?)
    {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(
            UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: completion)
            //end handler
        )
        VC.presentViewController(alert, animated : true , completion : nil)
    }
    
}

class AlertActivityIndicator {
    
    var currentViewController : UIViewController!
    var currentAlert : UIAlertView!
    var currentActivityIndicator : UIActivityIndicatorView!
    
    var title : String? = nil
    var message : String? = NSLocalizedString("pleaseWait", comment : "")
    var cancelButtonTitle : String? = nil
    
    init(parent : UIViewController)
    {
        self.currentViewController = parent
        
        initializeDialog()
    }
    
    init(parent : UIViewController , title : String? , message : String? , cancelButtonTitle : String?)
    {
        self.currentViewController = parent
        
        if(title != nil)
        {
            self.title = title!
        }
        
        if(message != nil)
        {
            self.message = message!
        }
        
        if(cancelButtonTitle != nil)
        {
            self.cancelButtonTitle = cancelButtonTitle!
        }
        
        initializeDialog()
    }
    
    private func initializeDialog()
    {
        currentAlert = UIAlertView(title: self.title, message: self.message, delegate: nil, cancelButtonTitle: self.cancelButtonTitle);
        currentActivityIndicator = UIActivityIndicatorView(frame: CGRectMake(50, 10, 40, 40)) as UIActivityIndicatorView
        currentActivityIndicator.center = self.currentViewController.view.center;
        currentActivityIndicator.hidesWhenStopped = true
        currentActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        currentActivityIndicator.color = UIColor.whiteColor()
        //currentActivityIndicator.startAnimating();
        currentAlert.setValue(currentActivityIndicator, forKey: "accessoryView")
    }
    
    func show()
    {
        currentAlert.show();
        currentActivityIndicator.startAnimating()
    }
    
    func hide()
    {
        currentAlert.dismissWithClickedButtonIndex(0, animated: true)
        currentActivityIndicator.stopAnimating()
    }
}

enum AlertType
{
    case Error
    case Success
}
