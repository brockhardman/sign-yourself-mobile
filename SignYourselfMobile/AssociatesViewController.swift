//
//  AssociatesViewController.swift
//  SignYourselfMobile
//
//  Created by Brock Hardman on 8/12/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import Foundation

class AssociatesViewController: ActiveViewController {
    //MARK:Properties
    @IBOutlet weak var associatesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
//MARK:Extension for Table View for this Screen
extension AssociatesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssociateCell", for: indexPath) as! AssociateCell
        return cell
    }
}
extension AssociatesViewController:UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
