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
    
    var collectionID: String = "advertising"
    var documentID  : String? = "configuration"
    var data        : RequestDataModel? = nil
}
