//
//  SnapDataRepositoy.swift
//  PhotoMap
//
//  Created by Ivan Chen on 10/18/17.
//

import Foundation
import UIKit

//protocol SnapDataRepositoryDelegate
//{
//    func getSnapData() -> [SnapData]
//    func getSnapData(at index: Int) -> SnapData
//    func removeSnap(snap: SnapData)
//    func saveSnap(snap: Snap)
//}

class SnapDataRepository
{
    private var snapData: [SnapData] = []
    private weak var appDelegate: AppDelegate!
//    let keyPathBeingObserved: String = "snapData"

    init(appDelegate: AppDelegate)
    {
        self.appDelegate = appDelegate
//        addObserver(self, forKeyPath: "snapData", options: .new, context: nil)
    }

//    override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?)
//    {
//        if keyPath == keyPathBeingObserved
//        {
//            do
//            {
//                snapData = try appDelegate.persistentContainer.viewContext.fetch(SnapData.fetchRequest())
//            }
//            catch
//            {
//                print("Fetching Failed")
//            }
//        }
//    }

    func getSnapData() -> [SnapData]
    {
        return snapData
    }

    func getSnapData(at index: Int) -> SnapData
    {
        return snapData[index]
    }

    func removeSnap(snap: SnapData)
    {
        appDelegate.persistentContainer.viewContext.delete(snap)
        appDelegate.saveContext()
    }

    func saveSnap(snap: Snap)
    {
        // TODO: save thumbnail in a different contianer but have relationship with the full res image
        // see: https://stackoverflow.com/questions/27995955/saving-picked-image-to-coredata
        let snapData = SnapData(context: appDelegate.persistentContainer.viewContext)
        guard let imageData = UIImageJPEGRepresentation(snap.image, 1.0) as NSData? else { return }
        snapData.image = imageData
        snapData.latitude = snap.latitude
        snapData.longitude = snap.longitude
        snapData.address = snap.address

        appDelegate.saveContext()

        print("saved snap: (\(snap.latitude), \(snap.longitude)), \(snap.address ?? "nil")")
    }
}
