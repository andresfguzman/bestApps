//
//  SplashInteractor.swift
//  BestApps
//
//  Created by Andrés Guzmán on 9/05/20.
//  Copyright © 2020 andres. All rights reserved.
//

import Foundation

final class SplashInteractor: SplashInteractorProtocol {
    weak var presenter: SplashInteractorOutput!
    var service: BestAppsService
    
    init(service: BestAppsService) {
        self.service = service
    }
    
    func getData() {
        (service as? FeedService)?.getFeed(completion: { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success:
                strongSelf.presenter.getDataSucceeds()
            case .failure(let error):
                strongSelf.presenter.getDataFails(with: error)
            }
        })
    }
}
