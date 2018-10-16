//
//  SaveOptions.swift
//  edl21-control
//
//  Created by Marius Montebaur on 13.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import Foundation


func loadOption (key: String) -> AnyObject? {
    let userDefaults = UserDefaults.standard
    guard let v = userDefaults.value(forKey: key) else {
        return nil
    }
    return v as AnyObject
}


func saveOption (key: String, value: AnyObject) {
    let userDefaults = UserDefaults.standard
    userDefaults.setValue(value, forKey: key)
    userDefaults.synchronize()
}

func removeObject (key: String) {
    let userDefaults = UserDefaults.standard
    userDefaults.removeObject(forKey: key)
}
