//
//  SerieDetailHeaderView.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class SerieDetailHeaderView: UIView {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var seasonSelectedAction: ((seasonNumber:Int) -> ())!
    
    class func initFromNib() -> SerieDetailHeaderView{
        var nibFile = UINib(nibName: "SerieDetailHeaderView", bundle: nil)
        var header: SerieDetailHeaderView = nibFile.instantiateWithOwner(self, options: nil).first as SerieDetailHeaderView
        return header
    }
    
    func setDetailEntity(entity:SerieDetail){
        
        if entity.backdropPath.isEmpty{
            coverImageView.setImageWithURL(NSURL(string: ArImageUrlBase + entity.posterPath))
        }else{
            coverImageView.setImageWithURL(NSURL(string: ArImageUrlBase + entity.backdropPath))
        }
        
    
        genreLabel.text = ""
        for genre:String in entity.genres{
            genreLabel.text = genre + ", " + genreLabel.text!
        }
        
        raitingLabel.text = "☆ " + String(format:"%.2f",entity.voteAverage) + " | " + entity.firtsAirDateString
        
        
        var xVal:CGFloat = 0
        for season:SeasonSample in entity.seasons{
            var but: UIButton = UIButton(frame: CGRectMake(xVal, 0, 45, 45))
            xVal += 50
            but.setTitle(String(season.seasonNumber), forState: UIControlState.Normal)
            but.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            but.setBackgroundImage(UIImage(named: "cover-deg"), forState: UIControlState.Normal)
            
            if season.selected {
                but.setBackgroundImage(UIImage(named: "cover-selected"), forState: UIControlState.Normal)
            }
            
            but.addTarget(self, action: "seasonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
            but.layer.masksToBounds = true
            but.layer.cornerRadius = CGRectGetWidth(but.frame)/2
            
            scrollView.addSubview(but)
            
        }
        
        scrollView.contentSize = CGSizeMake(xVal-5, CGRectGetHeight(scrollView.frame))
        
    }
    
    
    
    func seasonAction(sender:UIButton){
        
        seasonSelectedAction(seasonNumber: ((sender.titleLabel?.text?) as String!).toInt()!)
        
    }
    
    
}
