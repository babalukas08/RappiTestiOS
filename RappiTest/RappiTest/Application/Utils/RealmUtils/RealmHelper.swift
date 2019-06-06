//
//  RealmHelper.swift
//  PueblosMagicosMex
//
//  Created by Hugo Mauricio Jimenez Elizondo on 28/03/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    //creates realm with a given name
    static func getRealmNamed(_ realmName: String) throws -> Realm {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        //let realmPath = NSURL.fileURLWithPath(config.path!)
        let realmPath = config.fileURL!
            .deletingLastPathComponent().appendingPathComponent("\(realmName).realm")
        //.path
        
        // create realm for the first time in this thread
        // so cannot use try!
        let newRealm = try Realm(fileURL: realmPath)
        
        return newRealm
    }
    
    //delete realm file
    static func removeRealm(_ pathName: String) {
        let fileManager:FileManager = FileManager.default
        
        _ = try? fileManager.removeItem(atPath: pathName)
    }
}
