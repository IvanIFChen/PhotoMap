//
//  SnapDataRepositoy.swift
//  PhotoMap
//
//  Created by Ivan Chen on 10/18/17.
//

import Foundation
import UIKit

class SnapDataRepository
{
    private var snapData: [SnapData] = []
    private weak var appDelegate: AppDelegate!

    init(appDelegate: AppDelegate)
    {
        self.appDelegate = appDelegate
        reloadData()
    }

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

        reloadData()
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

        reloadData()
    }

    private func reloadData()
    {
        do
        {
            snapData = try appDelegate.persistentContainer.viewContext.fetch(SnapData.fetchRequest())
        }
        catch
        {
            print("Fetching Fialed")
        }
    }
}
