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
        
        Alamofire.request(serviceURL, method: .get).responseJSON { (service) -> Void in
            
            switch service.result{
            case .failure(let error):
                
                let mAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                mAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        currentController.performSegue(withIdentifier: "goToMenu2", sender: nil)
                    } else {
                        currentController.performSegue(withIdentifier: "goToMenu", sender: nil)
                    }
                    
                }))
                currentController.present(mAlert, animated: true, completion: nil)
                
                break
            case .success(_):
                let jsonObject = service.result.value
                //print(jsonObject)
                let myDB = DBHelper.Instance
                myDB.saveAllData(rawJsonData: jsonObject! as AnyObject)
                
                DispatchQueue.main.async {
                    if UIDevice.current.userInterfaceIdiom == .pad{
                        currentController.performSegue(withIdentifier: "goToMenu2", sender: nil)
                    } else {
                        currentController.performSegue(withIdentifier: "goToMenu", sender: nil)
                    }
                }
                break
            }
        }
    }
}
