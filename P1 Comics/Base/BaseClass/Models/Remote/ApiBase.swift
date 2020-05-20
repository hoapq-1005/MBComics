//
//  ApiBase.swift
//  TEnglish
//
//  Created by ToRing on 8/15/19.
//  Copyright © 2019 toring. All rights reserved.
//
import Foundation
import SwiftyJSON

/*
 How to use:
 1. Config:
         let config = ApiConfig().baseUrl("https://stackoverflow.com").timeout(10)
         ApiBase.config(config)
 2. Can call 2 request funtion
 */

class ApiBase {
    private static var timeout: TimeInterval = 10
    private static var baseUrl: String = ""
    
    static let shared: ApiBase = ApiBase()
    
    static func config(_ config: ApiConfig) {
        baseUrl = config.baseUrl
        timeout = config.timeout
    }

    // Create request, call and response (code, data)
    private func baseRequest(baseUrl: String,
                 urlString: String? = nil,
                 httpMethod: HTTPMethod,
                 header: [String: String]?,
                 param: [String: Any]?,
                 body: [String: Any]?,
                 completion: DataCompletion?) {
        // Create url
        var url: URLComponents
        if let urlString = urlString {
            url = URLComponents(string: "\(baseUrl)/\(urlString)")!
        } else {
            url = URLComponents(string: "\(baseUrl)")!
        }

        // Set query
        var queryItems = [URLQueryItem]()
        if let param = param {
            for paramItem in param {
                let value = String(describing: paramItem.value)
                let urlQueryItem = URLQueryItem(name: paramItem.key, value: value)
                queryItems.append(urlQueryItem)
            }
        }
        url.queryItems = queryItems

        // Create request & set header
        let request = NSMutableURLRequest(url: url.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: ApiBase.timeout)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = header

        // Set body
        do {
            if let body = body {
                let bodyData = try JSONSerialization.data(withJSONObject: body, options: [])
                request.httpBody = bodyData
            }
        } catch {
            dLogError("JSONSerialization.data exception \(error.localizedDescription)")
        }

        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            let httpUrlResponse = response as? HTTPURLResponse
            let statusCode = httpUrlResponse?.statusCode
            dLogDebug("BASE API STATUS: \(String(describing: httpUrlResponse?.url?.absoluteString)) ---> \(String(describing: statusCode))")
            if error == nil {
                completion?(statusCode, data)
            } else {
                completion?(nil, nil)
            }
        }
        task.resume()
    }
    
    // Create request, call and response (code, JSON-SwiftyJSON)
    func request(baseUrl: String = baseUrl,
                 urlString: String? = nil,
                 httpMethod: HTTPMethod,
                 header: [String: String]? = nil,
                 param: [String: Any]? = nil,
                 body: [String: Any]? = nil,
                 completion: JSONCompletion?) {
        baseRequest(baseUrl: baseUrl,
                    urlString: urlString,
                    httpMethod: httpMethod,
                    header: header,
                    param: param,
                    body: body) { (code, data) in
            if let data = data {
                let json = JSON(data)
                dLogDebug("API STATUS: \(baseUrl) ---> CODE = \(code ?? 0) RESPONSE = \(json)")
                completion?(code, json)
            } else {
                dLogDebug("API STATUS: \(baseUrl) ---> CODE = \(code ?? 0) --- RESPONSE = nil")
                completion?(code, nil)
            }
        }
    }
    
    // Create request, call and response (status, code, JSON-SwiftyJSON)
    func request(urlString: String? = nil,
                 httpMethod: HTTPMethod,
                 header: [String: String]? = nil,
                 param: [String: Any]? = nil,
                 body: [String: Any]? = nil,
                 completion: Completion?) {
        request(urlString: urlString,
                httpMethod: httpMethod,
                header: header,
                param: param,
                body: body) { (code, json) in
                    if let code = code, let json = json {
                        if 200 ... 299 ~= code {
                            completion?(true, code, json)
                        } else {
                            completion?(false, code, json)
                        }
                    } else {
                        completion?(false, nil, nil)
                    }
        }
    }
    
    // create request for web view
    func request(baseUrl: String = baseUrl,
                 urlString: String? = nil,
                 httpMethod: HTTPMethod,
                 header: [String: String]? = nil,
                 param: [String: Any]? = nil,
                 body: [String: Any]? = nil,
                 completion: HTMLStringCompletion?) {
        baseRequest(baseUrl: baseUrl,
                    urlString: urlString,
                    httpMethod: httpMethod,
                    header: header,
                    param: param,
                    body: body) { (code, data) in
                        if let data = data {
                            guard let contents = String(data: data, encoding: .utf8) else {
                                completion?(nil)
                                return
                            }
                            completion?(contents)
                        } else {
                            completion?(nil)
                        }
        }
    }
}
