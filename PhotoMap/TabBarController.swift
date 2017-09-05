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
    enum TabBarItemType: Int
    {
        case map
        case camera
        case album

        func tabBarTitle() -> String
        {
            switch self
            {
                case .map:
                    return "Map"
                case .camera:
                    return "Camera"
                case .album:
                    return "Album"
            }
        }
    }
}
