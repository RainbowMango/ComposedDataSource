//
//  ComposedDataSource.swift
//  ComposedDataSource
//
//  Created by Miguel Angel Ortuno on 01/07/14.
//  Copyright (c) 2014 Miguel Angel Ortuno Ortuno. All rights reserved.
//

import UIKit

class ComposedDataSource: DataSource {

    /// MARK: Private
        
    // <GlobalSection, (DataSource, LocalSection)
        
    private var dataSourceIndex: Dictionary<Int, (DataSource, Int)> = [:]
    
    /// MARK: Types
    
    var dataSources: [DataSource] = []
    
    /// MARK: Init/deinit

    override init () {
        super.init()
    }
    
    convenience init(dataSources: [DataSource]) {
        self.init()
        self.dataSources = dataSources
    }

    /// MARK: Public interface
    
    func addDataSource(dataSource: DataSource) {
        self.dataSources.append(dataSource)
    }
    
    func removeDataSource(dataSource: DataSource) {
        if let index = find(self.dataSources, dataSource) {
            self.dataSources.removeAtIndex(index)
        }
    }
        
    override func heightForRowAtIndexPath(indexPath: NSIndexPath) -> CGFloat {
        let (dataSource, localSection) = dataSourceIndex[indexPath.section]!
        let localIndexPath = NSIndexPath(forRow: indexPath.row, inSection: localSection)
        return dataSource.heightForRowAtIndexPath(localIndexPath)
    }
    
    override func selectRowAtIndexPath(indexPath: NSIndexPath) {
        let (dataSource, localSection) = dataSourceIndex[indexPath.section]!
        let localIndexPath = NSIndexPath(forRow: indexPath.row, inSection: localSection)
        dataSource.selectRowAtIndexPath(localIndexPath)
    }
    
    override func titleForHeaderInSection(section: Int) -> String! {
        let (dataSource, localSection) = dataSourceIndex[section]!
        return dataSource.titleForHeaderInSection(localSection)
    }
    
    override func titleForFooterInSection(section: Int) -> String! {
        let (dataSource, localSection) = dataSourceIndex[section]!
        return dataSource.titleForFooterInSection(localSection)
    }
    
    /// MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numberOfSections: Int = 0
        
        let dataSourcesCount = self.dataSources.count

        for var i = 0; i < dataSourcesCount; ++i {
            var dataSourceSections: Int = 1
            
            let dataSource = self.dataSources[i]
            
            if dataSource.respondsToSelector("numberOfSectionsInTableView:") {
                dataSourceSections = dataSource.numberOfSectionsInTableView(tableView)
            }
            
            var localSection: Int = 0
            while dataSourceSections > 0 {
                
                dataSourceIndex[numberOfSections] = (self.dataSources[i], localSection)
                
                ++localSection
                
                ++numberOfSections
                --dataSourceSections
            }
        }
        
        return numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let (dataSource, localSection) = dataSourceIndex[section]!
        return dataSource.tableView(tableView, numberOfRowsInSection:localSection)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let (dataSource, localSection) = dataSourceIndex[indexPath.section]!
        let localIndexPath = NSIndexPath(forRow: indexPath.row, inSection: localSection)
        return dataSource.tableView(tableView, cellForRowAtIndexPath: localIndexPath)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.shouldDisplayDefaultTitles {
            let (dataSource, localSection) = dataSourceIndex[section]!
            return dataSource.tableView(tableView, titleForHeaderInSection: localSection)
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if self.shouldDisplayDefaultTitles {
            let (dataSource, localSection) = dataSourceIndex[section]!
            return dataSource.tableView(tableView, titleForFooterInSection: localSection)
        }
        return nil
    }
}
