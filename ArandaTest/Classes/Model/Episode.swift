//
//  Episode.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class Episode: NSObject {
   
    var episodeNumber:Int!
    var name:String!
    var objectId:String!
    var voteAverage:Float!
    
    
    init(dictionary:JSON) {
        super.init()
        
        self.episodeNumber = dictionary["episode_number"].intValue
        self.name = dictionary["name"].stringValue
        self.objectId = dictionary["id"].stringValue
        self.voteAverage = dictionary["vote_average"].floatValue
        
    }

    
}
