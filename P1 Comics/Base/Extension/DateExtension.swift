//
//  DateExtension.swift
//  FiinClone
//
//  Created by ToRing on 10/30/19.
//  Copyright © 2019 FiinClone. All rights reserved.
//

import Foundation

extension Date {
    func stringForLog() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return df.string(from: self)
    }
}
