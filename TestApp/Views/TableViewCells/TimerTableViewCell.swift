//
//  TimerTableViewCell.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/30/21.
//

import UIKit

protocol TimerDelegate: class {
    func timeIs(_ over: Bool)
}

class TimerTableViewCell: UITableViewCell {
    static let id: String = "TimerTableViewCell"
    private var timerStoped: Bool = false
    
    private var timerSeconds: Int = 8
    weak var delegate: TimerDelegate?
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTimer()
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
    }
    
    @objc func timer() {
        guard !timerStoped else { return }
        guard self.timerSeconds > 0 else {
            self.delegate?.timeIs(true)
            timerStoped = true
            return
        }
        self.timerSeconds -= 1
        self.timerLabel.text = "00 : 0\(self.timerSeconds)"
    }
    
}
