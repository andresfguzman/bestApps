//
//  BestAppsService.swift
//  BestApps
//
//  Created by Andrés Guzmán on 19/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

enum BestAppResult {
    case success
    case failure(error: Error)
}

typealias BestAppResponse = (BestAppResult) -> Void
typealias ServiceResponse = (Result<(URLResponse, Data), Error>) -> Void

protocol BestAppsService {
    var endpoint: String { get set }
    func request(using completion: @escaping ServiceResponse)
}

extension BestAppsService {
    func request(using completion: @escaping ServiceResponse) {
        guard let apiURL = URL(string: endpoint) else { return }
        URLSession.shared.dataTask(with: apiURL, result: completion).resume()
    }
}
