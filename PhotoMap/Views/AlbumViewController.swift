//
//  CollectionViewController.swift
//  PhotoMap
//
//  Created by Ivan Chen on 8/24/17.
//
//

import UIKit
class AlbumViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let reuseIdentifier = "cell"
    fileprivate var images: [UIImage] = []
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
    fileprivate let itemsPerRow: CGFloat = 1

    override func viewDidLoad()
    {
        collectionView.dataSource = self
        collectionView.delegate = self

        guard let meal1 = UIImage(named: "meal1") else
        {
            fatalError("unable to instantiate meal1")
        }
        guard let meal2 = UIImage(named: "meal2") else
        {
            fatalError("unable to instantiate meal2")
        }
        guard let meal3 = UIImage(named: "meal3") else
        {
            fatalError("unable to instantiate meal3")
        }
        for _ in 1...100
        {
            images += [meal1, meal2, meal3]
        }
    }
}

// MARK: - collectionview delegate -
extension AlbumViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return images.count
    }

    // MARK: Collectionview Datasource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath)
            as? AlbumCardCell ?? AlbumCardCell()

        cell.data = (String(indexPath.item + 1), images[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
        -> CGSize
    {
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow

            return CGSize(width: widthPerItem, height: 130)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int)
        -> UIEdgeInsets
    {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int)
        -> CGFloat
    {
        return 5.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
