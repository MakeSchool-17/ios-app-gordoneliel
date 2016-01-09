//
//  NearbySearchFilterTableView.swift
//  OfficeHours
//
//  Created by Eliel Gordon on 1/4/16.
//  Copyright © 2016 Saltar Group. All rights reserved.
//

import UIKit

class NearbySearchFilterTableView: UITableView {
    
    let industries = ["Accounting", "Administrative", "Architecture", "Design (UI/UX)", "Education", "Finance", "Technology", "Entrepreneurship", "Marketing", "Management"]
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        
        separatorColor = UIColor.lighterGrayColor()
        estimatedRowHeight = 55
        rowHeight = 55
        backgroundColor = UIColor.whiteColor()
        separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        // Register Cells
        registerNib(UINib(nibName: FilterCellIdentifier, bundle: nil), forCellReuseIdentifier: FilterCellIdentifier)
        
        registerNib(UINib(nibName: IndustryCellIdentifier, bundle: nil), forCellReuseIdentifier: IndustryCellIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NearbySearchFilterTableView: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(FilterCellIdentifier, forIndexPath: indexPath) as! DistanceFilterCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(IndustryCellIdentifier, forIndexPath: indexPath) as! IndustryCell
            cell.industry.text = industries[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return section == 0 ?  1 : industries.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableView.tableHeaderView?.backgroundColor = UIColor.whiteColor()
        switch section {
        case 0:
            return "Distance"
        case 1:
            return "Industry"
        default: return ""
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 17)!
        header.textLabel?.textColor = UIColor.darkTextColor()
        header.textLabel?.text = header.textLabel?.text?.capitalizedString
        header.contentView.backgroundColor = UIColor.whiteColor()
    }
    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        let label = UILabel()
//        switch section {
//        case 0:
//            label.text = "Distance"
//        case 1:
//            label.text = "Industry"
//        default: label.text = ""
//        }
//        
//        view.addSubview(label)
////        view.addConstraints([NSLayoutConstraint(item: label, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 0, constant: 0)])
//        
//        return view
//    }
}

extension NearbySearchFilterTableView: UITableViewDelegate {

}
