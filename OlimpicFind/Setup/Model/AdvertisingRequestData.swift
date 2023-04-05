//
//  AdvertisingRequestData.swift
//  OlimpicFind
//
//  Created by Senior Developer on 04.04.2023.
//
import FirestoreFirebase
import Foundation
import AdvertisingBanner

struct AdvertisingRequestData: RequestData {
    
    typealias ReturnDecodable = RequestDataModel
    
    var collectionID: String = "advertisingForOlimlicCards"
    var documentID: String? = "configuration"
}
