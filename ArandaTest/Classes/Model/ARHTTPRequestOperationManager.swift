//
//  ARHTTPRequestOperationManager.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/2/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

let ArAPIKey: String = "b366d43320fbebf8a2ad591a4189081a"
let ArImageUrlBase: String = "http://image.tmdb.org/t/p/w500"
let ArUrlBase: String = "https://api.themoviedb.org/3/"


class ARHTTPRequestOperationManager: AFHTTPRequestOperationManager {
   
    class var sharedManager:ARHTTPRequestOperationManager {
        struct Static {
            static let instance:ARHTTPRequestOperationManager = ARHTTPRequestOperationManager()
        }
        return Static.instance
    }
    
}
