//
//  ProgressViewController.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/31/21.
//

import UIKit

protocol ProgressDelegate: class {
    func switchContainer()
}

class ProgressViewController: UIViewController {

    @IBOutlet weak var rotatingProgressBar: RotatingCircularGradientProgressBar!
    @IBOutlet weak var timerLabel: UILabel!
    weak var delegate: ProgressDelegate?
    
    private var timerSeconds: Int = 3
    private var timerStoped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let progress = CGFloat(0.5)
        rotatingProgressBar.progress = progress
        setupTimer()
    }
    
    func setupProgress() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateColors()
        }
    }
    
    private func updateColors() {
        let mainColor = #colorLiteral(red: 0.2666666667, green: 0.6470588235, blue: 0.537254902, alpha: 1)
        let gradient = #colorLiteral(red: 0.6666666667, green: 0.8980392157, blue: 0.8352941176, alpha: 1)
        rotatingProgressBar.color = mainColor
        rotatingProgressBar.gradientColor = gradient
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timer), userInfo: nil, repeats: true)
    }
    
    @objc func timer() {
        guard !timerStoped else { return }
        guard self.timerSeconds > 0 else {
            self.delegate?.switchContainer()
            timerStoped = true
            return
        }
        self.timerSeconds -= 1
        self.timerLabel.text = "04 : 1\(self.timerSeconds)"
    }
}


