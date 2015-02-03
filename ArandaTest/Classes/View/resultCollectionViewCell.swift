//
//  resultCollectionViewCell.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/3/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class resultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func setResult(resultEntity:SearchResult){
        coverImageView.setImageWithURL(NSURL(string: ArImageUrlBase + resultEntity.posterPath))
        titleLabel.text = resultEntity.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = UIImage()
        titleLabel.text = ""
    }
    
    
}
