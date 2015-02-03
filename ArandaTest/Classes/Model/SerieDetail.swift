//
//  SerieDetail.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class SerieDetail: NSObject {
   
    
    var objectId: String!
    var genres:Array<String>!
    var firtsAirDateString: String!
    var name: String!
    var numberOfSeasons:Int!
    var numberOfEpisodes: Int!
    var popularity: Float!
    var voteAverage: Float!
    var posterPath: String!
    var backdropPath: String!
    var seasons:Array<SeasonSample>!

    
    init(dictionary:JSON) {
        super.init()
        
        self.objectId = dictionary["id"].stringValue
        self.backdropPath = dictionary["backdrop_path"].stringValue
        self.firtsAirDateString = dictionary["first_air_date"].stringValue
        
        self.genres = Array<String>()
        for (index: String, subJson: JSON) in dictionary["genres"] {
            self.genres.append(subJson["name"].stringValue)
        }
        
        self.numberOfSeasons = dictionary["number_of_seasons"].intValue
        self.numberOfEpisodes = dictionary["number_of_episodes"].intValue
        self.popularity = dictionary["popularity"].floatValue
        self.voteAverage = dictionary["vote_average"].floatValue
        
        self.seasons = Array<SeasonSample>()
        for (index: String, subJson: JSON) in dictionary["seasons"] {
            self.seasons.append(SeasonSample(dictionary: subJson))
        }
        
        self.posterPath = dictionary["poster_path"].stringValue
        
    }
    
    func setSeasonSelected(seasonNumber:Int){
        for season:SeasonSample in seasons{
            season.selected = false
            if season.seasonNumber == seasonNumber {
                season.selected = true
            }
        }
    }
    
    class func getDetail(serieId:Int, complete:(detail:SerieDetail?, error:NSError?)->()){
    
        var url:String = ArUrlBase + "tv/" + String(serieId)
        var params:[String:String] = ["api_key":ArAPIKey]
        
        
        ARHTTPRequestOperationManager.sharedManager.GET(url, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
            
            let json:JSON = JSON(responseObject)

            complete(detail: SerieDetail(dictionary: json), error: nil)
            
            }) { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                complete(detail: nil, error: error)
        }
        
    }
    
    
    
}
