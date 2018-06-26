//
//  PostsViewController.swift
//  reddit
//
//  Created by Dawkins, Angela on 6/25/18.
//  Copyright © 2018 Dawkins, Angela. All rights reserved.
//

import UIKit

class PostsViewController: UITableViewController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchBar()

    }
    //MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive == true {
            return searchResults.count
        } else {
            return model.featuredPosters.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath)
        
        if searchController.isActive == true {
            cell.textLabel?.text = searchResults[indexPath.row]["title"] as? String
        } else {
            cell.textLabel?.text = model.featuredPosters[indexPath.row]["title"]
        }
        return cell
    }
    //MARK - Search Controller
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults = [AnyObject]()
    
    //MARK: UISearchResults Protocol
    func loadSearchBar(){
        searchController.searchResultsUpdater = self
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = false
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    func updateSearchResults(for searchController: UISearchController){
        //Get data as array
        //filter data
        //return search results
        let predicate = NSPredicate(format: "title contains[cd] %@", searchController.searchBar.text!)

        let filteredResults = (model.featuredPosters as NSArray).filtered(using: predicate)
        
        searchResults = filteredResults as [AnyObject]
        tableView.reloadData()
        
        //print(filteredResults)
        //print("Number of results: \(filteredResults.count)")
        
    }

}
