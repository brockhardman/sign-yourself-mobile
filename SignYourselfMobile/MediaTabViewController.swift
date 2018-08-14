//
//  MediaTab.swift
//  SignYourselfMobile
//
//  Created by osx on 31/05/18.
//  Copyright © 2018 SignYourself. All rights reserved.
//

import UIKit

class MediaTabViewController: UIViewController {
    //MARK:Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collapseDelegate:CollapseDelegate?
    var offset:CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib.init(nibName: "MediaCell", bundle: nil), forCellWithReuseIdentifier: "MediaCell")
    }
}
//MARK:Extension for Collection View for this Screen
extension MediaTabViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath) as! MediaCell
        
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offset = scrollView.contentOffset.y
        collapseDelegate?.collapse(offset: offset!)
    }
}
extension MediaTabViewController: UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
}
extension MediaTabViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.size.width/2-5, height: collectionView.frame.size.width/2-5)
    }
}

