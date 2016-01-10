//
//  IndustryViewController.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/9/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit
import Bond

class IndustryViewController: UITableViewController {

    var industries: [String]? {
        didSet {
            setupTableView()
        }
    }
    
    var dataSource: ArrayDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.rowHeight = 55

        ParseHelper.fetchIndustryConfig {
            industries in
    
            self.industries = industries
        }
    }
    
    func setupTableView() {
        dataSource = ArrayDataSource(items: industries!, cellIdentifier: "basicCell") {
            (cell, item) in
            
            if let cell = cell as? UITableViewCell {
                if let item = item as? String {
                    cell.textLabel?.text = item
                }
            }
        }
        
        tableView.dataSource = dataSource
    }
}

extension IndustryViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = User.currentUser()
        let industry = industries![indexPath.row]
        user?.industry = industry
        user?.saveInBackground()

        user?.userIndustry.next(industry)
        
        self.navigationController?.popViewControllerAnimated(true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
