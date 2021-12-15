//
//  Application+Utils.swift
//  BestApps
//
//  Created by Andrés Guzmán on 12/12/21.
//  Copyright © 2021 andres. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var rootModuleView:  UIViewController? {
        set {
            let windowScene = connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene
            guard let keyWindow = windowScene?.windows.first(where: { $0.isKeyWindow }) else { return }
            UIView.transition(with: keyWindow, duration: 0.5, options: [.transitionCurlUp], animations: {
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                keyWindow.rootViewController = newValue
                UIView.setAnimationsEnabled(oldState)
            }, completion: nil)
        }
        get {
            (connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow })?.rootViewController
        }
    }
}
