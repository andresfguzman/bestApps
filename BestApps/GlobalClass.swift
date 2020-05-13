//
//  GlobalClass.swift
//  BestApps
//
//  Created by Andres Guzman on 9/02/16.
//  Copyright © 2016 andres. All rights reserved.
//

import Foundation

enum ServiceResult {
    case success
    case failure(error: Error)
}

typealias ServiceResponse = (ServiceResult) -> Void

class GlobalClass: NSObject {

    static let Instance = GlobalClass()
    
    enum ServiceError: Error {
        case failed
    }
    
    func obtainMainService(with closure: @escaping ServiceResponse) {
        let mainTask = URLSession.shared.dataTask(with: URL(string: Environment.apiURL)!) { (result) in
            switch result {
            case .success(let( _, data)):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    // TODO: move this logic somewhere else.
                    DispatchQueue.main.async {
                        let myDB = DBHelper.Instance
                        myDB.saveAllData(rawJsonData: jsonObject as AnyObject)
                        closure(.success)
                    }
                } catch {
                    print("Failed to load: \(error.localizedDescription)")
                    closure(.failure(error: error))
                }
            case .failure(let error):
                closure(.failure(error: error))
            }
        }
        
        mainTask.resume()
    }
}
