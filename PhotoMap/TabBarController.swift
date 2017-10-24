//
//  TabBarController
//  PhotoMap
//
//  Created by Ivan Chen on 8/27/17.
//
//

import UIKit

class TabBarController: UITabBarController
{
    fileprivate var snapDataRepository = SnapDataRepository(appDelegate: (UIApplication.shared.delegate as? AppDelegate)!)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        selectedIndex = 0

        self.delegate = self

        if let mapViewController = selectedViewController as? MapViewController
        {
            mapViewController.snapDataRepositoryDelegate = snapDataRepository
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
        switch viewController
        {
        case is MapViewController:
            if let mapViewController = viewController as? MapViewController
            {
                mapViewController.snapDataRepositoryDelegate = snapDataRepository
            }
        case is CameraViewController:
            if let cameraViewController = viewController as? CameraViewController
            {
                cameraViewController.snapDataRepositoryDelegate = snapDataRepository
            }
        case is AlbumViewController:
            if let albumViewController = viewController as? AlbumViewController
            {
                albumViewController.snapDataRepositoryDelegate = snapDataRepository
            }
        default:
            print("do nothing")
        }
        return true
    }
}
