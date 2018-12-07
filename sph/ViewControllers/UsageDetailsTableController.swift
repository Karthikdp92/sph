//
//  UsageDetailsTableController.swift
//  sph
//
//  Created by Karthik Dp on 07/12/18.
//  Copyright © 2018 Karthik Dp. All rights reserved.
//

import UIKit
import RealmSwift

class UsageDetailsTableController: UITableViewController {
    
    var usageDetails = List<UsageDetail>()
    var limit : Int = 30
    var offset : Int = 0
    var isLoading : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func getUsageDetails() {
        UsageDetailsServices.DownloadUsageDetails(usageDetails: self.usageDetails, offset: self.offset, limit: self.limit, resourceId: Constants.sharedInstance.resourceId()) { (isCache, status, message, usageDetails) in
            print(usageDetails)
            DispatchQueue.main.async {
                self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsageDetailsTableCell", for: indexPath) as! UsageDetailsTableCell
        cell.setUpCardView()
        return cell
    }

}
