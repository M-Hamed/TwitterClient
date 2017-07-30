import Foundation
import UIKit

class Alert
{
        
    class func showAlert(_ VC : UIViewController , alertType : AlertType)
    {
        switch alertType
        {
            
        case AlertType.error :
            let alert = UIAlertController(title: "Something went wrong!", message:"We are working on it " , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(
                UIAlertAction(title:  "Something went wrong!", style: UIAlertActionStyle.default, handler:nil)
            )
            VC.present(alert, animated : true , completion : nil)
            
        default:
            print("Default")
            
        }
    }
    
    class func showAlert(_ VC : UIViewController ,  message : String , title : String) {
        showAlert(VC, message: message, title: title, completion: nil)
    }
    
    class func showAlert(_ VC : UIViewController ,  message : String , title : String , completion : ((UIAlertAction?) -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: completion))
        
        VC.present(alert, animated : true , completion : nil)
    }
    
}

enum AlertType {
    case error
    case success
}
