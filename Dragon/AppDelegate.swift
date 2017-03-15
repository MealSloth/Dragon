//
//  AppDelegate.swift
//  Dragon
//
//  Created by Michael Fourre on 4/29/16.
//  Copyright © 2016 MealSloth. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, InstanceRetrievable {
    var applicationDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    var window: UIWindow?
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "Dragon", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory?.appendingPathComponent("dragon_v1.sqlite")
        _ = try? coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.managedObjectContext.performAndWait({ () -> Void in
            //When writing to CoreData, existing entries should be merged with priority given to the external model
            self.managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        })
        _ = Model.children //Preload children of Model class
        _ = APIModel.children //Preload children of APIModel class
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    func applicationWillTerminate(_ application: UIApplication) {
        AppDelegate.saveContext()
    }
    
    static func saveContext() {
        try? self.instance?.managedObjectContext.save()
    }
}
