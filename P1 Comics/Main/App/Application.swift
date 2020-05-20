//
//  Application.swift
//  P1 Comics
//
//  Created by HoaPQ on 5/20/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import UIKit

class Application {
    static let shared: Application = Application()
    
    private init() {
        
    }
    
    func initApplication(with window: UIWindow?) {
        guard let window = window else { return }
        window.makeKeyAndVisible()
        window.rootViewController = ViewController()
    }
}
