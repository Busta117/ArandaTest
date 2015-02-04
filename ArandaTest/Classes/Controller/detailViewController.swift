//
//  detailViewController.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class detailViewController: BaseTableViewController {

    var searchResultEntity: SearchResult!
    var serieDetailEntity:SerieDetail?
    var seasonEntity:Season?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDetail()

    }
    
    override func configureAppereance() {
        super.configureAppereance()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = searchResultEntity.name
        
    }
    
    override func registerCells() {
        super.registerCells()
    }

    // MARK: - Class Methods
    
    func loadDetail(){
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
        SerieDetail.getDetail(searchResultEntity.objectId.toInt()!, complete: { (detail:SerieDetail?, error:NSError?) -> () in
            
            if detail != nil{
                self.serieDetailEntity = detail
                if detail!.seasons.count > 0{
                    self.loadSeasonEpisodes(seasonNumber: detail!.seasons[0].seasonNumber)
                }else{
                    SVProgressHUD.dismiss()
                    UIAlertView.showAlert(nil, message: "This serie does not have seasons", cancelButton: "OK")
                }
            }
            
        })
    }
    
    
    func loadSeasonEpisodes(seasonNumber season:Int){
        Season.getDetail(serieId: serieDetailEntity!.objectId.toInt()!, seasonNumber: season) { (seasonEntity:Season?, error:NSError?) -> () in
            SVProgressHUD.dismiss()
            if seasonEntity != nil{
                self.serieDetailEntity?.setSeasonSelected(season)
                self.seasonEntity = seasonEntity
                self.tableView.reloadData()
            }else{
                UIAlertView.showAlert(nil, message: "No season info", cancelButton: "OK")
            }
            
            
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if serieDetailEntity == nil{
            return 0
        }
        
        return 298
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if serieDetailEntity == nil{
            return UIView()
        }
        
        var header:SerieDetailHeaderView = SerieDetailHeaderView.initFromNib()
        header.setDetailEntity(serieDetailEntity!)
        
        header.seasonSelectedAction = {(seasonNumber:Int) -> () in
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
            self.loadSeasonEpisodes(seasonNumber: seasonNumber)
        }
        return header as UIView
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 58
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if serieDetailEntity == nil{
            return 0
        }
        
        if seasonEntity == nil{
            return 0
        }
        
        return seasonEntity!.episodes.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: EpisodeTableViewCell = tableView.dequeueReusableCellWithIdentifier("EpisodeTableViewCell") as EpisodeTableViewCell
        
        var episode:Episode = seasonEntity!.episodes[indexPath.row] as Episode
        cell.setEpisode(episode)
        
        return cell as UITableViewCell
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
