//
//  HomeBrain.swift
//  Restaurant Recommendation
//
//  Created by Richard Basdeo on 4/3/21.
//

import Foundation

//Protocols for searching
//Updating UI will be called when api request is done
//Error will be called if any errors
//Needs to be called by the viewController
protocol searchProtocol {
    func UpdatUI(_ searchBrain: Search)
    func didFailWithError(error: Error)
    func singleSearchDone()
}


class Search {
    
    //api key
    let api_key = "CP9_jrQkdu75k7PrDjMeIdmxai0GAAI75xNNshYwCQelUs5eIoDu8qk9YzAcNBj7F_MlJVT1jK8C0fYgmqGDEahMkG3sbjs2GyQXStsgnmDqyGpSUE-WldpbwrIqYHYx"
    
    //delegate which will have to be set by the viewContoller
    var delegate: searchProtocol?
    
    //holds all the business that match the search results
    var allReturnedSearchBusinesses = [Restaurant]()
    
    var favoriteRestaurants = [Restaurant]()
    

    //MARK:: Methods You Call
    func getSingleRestaurant(restaurantID: String) {
        
        let url = "https://api.yelp.com/v3/businesses/\(restaurantID)"
        
        if let restaurantURL = URL(string: url){
            
            //create a request
            var request = URLRequest(url: restaurantURL)
            request.setValue("Bearer \(api_key)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if let e = error {
                    self.delegate?.didFailWithError(error: e)
                }
                else {
                    
                    
                    if let returnedData = data {
                        
                        self.singleParse(responseData: returnedData)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    //perform api request to get business near my current location
    func perfromSearchApiReqest (lattitude: String, longtitude: String, restaurantName: String){
        
        //create the url
        let theURL = "https://api.yelp.com/v3/businesses/search?latitude=\(lattitude)&longitude=\(longtitude)&term=\(restaurantName)&categories=restaurants&limit=20"
        
        
        //convert string url to actual url
        if let URL = URL(string: theURL){
            
            //create a request
            var request = URLRequest(url: URL)
            request.setValue("Bearer \(api_key)", forHTTPHeaderField: "Authorization")
            
            //create the "browser"
            let sesseion = URLSession(configuration: .default)
            
            //give the browser a task
            let task = sesseion.dataTask(with: request) { (data, response, error) in
                
                //check to see if there was a error
                if let e = error {
                    print ("There was an error with the api call. \(e)")
                    return
                }
                // if no error parse json
                if let safeData = data {
                    self.parseJson(apiData: safeData)
                }
            }
            //perform the request
            task.resume()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK:: My helper functions
    func singleParse(responseData: Data){
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(businesses.self, from: responseData)
            let newObject = Restaurant(
                restaurantName: decodedData.name,
                restaurantRating: decodedData.rating,
                restaurantReview_count: decodedData.review_count,
                restaurantImage_url: decodedData.image_url,
                restaurantAlias: decodedData.categories[0].alias.capitalized,
                restaurantTitle: decodedData.categories[0].title,
                restaurantPhoneNumber: decodedData.phone,
                restaurantAddress: decodedData.location,
                restaurantLatitude: decodedData.coordinates.latitude,
                restaurantLongitude: decodedData.coordinates.longitude,
                restaurantID: decodedData.id,
                restaurantDollarSign: decodedData.price ?? "")
            
            favoriteRestaurants.append(newObject)
            delegate?.singleSearchDone()
        }
        catch{
            delegate?.didFailWithError(error: error)
        }
    }
    
    
    
    //parsing json will create business objects tha will be put into the returnBusiness array
    func parseJson (apiData: Data) {
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(yelpReturnedBusinesses.self, from: apiData)
            
            allReturnedSearchBusinesses.removeAll()
            
            for object in decodedData.businesses {
                let newObject = Restaurant(
                    restaurantName: object.name,
                    restaurantRating: object.rating,
                    restaurantReview_count: object.review_count,
                    restaurantImage_url: object.image_url,
                    restaurantAlias: object.categories[0].alias.capitalized,
                    restaurantTitle: object.categories[0].title,
                    restaurantPhoneNumber: object.phone,
                    restaurantAddress: object.location,
                    restaurantLatitude: object.coordinates.latitude,
                    restaurantLongitude: object.coordinates.longitude,
                    restaurantID: object.id,
                    restaurantDollarSign: object.price ?? "")
                
                allReturnedSearchBusinesses.append(newObject)
                
            }
            self.delegate?.UpdatUI(self)
        }
        catch {
            delegate?.didFailWithError(error: error)
            return
        }
    }
}
