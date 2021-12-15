//
//  RadialAnimatedViewController.swift
//  BestApps
//
//  Created by Andrés Guzmán on 14/12/21.
//  Copyright © 2021 andres. All rights reserved.
//

import UIKit

protocol RadialTransitionable {
    var triggerView: UIView { get }
    var cosmeticView: UIView { get }
    var mainView: UIView { get }
}

class RadialAnimatedViewController: BaseViewController, RadialTransitionable {
    var triggerView: UIView = UIView()
    var cosmeticView: UIView = UIView()
    var mainView: UIView { view }
}
