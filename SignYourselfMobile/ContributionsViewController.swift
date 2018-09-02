//
//  ContributionsViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation
import PassKit

class ContributionsViewController: ActiveViewController {
    //MARK:Properties
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var contributionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    //MARK:Setting the Views in the Screen
    private func setUpViews()  {
        searchView.dropShadow()
    }
}
//MARK:Extension for TableView of this Screen
extension ContributionsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ContributionCell") as? ContributionCell
        if (cell == nil)
        {
            var nib = Bundle.main.loadNibNamed("ContributionCell", owner: self, options: nil)
            cell = nib?[0] as? ContributionCell
            if indexPath.row % 2 == 0 || indexPath.row == 0 {
                cell?.backgroundView?.backgroundColor = UIColor.lightGray
            }
            
        }
        return cell!
    }
}
extension ContributionsViewController : UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

