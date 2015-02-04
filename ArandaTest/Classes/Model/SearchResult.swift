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
    var page:Int!
    var totalPages:Int!
    
    
    init(dictionary:JSON) {
        super.init()
        
        self.objectId = dictionary["id"].stringValue
        self.voteAverage = dictionary["vote_average"].floatValue
        self.popularity = dictionary["popularity"].floatValue
        self.posterPath = dictionary["poster_path"].stringValue
        self.voteCount = dictionary["vote_count"].intValue
        
        if (dictionary["media_type"].stringValue == "tv")
        {
            self.mediaType = .TV
        }else{
            self.mediaType = .Movie
        }
        
        if self.mediaType == .TV {
            self.originalName = dictionary["original_name"].stringValue
            self.firtsAirDateString = dictionary["first_air_date"].stringValue
            self.name = dictionary["name"].stringValue
        }else{
            self.originalName = dictionary["original_title"].stringValue
            self.firtsAirDateString = dictionary["release_date"].stringValue
            self.name = dictionary["title"].stringValue

        }
        
    }
    
    
    class func searchWithQuery(query:String, page:Int, complete:(results:Array<SearchResult>?, error:NSError?)->()){
        
        
        var url:String = ArUrlBase + "search/multi"
        var params:[String:String] = ["api_key":ArAPIKey, "query":query, "page":String(page)]
        
        
        ARHTTPRequestOperationManager.sharedManager.GET(url, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            
            let json = JSON(responseObject)
            
            var results:Array<SearchResult> = Array<SearchResult>()
            
            for (index: String, subJson: JSON) in json["results"] {
                var obj:SearchResult = SearchResult(dictionary: subJson)
                obj.page = json["page"].intValue
                obj.totalPages = json["total_pages"].intValue
                results.append(obj)
            }
            
            complete(results: results, error: nil)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
            complete(results: nil, error: error)
        }
        
    }
    
    
}
