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
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 20.0, right: 0.0)
    fileprivate let itemsPerRow: CGFloat = 1
    // TODO: have a model that control this data? Do I do it with MVP? How is it going to work?
    fileprivate var snapData: [SnapData] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        snapData = AppDelegate.updateSnapData()

        collectionView.reloadData()
    }

    @objc
    fileprivate func deleteCell(sender: UISwipeGestureRecognizer)
    {
        let cell = sender.view as? UICollectionViewCell ?? UICollectionViewCell()
        let snap = snapData[collectionView.indexPath(for: cell)!.row]
        snapData = AppDelegate.removeSnap(snap: snap)
        collectionView.reloadData()
    }

    @objc
    fileprivate func refresh(sender: UIRefreshControl)
    {
        snapData = AppDelegate.updateSnapData()
        collectionView.reloadData()
        sender.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource
extension AlbumViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return snapData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AlbumCardCell ?? AlbumCardCell()
        let snap = snapData[snapData.count - indexPath.item - 1]
        let imageAsData = snap.image as Data? ?? Data()
        cell.cardData = (snap.address, UIImage(data: imageAsData, scale: 1.0)) as? (label: String, image: UIImage)

        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteCell))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.right
        cell.addGestureRecognizer(swipeGesture)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension AlbumViewController: UICollectionViewDelegateFlowLayout
{

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
}

// MARK: - UICollectionViewDelegate
extension AlbumViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
