//
//  LandScapeViewController.swift
//  iTunesSearch
//
//  Created by LinuxPlus on 5/19/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class LandScapeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var alliTunesItems:[iTunesItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 100, height: 150)
        
    }

    
}

extension LandScapeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            detailViewController?.item = alliTunesItems?[indexPath.row]
            present(detailViewController!, animated: true, completion: nil)

    }
}

extension LandScapeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let allItems = alliTunesItems{
            return allItems.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "landscapeCell", for: indexPath) as! LandScapeCell
        
        if let allItems = alliTunesItems{
            cell.itemImage.imageURL = URL(string: allItems[indexPath.row].artworkLargeUrl)
            cell.itemName.text = allItems[indexPath.row].name
        }
        return cell
    }
    

}
