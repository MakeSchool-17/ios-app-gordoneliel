//
//  NearbySearchFilterTableView.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/4/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

class NearbySearchFilterTableView: UITableView, UITableViewDataSource {
    let searchItems = ["Distance", "Field", "Best Match"]
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        
        registerNib(UINib(nibName: FilterCellIdentifier, bundle: nil), forCellReuseIdentifier: FilterCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier(FilterCellIdentifier, forIndexPath: indexPath) as! DistanceFilterCell
        case 1:
            cell.textLabel?.text = searchItems[indexPath.row]
            cell.accessoryType = .DisclosureIndicator
            return cell
        case 2:
            cell.textLabel?.text = searchItems[indexPath.row]
            cell.accessoryType = .DisclosureIndicator
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
}
