//
//  Coordinator.swift
//  PhotoMap
//
//  Created by Ivan Chen on 8/17/17.
//
//

import Foundation
import UIKit

protocol Coordinator: class
{
    //    var rootViewController: UIViewController { get }
    var childCoordinators: [Coordinator] { get set }

    func add(childCoordinators: [Coordinator])
    func remove(coordinatorsToBeRemoved: [Coordinator])
}

extension Coordinator
{
    func add(childCoordinators: [Coordinator])
    {
        self.childCoordinators += childCoordinators
    }

    func remove(coordinatorsToBeRemoved: [Coordinator])
    {
        self.childCoordinators = self.childCoordinators.filter
            { (childCoordinator) -> Bool in
                !coordinatorsToBeRemoved.contains
                    { (coordinator) -> Bool in
                        coordinator === childCoordinator
                }
        }
    }
}
