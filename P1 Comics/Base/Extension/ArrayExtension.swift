//
//  AppDelegate.swift
//  TEnglish
//
//  Created by HoaPQ on 4/14/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func removeObject(_ object : Element) {
        if let index = self.firstIndex(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjects(_ objects: [Element]) {
        for obj in objects {
            if let index = self.firstIndex(of: obj) {
                self.remove(at: index)
            }
        }
    }
}
