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
        cell.numberReviewsLabel.text = String(search.allReturnedSearchBusinesses[indexPath.row].restaurantReview_count)
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
            if let searchBarText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) {
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
            self.tableView.reloadData()
         }
    }
    
    func didFailWithError(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func singleSearchDone() {
        print("Single search done.")
    }
}


