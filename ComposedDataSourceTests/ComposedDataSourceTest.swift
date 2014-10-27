//
//  ComposedDataSourceTest.swift
//  ComposedDataSource
//
//  Created by Miguel Angel Ortuno on 19/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuno. All rights reserved.
//

import UIKit
import XCTest

class ShopItemListDataSourceTest: ShopItemListDataSource {
    
    var selected = false
    override func selectRowAtIndexPath(indexPath: NSIndexPath) {
        selected = true
    }
}

class FilmItemListDataSourceTest: FilmItemListDataSource {
    var selected = false
    override func selectRowAtIndexPath(indexPath: NSIndexPath) {
        selected = true
    }
}

class ComposedDataSourceTest: XCTestCase {

    private var dateFormatter = NSDateFormatter()
    
    private let shopItemsDataSource = ShopItemListDataSourceTest()
    private let filmsItemsDataSource = FilmItemListDataSourceTest()
    
    private let composedDataSource1 = ComposedDataSource()
    private let composedDataSource2 = ComposedDataSource()
    private let composedDataSource3 = ComposedDataSource()
    
    override func setUp() {
        super.setUp()
        self.setupModel()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
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
        
        composedDataSource1.dataSources = [shopItemsDataSource, filmsItemsDataSource]
        composedDataSource2.dataSources = [filmsItemsDataSource, composedDataSource1]
        composedDataSource3.dataSources = [composedDataSource1, filmsItemsDataSource, composedDataSource2]
        
        // build up internal indexes
        let tableView = UITableView()
        
        composedDataSource1.numberOfSectionsInTableView(tableView)
        composedDataSource2.numberOfSectionsInTableView(tableView)
        composedDataSource3.numberOfSectionsInTableView(tableView)
    }

    func testNumberOfSections() {
        let tableView = UITableView()
        let numberOfSections = composedDataSource3.numberOfSectionsInTableView(tableView)
        XCTAssertEqual(numberOfSections, 6, "Expected number of sections 6 not \(numberOfSections)")
    }
    
    func testHeaderTitle() {
        let headerTitle = composedDataSource3.titleForHeaderInSection(2)
        XCTAssertEqual(headerTitle!, "Films", "Not expected header title value")
    }
    
    func testFooterTitle() {
        let footerTitle = composedDataSource3.titleForFooterInSection(4)
        XCTAssertEqual(footerTitle!, "Shop items footer title", "Not expected footer title value")
    }
    
    func testShopItemHeightOfRow() {
        let rowHeight = composedDataSource3.heightForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 4))
        XCTAssertEqual(Float(rowHeight), Float(75.0), "Not expected row height value")
    }
    
    func testFilmItemHeightOfRow() {
        let rowHeight = composedDataSource3.heightForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 3))
        XCTAssertEqual(Float(rowHeight), Float(60.0), "Not expected row height value")
    }
    
    func testShopItemSelect() {
        composedDataSource3.selectRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 4))
        XCTAssertTrue(shopItemsDataSource.selected, "Not expected selected value")
    }
    
    func testFilmItemSelect() {
        composedDataSource3.selectRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 3))
        XCTAssertTrue(filmsItemsDataSource.selected, "Not expected selected value")
    }
}
