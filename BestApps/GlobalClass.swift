//
//  GlobalClass.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import Foundation
import Alamofire

class GlobalClass: NSObject {
  
  
  static let Instance = GlobalClass()
  
  let mainServiceURL = NSLocalizedString("general_webservice", comment: "")

  // MARK: Helper Functions
  /*
  Método para consumir el servicio con los datos de las aplicaciones.
  Parámetro 1: Url del servicio.
  Parámetro 2: el controlador actual.
  */
  
  func obtainMainService(serviceURL: String, currentController: UIViewController) {
    
    Alamofire.request(.GET, serviceURL).responseJSON { (service) -> Void in
      
      switch service.result{
      case .Failure:
        
        let mAlert = UIAlertController(title: "Error", message: "Error al conectar con el servidor, se usarán datos en memoria.", preferredStyle: UIAlertControllerStyle.Alert)
        mAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
          
          if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            currentController.performSegueWithIdentifier("goToMenu2", sender: nil)
          } else {
            currentController.performSegueWithIdentifier("goToMenu", sender: nil)
          }
          
        }))
        currentController.presentViewController(mAlert, animated: true, completion: nil)
        
        break
      case .Success:
        let jsonObject = service.result.value
        //print(jsonObject)
        let myDB = DBHelper.Instance
        myDB.saveAllData(jsonObject!)
        dispatch_async(dispatch_get_main_queue(),{
          if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            currentController.performSegueWithIdentifier("goToMenu2", sender: nil)
          } else {
            currentController.performSegueWithIdentifier("goToMenu", sender: nil)
          }
          })
        break
      }
    }
  }
  
}