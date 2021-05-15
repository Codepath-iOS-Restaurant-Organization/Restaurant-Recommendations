//
//  RecommendationTableViewController.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 4/18/21.
//

import UIKit

class RecommendationTableViewController: UITableViewController {

    var friendChosen = ""
    var similarArray = [String]()
    var differentArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(friendChosen)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return similarArray.count
        }
        if section == 1 {
            return differentArray.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dummyCell = UITableViewCell()
        
        if (indexPath.section == 0) {
            // Setup similar cell
            dummyCell.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            return dummyCell
        }
        else if (indexPath.section == 1) {
            
            //set up not similar cells
            return dummyCell
            
        }
        
        return dummyCell
        
    }


}
