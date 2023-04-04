//
//  SDKMindboxService.swift
//  OlimpicFind
//
//  Created by Developer on 19.01.2023.
//
import Mindbox
import Foundation

final class SDKMindboxService {
    
    private let endpoint = "T2xpbXBjb20uaW9zLWdhbWVzaXRlc25n"
    private let endpointSandbox = "T2xpbXBjb20uaW9zLWdhbWVzaXRlc25nLXN1bmRib3g="
    private let domain = "api.mindbox.cloud"
    
    func setup(){
        do {
            let mindboxSdkConfig = try MBConfiguration(
                endpoint: self.endpoint.fromBase64() ?? "",
                domain: self.domain,
                subscribeCustomerIfCreated: true,
                shouldCreateCustomer: true
            )
            self.inition(with: mindboxSdkConfig)
        } catch let error {
            print(error.localizedDescription, "mindboxSdkConfig error")
        }
    }
    
    private func inition(with mindboxSdkConfig: MBConfiguration){
        Mindbox.shared.initialization(configuration: mindboxSdkConfig)
        Mindbox.shared.getDeviceUUID { deviceUUID in
            print(deviceUUID)
        }
    }
}
