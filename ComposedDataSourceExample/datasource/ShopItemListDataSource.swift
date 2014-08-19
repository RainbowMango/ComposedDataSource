//
//  ShopItemListDataSource.swift
//  ComposedDataSource
//
//  Created by Miguel Angel Ortuno on 18/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuno. All rights reserved.
//

import UIKit

class ShopItemListDataSource: DataSource {

    struct Constants {
        static let cellIdentifier = "shopItemCellIdentifier"
        static let cellHeight: CGFloat = 75.0
    }
    
    var items: [ShopItem] = []
    
    private let dateFormatter = NSDateFormatter()
    
    /// MARK: Init
    
    override init() {
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
    /// MARK: Public interface
    
    override func heightForRowAtIndexPath(indexPath: NSIndexPath!) -> CGFloat {
        return Constants.cellHeight
    }
    
    override func selectRowAtIndexPath(indexPath: NSIndexPath!) {
        let item = items[indexPath.row]
        let alert = UIAlertView(title: item.name, message: item.details, delegate: nil, cancelButtonTitle: nil)
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    override func titleForHeaderInSection(section: Int) -> String! {
        return "Shop items"
    }
    
    override func titleForFooterInSection(section: Int) -> String! {
        return "Shop items footer title"
    }
    
    /// MARK: UITableViewDataSource
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return countElements(items)
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {

        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIdentifier) as? ShopItemCell
        
        let item = items[indexPath.row]
        
        cell?.name.text = item.name
        cell?.detail.text = item.details
        cell?.dateString.text = dateFormatter.stringFromDate(item.expirationDate)
        
        return cell
    }
}
