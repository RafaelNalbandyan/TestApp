//
//  GamesCollectionViewCell.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/29/21.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let id: String = "GamesCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
