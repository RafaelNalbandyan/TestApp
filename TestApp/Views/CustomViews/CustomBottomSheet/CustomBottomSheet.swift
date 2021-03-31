//
//  CustomBottomSheet.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/30/21.
//

import UIKit

protocol CustomBottomSheetDelegate: class {
    func toogleView(hide: Bool)
    func makeBet()
    func keyboardIsOpen(_ open: Bool, keyboardHeight: CGFloat?)
    func addBet()
}

class CustomBottomSheet: UIView {
    
    weak var delegate: CustomBottomSheetDelegate?
    public var addNewBettButtonWasPressed: Bool = false
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func draw(_ rect: CGRect) {
        self.detailView.isHidden = true
        setUpKeyboardObserver()
        setupButtons()
    }
    
    @IBAction func setSuggestedOption(_ sender: UIButton) {
        switch sender.tag {
        case 111:
            self.textField.text = "100"
        case 222:
            self.textField.text = "500"
        case 333:
            self.textField.text = "1000"
        default: break
        }
        self.delegate?.addBet()
    }
    
    private func setupButtons() {
        if addNewBettButtonWasPressed {
            changeButtonStyle(button: yesButton, backgroundColor: #colorLiteral(red: 0.1882352941, green: 0.8745098039, blue: 0.5529411765, alpha: 1), textColor: .white)
            changeButtonStyle(button: noButton, backgroundColor: #colorLiteral(red: 0.9725490196, green: 0, blue: 0.2980392157, alpha: 1), textColor: .white)
        } else {
            changeButtonStyle(button: yesButton, backgroundColor: .black, textColor: #colorLiteral(red: 0.1882352941, green: 0.8745098039, blue: 0.5529411765, alpha: 1))
            changeButtonStyle(button: noButton, backgroundColor: .black, textColor: #colorLiteral(red: 0.9725490196, green: 0, blue: 0.2980392157, alpha: 1))
        }
        
    }
    
    func addNewBet() {
        addNewBettButtonWasPressed = true
    }
    
    @IBAction func action(_ sender: UIButton) {
        if sender.tag == 11 {
            self.detailView.isHidden = false
            actionWillBe(true)
            changeButtonStyle(button: sender, backgroundColor: #colorLiteral(red: 0.1882352941, green: 0.8745098039, blue: 0.5529411765, alpha: 1), textColor: .white)
        }
        
        if sender.tag == 22 {
            actionWillBe(false)
        }
    }
    
    @IBAction func makeBet(_ sender: UIButton) {
        /*
        
         */
        self.delegate?.makeBet()
    }
    
    private func actionWillBe(_ gool: Bool) {
        self.delegate?.toogleView(hide: gool)
    }
    
    private func setUpKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let keyboardHeght = keyboardSize.height
        self.delegate?.keyboardIsOpen(true, keyboardHeight: keyboardHeght)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.delegate?.keyboardIsOpen(false, keyboardHeight: nil)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    private func changeButtonStyle(button: UIButton, backgroundColor: UIColor, textColor: UIColor) {
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
