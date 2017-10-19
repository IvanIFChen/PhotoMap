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
    weak var snapDataRepositoryDelegate: SnapDataRepository?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        selectedIndex = 0

        self.delegate = self

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }

        let snapDataRepositoryDelegate = SnapDataRepository(appDelegate: appDelegate)
        self.snapDataRepositoryDelegate = snapDataRepositoryDelegate

        if let mapViewController = viewControllers?.first as? MapViewController
        {
            mapViewController.snapDataRepositoryDelegate = snapDataRepositoryDelegate
        }

//        viewControllers?.forEach(
//        { (viewController) in
//            if let mapViewController = viewController as? MapViewController
//            {
//                mapViewController.snapDataRepositoryDelegate = snapDataRepositoryDelegate
//            }
//            if let cameraViewController = viewController as? CameraViewController
//            {
//                cameraViewController.snapDataRepositoryDelegate = snapDataRepositoryDelegate
//            }
//            if let albumViewController = viewController as? AlbumViewController
//            {
//                albumViewController.snapDataRepositoryDelegate = snapDataRepositoryDelegate
//            }
//        })
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        switch viewController
        {
            case is MapViewController:
                if let mapViewController = viewController as? MapViewController
                {
                    mapViewController.snapDataRepositoryDelegate = snapDataRepositoryDelegate
                }
            case is CameraViewController:
                if let cameraViewController = viewController as? CameraViewController
                {
                    cameraViewController.snapDataRepositoryDelegate = snapDataRepositoryDelegate
                }
            case is AlbumViewController:
                if let albumViewController = viewController as? AlbumViewController
                {
                    albumViewController.snapDataRepositoryDelegate = snapDataRepositoryDelegate
                }
            default:
                print("do nothing")
        }
    }
}
