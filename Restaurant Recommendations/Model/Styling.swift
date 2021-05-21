//
//  Styling.swift
//  Restaurant Recommendations
//
//  Created by Richard Basdeo on 5/20/21.
//

import UIKit
class Styling {
    
    static let tier1 = #colorLiteral(red: 0.9058823529, green: 0.9098039216, blue: 0.8666666667, alpha: 1)
    static let tier2 = #colorLiteral(red: 0, green: 0.5411764706, blue: 0.5803921569, alpha: 1)
    static let tier3 = #colorLiteral(red: 0.007843137255, green: 0.3411764706, blue: 0.4941176471, alpha: 1)
    static let tier4 = #colorLiteral(red: 0.03137254902, green: 0.1764705882, blue: 0.3529411765, alpha: 1)
    
    static func customButton (for aButton: UIButton){
        aButton.layer.cornerRadius = aButton.frame.height / 2
        aButton.backgroundColor = tier4
        aButton.setTitleColor(tier1, for: .normal)
    }
    
    
    
}
