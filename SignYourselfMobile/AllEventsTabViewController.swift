//
//  AllEventsTabViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/13/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

class AllEventsTabViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
//MARK:Extension for Table View for this Screen
extension AllEventsTabViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell
        if (cell == nil)
        {
            let nib = Bundle.main.loadNibNamed("EventCell", owner: self, options: nil)
            cell = nib?[0] as? EventCell
        }
        return cell!
    }
}
extension AllEventsTabViewController:UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}
