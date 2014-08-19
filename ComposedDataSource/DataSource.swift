//
//  DataSource.swift
//  ComposedDataSource
//
//  Created by Miguel Angel Ortuno on 01/07/14.
//  Copyright (c) 2014 Miguel Angel Ortuno Ortuno. All rights reserved.
//

import UIKit

class DataSource: NSObject, UITableViewDataSource {
    
    /// MARK: Public interface
    
    var shouldDisplayDefaultTitles = true
    
    func titleForHeaderInSection(section: Int) -> String! {
        return nil
    }
    
    func titleForFooterInSection(section: Int) -> String! {
        return nil
    }
    
    func heightForRowAtIndexPath(indexPath: NSIndexPath!) -> CGFloat {
        return 0.0
    }
    
    func selectRowAtIndexPath(indexPath: NSIndexPath!) {
    }
    
    /// MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        return nil
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        if shouldDisplayDefaultTitles {
            return self.titleForHeaderInSection(section)
        }
        return nil
    }
    
    func tableView(tableView: UITableView!, titleForFooterInSection section: Int) -> String! {
        if shouldDisplayDefaultTitles {
            return self.titleForFooterInSection(section)
        }
        return nil
    }
}
