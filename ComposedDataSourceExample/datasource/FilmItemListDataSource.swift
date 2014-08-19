//
//  FilmItemListDataSource.swift
//  ComposedDataSource
//
//  Created by Miguel Angel Ortuno on 18/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuno. All rights reserved.
//

import UIKit

class FilmItemListDataSource: DataSource {
    
    struct Constants {
        static let cellIdentifier = "filmCellIdentifier"
        static let cellHeight: CGFloat = 60.0
    }
    
    var items: [FilmItem] = []
    
    /// MARK: Public interface
    
    override func heightForRowAtIndexPath(indexPath: NSIndexPath!) -> CGFloat {
        return Constants.cellHeight
    }
    
    override func titleForHeaderInSection(section: Int) -> String! {
        return "Films"
    }
    
    override func selectRowAtIndexPath(indexPath: NSIndexPath!) {
        let film = items[indexPath.row]
        let alert = UIAlertView(title: film.director, message: film.name, delegate: nil, cancelButtonTitle: nil)
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    /// MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return countElements(items)
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdentifier) as? FilmItemCell
        
        let item = items[indexPath.row]
        
        cell?.name.text = item.name
        cell?.director.text = item.director
        cell?.year.text = "\(item.year)"
        
        return cell
    }
}
