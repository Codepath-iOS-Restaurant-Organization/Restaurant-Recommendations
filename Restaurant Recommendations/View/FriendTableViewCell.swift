//
//  FriendTableViewCell.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 5/10/21.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendEmail: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setImage (picURL: String) {
        
        if let theURL = URL(string: picURL){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: theURL) { (data, response, error) in
                
                if let e = error {
                    print (e.localizedDescription)
                }
                else {
                    if let imageData = data {
                        
                        let tempImage = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.friendImage.image = tempImage
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func setEmail (userEmail: String){
        friendEmail.text = userEmail
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendImage.image = UIImage(systemName: "person")
    }
}
