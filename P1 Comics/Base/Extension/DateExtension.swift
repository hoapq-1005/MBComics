//
//  DateExtension.swift
//
//  Created by HoaPQ on 10/30/19.
//

import Foundation

extension Date {
    func stringForLog() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSS"
        return df.string(from: self)
    }
}
