//
//  CollectionViewCell.swift
//  SignYourselfMobile
//
//  Created by osx on 28/05/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import UIKit

class ProjectCell: UICollectionViewCell {

    @IBOutlet var topImageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var amount: UILabel!
    @IBOutlet var artistName: UILabel?
    
    func configureWithProject(project: Project) {
        title.text = project.description
        amount.text = project.goal
        artistName?.text = project.name
    }
}
