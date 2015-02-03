//
//  SeasonSample.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class SeasonSample: NSObject {
   
    var airDateString:String!
    var episodeCount:Int!
    var objectId:String!
    var seasonNumber:Int!
    var selected:Bool = false
    
    
    init(dictionary:JSON) {
        super.init()
        
        self.airDateString = dictionary["air_date"].stringValue
        self.episodeCount = dictionary["episode_count"].intValue
        self.objectId = dictionary["id"].stringValue
        self.seasonNumber = dictionary["season_number"].intValue
        
    }
    
}
