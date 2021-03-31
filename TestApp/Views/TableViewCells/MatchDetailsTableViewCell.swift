//
//  MatchDetailsTableViewCell.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/29/21.
//

import UIKit

protocol MatchDetailsDelegate: class {
    func addNewBet()
}

class MatchDetailsTableViewCell: UITableViewCell {

    static let id: String = "MatchDetailsTableViewCell"
    weak var delegate: MatchDetailsDelegate?
    
    @IBAction func addBet(_ sender: UIButton) {
        self.delegate?.addNewBet()
    }
    
}
