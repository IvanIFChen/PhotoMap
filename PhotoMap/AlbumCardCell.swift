//
//  AlbumCardCell
//  PhotoMap
//
//  Created by Ivan Chen on 9/14/17.
//

import UIKit

class AlbumCardCell: UICollectionViewCell
{
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var cardLabel: UILabel!

    var cardData: (label: String, image: UIImage)?
    {
        didSet
        {
            cardLabel.text = cardData?.label
            cardImage.image = cardData?.image
        }
    }
}
