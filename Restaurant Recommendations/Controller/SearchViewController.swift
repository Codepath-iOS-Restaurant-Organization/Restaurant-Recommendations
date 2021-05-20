//
//  SearchViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    var stringLon: String?
    var stringLat: String?

    let locationManger = CLLocationManager()
    let search = Search()
    
    var shouldAnimate = true
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
        
        search.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Loading up the details screen...")
        
        if segue.identifier == "toDetailsSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destVC = segue.destination as! RestaurantDetailViewController
                destVC.chosenRestaurant = search.allReturnedSearchBusinesses[indexPath.row]
            }
        }
    }
    
    
    
    //give animation to tableView
        func animateTable (){
            //reload table
            tableView.reloadData()
            
            //get all visible cells
            let visibleCells = tableView.visibleCells
            
            
            //get tableViewHeight
            let tableViewheight = tableView.bounds.size.height
            
            
            //go through each cell and move it down to tableviewHeight
            for cell in visibleCells {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewheight)
            }
            
            
            //need to animate back to position
            //need counter so to happens after one anther
            var delayCounter = 0
            for cell in visibleCells {
                
                
                UIView.animate(withDuration: 4.0,
                               delay: Double(delayCounter) * 0.05,
                               usingSpringWithDamping: 0.5,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut) {
                    
                    
                    cell.transform = CGAffineTransform.identity
                    
                }
                delayCounter += 1
            }
        }

}



//Once got current user's location update the nil strings
extension SearchViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManger.stopUpdatingLocation()
        
        if let userLocation = locations.last {
            
            stringLon = String(userLocation.coordinate.longitude)
            stringLat = String(userLocation.coordinate.latitude)
        }
    }
}




extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.allReturnedSearchBusinesses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        cell.restaurantNameLabel.text = search.allReturnedSearchBusinesses[indexPath.row].restaurantName
        cell.phoneNumberLabel.text = search.allReturnedSearchBusinesses[indexPath.row].restaurantPhoneNumber.toPhoneNumber()
        cell.categoryLabel.text = search.allReturnedSearchBusinesses[indexPath.row].restaurantAlias
        cell.numberReviewsLabel.text = "Reviews: " + String(search.allReturnedSearchBusinesses[indexPath.row].restaurantReview_count)
        cell.setImageView(theImageURL: search.allReturnedSearchBusinesses[indexPath.row].restaurantImage_url)

        switch search.allReturnedSearchBusinesses[indexPath.row].restaurantRating {
        case 0.0:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_0")
        case 1.0:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_1")
        case 1.5:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_1_half")
        case 2.0:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_2")
        case 2.5:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_2_half")
        case 3.0:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_3")
        case 3.5:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_3_half")
        case 4.0:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_4")
        case 4.5:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_4_half")
        case 5.0:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_5")
        default:
            cell.restaurantRatingImage.image = UIImage(named: "extra_large_0")
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toDetailsSegue", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
     }
}






extension SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text == "") {
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
        else {
            
            // Gets search bar text, encodes the URL string, and performs API request.
            if let searchBarText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                
                search.perfromSearchApiReqest(lattitude: stringLat!, longtitude: stringLon!, restaurantName: searchBarText)
            }
        }
        searchBar.endEditing(true)
        searchBar.showsCancelButton = true
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(false)
    }
}




extension SearchViewController : searchProtocol {
    func UpdatUI(_ searchBrain: Search) {
        
            DispatchQueue.main.async {
                self.animateTable()
            }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func singleSearchDone() {
        print("Single search done.")
    }
}


