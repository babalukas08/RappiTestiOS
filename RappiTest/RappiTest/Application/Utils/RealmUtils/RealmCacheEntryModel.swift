//
//  RealmCacheEntryModel.swift
//  PueblosMagicosMex
//
//  Created by Hugo Mauricio Jimenez Elizondo on 28/03/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import RealmSwift

class RealmCacheEntryModel : Object {
    
    @objc dynamic var key: String = ""
    @objc dynamic var value: String = ""
    @objc dynamic var date: Date = Date()
    
    convenience init(key: String, value: String) {
        self.init()
        self.key = key
        self.value = value
    }
    
    override static func primaryKey() -> String? {
        return "key"
    }
    
}
