//
//  File.swift
//  TEnglish
//
//  Created by ToRing on 8/23/19.
//  Copyright © 2019 toring. All rights reserved.
//

import Foundation
enum DLogTag : String{
    case debug = "💜[DEBUG]"
    case info = "💚[INFO]"
    case warning = "💛[WARNING]"
    case error = "❤️[ERROR]"
}


/// In ra các thông tin. Chỉ thực hiện khi chạy debug
///
/// - Parameters:
///   - tag: Loại phân biệt
///   - logMessage: Nội dung
///   - functionName: function gọi log
///   - line: Dòng câu lệnh log được viết
///   - fileName: File chứa câu lệnh log
///   - column: Kí tự bắt đầu của câu lệnh log
fileprivate func dLog(_ tag: DLogTag, _ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, column: Int = #column) {
    #if RELEASE
    #else
    let tag = tag.rawValue
    let fileName = (fileName as NSString).lastPathComponent
    let logDate = Date().stringForLog()
    let logString = "\(logDate) \(tag) \(logMessage)\n\tAt: [\(fileName)] - [\(functionName)] - [Line \(line)]"
    Swift.print(logString)
    #endif
}

func dLogDebug(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, column: Int = #column) {
    dLog(.debug, logMessage, functionName: functionName, line: line, fileName: fileName, column: column)
}

func dLogInfo(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, column: Int = #column) {
    dLog(.info, logMessage, functionName: functionName, line: line, fileName: fileName, column: column)
}

func dLogWarning(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, column: Int = #column) {
    dLog(.warning, logMessage, functionName: functionName, line: line, fileName: fileName, column: column)
}

func dLogError(_ logMessage: Any, functionName: String = #function, line: Int = #line, fileName: String = #file, column: Int = #column) {
    dLog(.error, logMessage, functionName: functionName, line: line, fileName: fileName, column: column)
}
