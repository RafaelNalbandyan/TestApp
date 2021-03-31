//
//  MainViewController.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/31/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var containersGroup: [UIView]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let games: [Sport] = [
        Sport(name: "basketball", icon: UIImage(named: "basketball-icon"), date: "16:10"),
        Sport(name: "tennis", icon: UIImage(named: "green-ball-icon"), date: "16:15"),
        Sport(name: "baseball", icon: UIImage(named: "baseball-icon"), date: "16:20"),
        Sport(name: "cricket", icon: UIImage(named: "cricket-icon"), date: "16:25")
    ]
    
    private let gamesCollectionViewXib = UINib(nibName: "GamesCollectionViewCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(gamesCollectionViewXib, forCellWithReuseIdentifier: GamesCollectionViewCell.id)
        switchContainers(index: 0)
    }
    
    private func switchContainers(index: Int = 0) {
        switch index {
        case 0:
            containersGroup.first!.alpha = 0
            containersGroup.first!.isUserInteractionEnabled = false
            containersGroup.last!.alpha = 1
            containersGroup.last!.isUserInteractionEnabled = true
        default:
            containersGroup.first!.alpha = 1
            containersGroup.first!.isUserInteractionEnabled = true
            containersGroup.last!.alpha = 0
            containersGroup.last!.isUserInteractionEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProgressSegue" {
            if let childVC = segue.destination as? ProgressViewController {
                childVC.delegate = self
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.id, for: indexPath) as! GamesCollectionViewCell
        addBorderToCell(cell: cell)
        let sport = self.games[indexPath.row]
        cell.titleLabel.text = sport.name
        cell.dateLabel.text = sport.date
        cell.gameImageView.image = sport.icon
        return cell
    }
    
    private func addBorderToCell(cell: GamesCollectionViewCell) {
        let borderColor = Constants.Application.borderColor
        cell.addBorder(side: .left, thickness: 1, color: borderColor)
        cell.addBorder(side: .right, thickness: 1, color: borderColor)
    }
}

extension MainViewController: ProgressDelegate {
    func switchContainer() {
        switchContainers(index: 1)
    }
}
