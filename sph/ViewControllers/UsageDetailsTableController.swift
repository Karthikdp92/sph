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
        self.getUsageDetails()
    }
    
    private func getUsageDetails() {
        UsageDetailsServices.DownloadUsageDetails(usageDetails: self.usageDetails, offset: self.offset, limit: self.limit, resourceId: Constants.resourceId) { (isCache, status, message, usageDetails) in
            self.usageDetails = usageDetails
            DispatchQueue.main.async {
                if !status {
                    self.showAlert(message: message)
                    self.navigationController?.navigationBar.backgroundColor = UIColor.red
                } else {
                    self.navigationController?.navigationBar.backgroundColor = UIColor.green
                }
                self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usageDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsageDetailsTableCell", for: indexPath) as! UsageDetailsTableCell
        
        cell.setUpCardView()
        cell.label1.text = String(describing: self.usageDetails[indexPath.row].year)
        cell.label2.text = "Total data Used : " + String(describing: self.usageDetails[indexPath.row].dataVolume)
        
        if !self.usageDetails[indexPath.row].isAlertRequired {
            cell.alertImage.isHidden = true
        } else {
            cell.alertImage.isHidden = false
            cell.alertButton.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
        }
        
        if (indexPath.row == (self.usageDetails.count - 1)) && !self.isLoading {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
        return cell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            self.offset += self.limit
            self.limit = 5
            self.getUsageDetails()
        }
    }
    
    @objc func pressButton(_ sender: UIButton){
        self.showAlert(message: "There is a decrease in data on QOQ basis.")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
