//
//  SearchViewController.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/2/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, SBSearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    var searchBarCustom:SBSearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchResults:Array<SearchResult> = Array<SearchResult>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    func registerCells(){
//        tableView.registerNib(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
    }
    
    
    override func configureAppereance() {
        super.configureAppereance()
        
        navigationController?.navigationBarHidden = true
//        tableView.tableFooterView = UIView()
        
        
        searchBarCustom = SBSearchBar(frame: CGRectMake(5, 25, 310, 50))
        searchBarCustom.delegate = self
        
        searchBarCustom.setTextColor(UIColor.blackColor())
        searchBarCustom.placeHolderColor = UIColor.grayColor()
        searchBarCustom.lensImage = UIImage(named: "ic_lens")
        
        view.addSubview(searchBarCustom)
        
        searchBarCustom.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let viewsDictionary = ["sb":searchBarCustom]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[sb]-5-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-22-[sb(50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary))
        view.layoutIfNeeded()
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("resultCollectionViewCell", forIndexPath: indexPath)
        
        
        return cell as UICollectionViewCell
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
    func SBSearchBarSearchButtonClicked(searchBar: SBSearchBar!) {
        searchBar.resignFirstResponder()
        if !searchBar.text.isEmpty{
            
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
            
            SearchResult.searchWithQuery(searchBar.text, complete: { (results, error) -> () in
                SVProgressHUD.dismiss()
                self.searchResults = results
                self.collectionView.reloadData()
                
            })
            
        }
        
    }
    
    func SBSearchBarCancelButtonClicked(searchBar: SBSearchBar!) {
        searchBar.resignFirstResponder()
    }
    
//    func calculateHeightForConfiguredSizingCell(cell: UITableViewCell) -> CGFloat{
//        cell.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(tableView.bounds), 0.0)
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
//        cell.layoutSubviews()
//        var size: CGSize = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
//        return size.height
//    }
    
}
