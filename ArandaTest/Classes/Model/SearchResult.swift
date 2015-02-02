//
//  SearchResult.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/2/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

enum SearchMediaType :Int{
    case TV = 0
    case Movie
}


class SearchResult: NSObject {
   
    var objectId: String!
    var originalName: String!
    var firtsAirDateString: String!
    var firtsAirDate: NSDate{
        get{
            return NSDate.dateFromString(firtsAirDateString, format: "yyyy-MM-dd")
        }
    }
    var posterPath: String!
    var popularity: Float!
    var name: String!
    var voteAverage: Float!
    var voteCount: Int!
    var mediaType: SearchMediaType!
    
    
    init(dictionary:JSON) {
        super.init()
        self.objectId = dictionary["id"].stringValue
        self.originalName = dictionary["original_name"].stringValue
        self.firtsAirDateString = dictionary["first_air_date"].stringValue
        self.posterPath = dictionary["poster_path"].stringValue
        self.popularity = dictionary["popularity"].floatValue
        self.name = dictionary["name"].stringValue
        self.voteAverage = dictionary["vote_average"].floatValue
        self.voteCount = dictionary["vote_count"].intValue
        if (dictionary["media_type"].stringValue == "tv")
        {
            self.mediaType = .TV
        }else{
            self.mediaType = .Movie
        }
        
    }
    
    
    class func searchWithQuery(query:String, complete:(results:Array<SearchResult>!, error:NSError?)->()){
        
        
        var url:String = ArUrlBase + "search/multi"
        var params:[String:String] = ["api_key":ArAPIKey, "query":query]
        
        
        ARHTTPRequestOperationManager.sharedManager.GET(url, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            
            let json = JSON(responseObject)
            
            var results:Array<SearchResult> = Array<SearchResult>()
            
            for (index: String, subJson: JSON) in json["results"] {
                results.append(SearchResult(dictionary: subJson))
            }
            
            complete(results: results, error: nil)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
            println("sssss")
        }
        
    }
    
    
}
