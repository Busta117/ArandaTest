//
//  EpisodeTableViewCell.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var extraInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func setEpisode(episode:Episode){
        titleLabel.text = String(episode.episodeNumber) + ". " + episode.name
        extraInfoLabel.text = "☆ " + String(format:"%.1f",episode.voteAverage)
    }
    
    
}

