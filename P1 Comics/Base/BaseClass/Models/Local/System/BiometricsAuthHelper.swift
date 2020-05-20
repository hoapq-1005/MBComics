//
//  TouchFaceIdAuth.swift
//  FiinClone
//
//  Created by ToRing on 10/10/19.
//  Copyright © 2019 FiinClone. All rights reserved.
//

import Foundation
import LocalAuthentication

enum BiometricsType {
    case touchId
    case faceId
}

indirect enum BiometricsAuthType {
    case none(Error?)
    case supported(BiometricsType)
}

class BiometricsAuthHelper {
    static let shared = BiometricsAuthHelper()

    func authWithBiometrics(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        
        let biometricsAuthType:BiometricsAuthType = canAuthWithBiometrics()
        switch biometricsAuthType {
        case .supported(let biometricsType):
            var reason = ""
            if biometricsType == .touchId {
                reason = "Touch ID"
            } else {
                reason = "Face ID"
            }
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                completion(success, authenticationError)
            }
        case .none(let error):
            completion(false, error)
        }
    }
    
    func canAuthWithBiometrics() -> BiometricsAuthType {
        let context = LAContext()
        var error: NSError?
        var biometricsAuthType: BiometricsAuthType = .none(error)

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if #available(iOS 11.0, *) {
                switch context.biometryType {
                case .none:
                    biometricsAuthType = .none(error)
                case .touchID:
                    biometricsAuthType = .supported(.touchId)
                case .faceID:
                    biometricsAuthType = .supported(.faceId)
                @unknown default:
                    biometricsAuthType = .none(error)
                }
            } else {
                // Fallback on earlier versions
                biometricsAuthType = .supported(.touchId)
            }
        } else {
            biometricsAuthType = .none(error)
        }
        return biometricsAuthType
    }
}
