//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by LinuxPlus on 5/10/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var item: iTunesItem?
    
    @IBOutlet weak var itemImage: AsyncImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var itemKind: UILabel!
    @IBOutlet weak var itemCurrency: UILabel!
    @IBOutlet weak var itemGenre: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        if let iTunesItem = item{
            itemName.text = iTunesItem.name
            artistName.text = iTunesItem.artistName
            itemKind.text = iTunesItem.kind
            itemCurrency.text = iTunesItem.currency
            itemGenre.text = iTunesItem.genre
            itemPrice.text = String(iTunesItem.price)
            itemImage.imageURL = URL(string: iTunesItem.artworkLargeUrl)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
