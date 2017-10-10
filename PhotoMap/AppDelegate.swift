//
//  AppDelegate.swift
//  PhotoMap
//
//  Created by Ivan Chen on 8/17/17.
//
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        return true
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer =
    {
        let container = NSPersistentContainer(name: "SnapsContainer")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - CoreDataHelper
extension AppDelegate
{
    static func updateSnapData() -> [SnapData]
    {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate
        {
            do {
                return try appDelegate.persistentContainer.viewContext.fetch(SnapData.fetchRequest())
            }
            catch
            {
                print("Fetching Failed")
            }
        }
        return []
    }

    static func removeSnap(snap: SnapData) -> [SnapData]
    {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        {
            context.delete(snap)
            return updateSnapData()
        }
        return []
    }
}
