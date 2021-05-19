//
//  FavoritesCollectionViewCell.swift
//  Restaurant Recommendations
//
//  Created by Feizza Fazilatun on 5/17/21.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    func setCellImage (theImageURL: String){
        if let url = URL(string: theImageURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let e = error {
                    print("Could not convert url to a image: \(e.localizedDescription)")
                }
                else {
                    
                    if let imageData = data {
                        let tempImage = UIImage(data: imageData)
                        
                        if let unwrappedImage = tempImage {
                            DispatchQueue.main.async {
                                self.favoriteImageView.image = unwrappedImage
                             
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
}
