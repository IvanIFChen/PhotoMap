//
//  AppCoordinator.swift
//  PhotoMap
//
//  Created by Ivan Chen on 8/17/17.
//
//

import Foundation
import UIKit

class AppCoordinator: Coordinator
{
    //    var rootViewController: UIViewController
    var childCoordinators: [Coordinator] = []

    //    init(rootViewController: UIViewController = TabBarController.instantiate())
    init()
    {
        //        self.rootViewController = rootViewController
    }
}
