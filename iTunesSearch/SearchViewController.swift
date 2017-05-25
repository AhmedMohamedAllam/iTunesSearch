//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by LinuxPlus on 5/10/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, ApiManagerProtocol {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var searchText :String?
    var alliTunesItems:[iTunesItem] = [iTunesItem]()
    var delegate:ApiManagerProtocol?
    var isLoading:Bool = false
    var landScapeView:LandScapeViewController?
    
    struct CellIdentifiers {
        static let resultFoundCell = "ResultFoundCell"
        static let resultNotFoundCell = "ResultNotFoundCell"
        static let loadingCell = "LoadingCell"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 80
        var cellNib = UINib(nibName: CellIdentifiers.resultFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.resultFoundCell)
        
        cellNib = UINib(nibName: CellIdentifiers.resultNotFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.resultNotFoundCell)
        
        cellNib = UINib(nibName: CellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: CellIdentifiers.loadingCell)
        
    }
    
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        searchByCategory()
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func searchByCategory(){
        if let searchText = searchText{
            var url:URL?
            switch segmentControl.selectedSegmentIndex{
            case 0:
                url = CustomURL.music(searchText).asUrlRequest()
            case 1:
                url = CustomURL.movie(searchText).asUrlRequest()
            case 2:
                url = CustomURL.software(searchText).asUrlRequest()
            case 3:
                url = CustomURL.ebook(searchText).asUrlRequest()
            default: return
            }
            
            alliTunesItems.removeAll()
            isLoading = true
            tableView.reloadData()
            APIManager(paramDelegate: self).getItunesItems(url: url!)
            
        }
    }
    
    func getDataFromItunesDidFinish(itunesItems: [iTunesItem]){
        isLoading = false
        if itunesItems.count > 0{
            alliTunesItems = itunesItems
        }
        tableView.reloadData()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(alliTunesItems.count > 0){
            if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
                landScapeView = storyboard!.instantiateViewController(withIdentifier: "landScapeViewControllerID") as? LandScapeViewController
                landScapeView?.alliTunesItems = alliTunesItems
                present(landScapeView!, animated: true, completion: nil)
                
            }
            if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
                landScapeView?.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
}

extension SearchViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            dismissKeyboard()
            alliTunesItems.removeAll()
            searchText = text
            searchByCategory()
        }
    }
    
}

extension SearchViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if alliTunesItems.count > 0, let detailViewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        {
            detailViewController.item = alliTunesItems[indexPath.row]
            present(detailViewController, animated: true, completion: nil)
        }
    }
}

extension SearchViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading || alliTunesItems.count == 0 {
            return 1
        }else{
            return alliTunesItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLoading{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingCell , for: indexPath) as! LoadingCell
            return cell
        }else if alliTunesItems.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.resultNotFoundCell , for: indexPath) as! ResultNotFoundCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.resultFoundCell , for: indexPath) as! ResultFoundCell
            cell.itemTitle.text = alliTunesItems[indexPath.row].name
            cell.itemSubtitle.text = alliTunesItems[indexPath.row].artistName
            
            let stringUrl = alliTunesItems[indexPath.row].artworkSmallUrl
            let imageUrl = URL(string: stringUrl)
            cell.itemImage.imageURL = imageUrl
            
            return cell
        }
        
    }
}

