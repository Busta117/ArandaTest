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
    
    var resultSelected: SearchResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    func registerCells(){
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        
        var cell: resultCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("resultCollectionViewCell", forIndexPath: indexPath) as resultCollectionViewCell
        
        
        var entity: SearchResult = searchResults[indexPath.row] as SearchResult
        
        cell.setResult(entity)
        
        return cell as UICollectionViewCell
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var entity: SearchResult = searchResults[indexPath.row] as SearchResult
        
        if entity.mediaType == SearchMediaType.Movie {
            UIAlertView.showAlert("Demo", message: "Demo is not available to movies", cancelButton: "OK")
            return
        }
        
        resultSelected = entity
        performSegueWithIdentifier("resultDetailSegue", sender: nil)
        
    }
    
    func SBSearchBarSearchButtonClicked(searchBar: SBSearchBar!) {
        searchBar.resignFirstResponder()
        if !searchBar.text.isEmpty{
            
            SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
            
            SearchResult.searchWithQuery(searchBar.text, complete: { (results, error) -> () in
                SVProgressHUD.dismiss()
                
                if error == nil {
                    self.searchResults = results!
                    self.collectionView.reloadData()
                }
                
            })
            
        }
        
    }
    
    func SBSearchBarCancelButtonClicked(searchBar: SBSearchBar!) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if (segue.identifier == "resultDetailSegue"){
            var detailController: detailViewController = segue.destinationViewController as detailViewController
            detailController.searchResultEntity = resultSelected
            
        }
        
    }
    
}
