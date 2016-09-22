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
enum AlertType
{
    case Error
    case Success
}
