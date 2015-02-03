//
//  Season.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class Season: NSObject {
   
    var airDateString:String!
    var objectId:String!
    var name:String!
    var seasonNumber:Int!
    
    var episodes:Array<Episode>!
    
    init(dictionary:JSON) {
        super.init()
        
        self.airDateString = dictionary["air_date"].stringValue
        self.name = dictionary["name"].stringValue
        self.objectId = dictionary["id"].stringValue
        self.seasonNumber = dictionary["season_number"].intValue
        
        episodes = Array<Episode>()
        for (index: String, subJson: JSON) in dictionary["episodes"] {
            episodes.append(Episode(dictionary: subJson))
        }
        
    }
    
    
    class func getDetail(serieId serie:Int, seasonNumber season:Int, complete:(season:Season?, error:NSError?)->()){
        
        var url:String = ArUrlBase + "tv/" + String(serie) + "/season/" + String(season)
        var params:[String:String] = ["api_key":ArAPIKey]
        
        
        ARHTTPRequestOperationManager.sharedManager.GET(url, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            
            let json:JSON = JSON(responseObject)
            
            complete(season: Season(dictionary: json), error: nil)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                complete(season: nil, error: error)
        }
        
    }
    
    
}
