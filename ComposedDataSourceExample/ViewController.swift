//
//  ViewController.swift
//  ComposedDataSource
//
//  Created by Miguel Angel Ortuno on 18/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuno. All rights reserved.
//

import UIKit

var maxDataSourceCount = 5

class ViewController: UITableViewController {
    
    /// MARK: Private
    
    private let dateFormatter = NSDateFormatter()
    
    private var currentPage: Int = 1
    
    private let shopItemsDataSource = ShopItemListDataSource()
    private let filmsItemsDataSource = FilmItemListDataSource()
    
    private let composedDataSource1 = ComposedDataSource()
    private let composedDataSource2 = ComposedDataSource()
    private let composedDataSource3 = ComposedDataSource()
    
    /// MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        setupModel()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Bordered, target: self, action: "back:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Bordered, target: self, action: "next:")
        
        self.navigationItem.leftBarButtonItem?.enabled = false
        
        setupDataSource()
    }
    
    /// MARK: Actions
    
    func back(sender: UIBarButtonItem!) {

        if currentPage > 1 {
            currentPage--
            setupDataSource()
            
            self.navigationItem.rightBarButtonItem?.enabled = true
            
            if currentPage == 1 {
                self.navigationItem.leftBarButtonItem?.enabled = false
            }
        }
    }
    
    func next(sender: UIBarButtonItem!) {
        
        if currentPage < maxDataSourceCount {
            currentPage++
            setupDataSource()
            
            self.navigationItem.leftBarButtonItem?.enabled = true
            
            if currentPage == maxDataSourceCount {
                self.navigationItem.rightBarButtonItem?.enabled = false
            }
        }
    }
    
    /// MARK: UITableView delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch( currentPage ) {
        case 1:
            return shopItemsDataSource.heightForRowAtIndexPath(indexPath)
        case 2:
            return filmsItemsDataSource.heightForRowAtIndexPath(indexPath)
        case 3:
            return composedDataSource1.heightForRowAtIndexPath(indexPath)
        case 4:
            return composedDataSource2.heightForRowAtIndexPath(indexPath)
        case 5:
            return composedDataSource3.heightForRowAtIndexPath(indexPath)
        default:
            break
        }
        return 0.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch( currentPage ) {
        case 1:
            shopItemsDataSource.selectRowAtIndexPath(indexPath)
        case 2:
            filmsItemsDataSource.selectRowAtIndexPath(indexPath)
        case 3:
            composedDataSource1.selectRowAtIndexPath(indexPath)
        case 4:
            composedDataSource2.selectRowAtIndexPath(indexPath)
        case 5:
            composedDataSource3.selectRowAtIndexPath(indexPath)
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /// MARK: Convenience
    
    func setupModel() {
        
        // Shop items
        let shopItem1 = ShopItem()
        
        shopItem1.name = "Donuts"
        shopItem1.details = "Tasty food"
        shopItem1.expirationDate = dateFormatter.dateFromString("20/12/2014")
        shopItem1.price = 5.75
        
        let shopItem2 = ShopItem()
        
        shopItem2.name = "Lemon Yogurt"
        shopItem2.details = "King's deserve"
        shopItem2.expirationDate = dateFormatter.dateFromString("02/02/2015")
        shopItem2.price = 3.75
        
        shopItemsDataSource.items = [shopItem1, shopItem2]
        
        // Films
        let film1 = FilmItem()
        film1.name = "Eyes Wide Shut"
        film1.director = "Stanley Kubrick"
        film1.year = 2000
        
        let film2 = FilmItem()
        film2.name = "Abyss"
        film2.director = "James Francis Cameron"
        film2.year = 1989
        
        let film3 = FilmItem()
        film3.name = "The Fountain"
        film3.director = "Darren Aronofsky"
        film3.year = 2006
        
        filmsItemsDataSource.items = [film1, film2, film3]
    }
    
    func setupDataSource() {
        
        let dataSourceTitle = "DataSource"
        let composedDataSourceTitle = "ComposedDataSource"
        
        var title: String!
        
        switch( currentPage ) {
        case 1:
            title = dataSourceTitle
            self.tableView.dataSource = shopItemsDataSource
        case 2:
            title = dataSourceTitle
            self.tableView.dataSource = filmsItemsDataSource
            
        case 3:
            title = composedDataSourceTitle
            composedDataSource1.dataSources = [shopItemsDataSource, filmsItemsDataSource]
            self.tableView.dataSource = composedDataSource1
            
        case 4:
            title = composedDataSourceTitle
            composedDataSource2.dataSources = [filmsItemsDataSource, composedDataSource1]
            self.tableView.dataSource = composedDataSource2
            
        case 5: // a complex composed data source
            title = composedDataSourceTitle
            composedDataSource3.dataSources = [composedDataSource1, filmsItemsDataSource, composedDataSource2]
            self.tableView.dataSource = composedDataSource3
            
        default:
            break
        }
        
        self.navigationItem.title = "\(title) \(currentPage)/\(maxDataSourceCount)"
        
        self.tableView.reloadData()
    }
}
