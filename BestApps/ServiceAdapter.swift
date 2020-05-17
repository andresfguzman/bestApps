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

protocol AppStoreFeedNetworking {
    func getFeed(with completion: @escaping ServiceResponse)
}

class ServiceAdapter: AppStoreFeedNetworking {
    static let Instance = ServiceAdapter()
    
    enum ServiceError: Error {
        case failed
    }
    
    func getFeed(with completion: @escaping ServiceResponse) {
        URLSession.shared.dataTask(with: URL(string: Environment.apiURL)!) { (result) in
            switch result {
            case .success(let( _, data)):
                do {
                    let feedObject = try JSONDecoder().decode(Payload.self, from: data)
                    // TODO: move this logic somewhere else.
                    DispatchQueue.main.async {
                        let myDB = DBHelper.Instance
                        myDB.save(feedObject)
                        completion(.success)
                    }
                } catch {
                    print("Failed to load: \(error.localizedDescription)")
                    completion(.failure(error: error))
                }
            case .failure(let error):
                completion(.failure(error: error))
            }
        }.resume()
    }
}
