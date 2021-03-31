//
//  BettingViewController.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/29/21.
//

import UIKit
import PanModal

class BettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    private var hideTableViewHeaderIsHidden: Bool = false
    private var isShortFormEnabled = false
    private var cells: [String] =  ["timerCell"]
    private let timerTableViewCellXib = UINib(nibName: "TimerTableViewCell", bundle: nil)
    private let matchDetailsTableViewCellXib = UINib(nibName: "MatchDetailsTableViewCell", bundle: nil)
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func presentBottomSheet() {
        let rowVC: PanModalPresentable.LayoutType = BottomSheetViewController()
        self.presentPanModal(rowVC)
    }
    
    private func setupTableView() {
        let headerXib = UINib(nibName: "MatchVideoView", bundle: nil)
        tableView.register(headerXib, forHeaderFooterViewReuseIdentifier: "MatchVideoView")
        self.tableView.register(matchDetailsTableViewCellXib, forCellReuseIdentifier: MatchDetailsTableViewCell.id)
        self.tableView.register(timerTableViewCellXib, forCellReuseIdentifier: TimerTableViewCell.id)
        self.tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MatchVideoView") as! MatchVideoView
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return !hideTableViewHeaderIsHidden ? 0.0 : 280
    }
}

extension BettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    private func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if self.cells.contains("timerCell") {
            hideTableViewHeaderIsHidden = true
            let cell = tableView.dequeueReusableCell(withIdentifier: TimerTableViewCell.id) as! TimerTableViewCell
            cell.delegate = self
            return cell
        } else {
            hideTableViewHeaderIsHidden = false
            let cell = tableView.dequeueReusableCell(withIdentifier: MatchDetailsTableViewCell.id) as! MatchDetailsTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

extension BettingViewController: TimerDelegate {
    func timeIs(_ over: Bool) {
        cells = ["matchDetails"]
        self.tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.presentBottomSheet()
        }
    }
}

extension BettingViewController: MatchDetailsDelegate {
    func addNewBet() {
        self.presentBottomSheet()
    }
}
