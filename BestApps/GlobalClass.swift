//
//  GlobalClass.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceResult {
    case success
    case failure(error: Error)
}

typealias ServiceResponse = (ServiceResult) -> Void

class GlobalClass: NSObject {
    
    
    static let Instance = GlobalClass()
    
    let mainServiceURL = NSLocalizedString("general_webservice", comment: "")
    
    func obtainMainService(with closure: @escaping ServiceResponse) {
        
        Alamofire.request(mainServiceURL, method: .get).responseJSON { (service) -> Void in
            
            switch service.result{
            case .failure(let error):
                closure(.failure(error: error))

            case .success:
                let jsonObject = service.result.value
                let myDB = DBHelper.Instance
                myDB.saveAllData(rawJsonData: jsonObject! as AnyObject)
                closure(.success)
            }
        }
    }
}
