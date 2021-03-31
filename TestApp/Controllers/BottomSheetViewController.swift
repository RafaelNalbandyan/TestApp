//
//  BottomSheetViewController.swift
//  TestApp
//
//  Created by Rafael Nalbandyan on 3/30/21.
//

import UIKit
import PanModal

class BottomSheetViewController: UIViewController {
    
    public var addNewBettButtonWasPressed: Bool = false
    var isShortFormEnabled = true
    var isLongFormEnabled = true
    var bottomSheetState: BottomSheetStates = .small
    
    private var keyboardHeight: CGFloat = 0
    private var keyboardIsOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UINib(nibName: "CustomBottomSheet", bundle: .main).instantiate(withOwner: nil, options: nil).first as! CustomBottomSheet
        view.delegate = self
        view.frame = self.view.bounds
        self.view.addSubview(view)
    }
    
    func willTransition(to state: PanModalPresentationController.PresentationState) {
        guard isLongFormEnabled, case .shortForm = state
        else { return }
        isLongFormEnabled = false
        panModalSetNeedsLayoutUpdate()
    }
}

extension BottomSheetViewController: PanModalPresentable {
    var cornerRadius: CGFloat { return 50 }
    var anchorModalToLongForm: Bool { return false }
    var panScrollable: UIScrollView? { return nil }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func shouldTransition(to state: PanModalPresentationController.PresentationState) -> Bool {
        return true
    }
    
    var shortFormHeight: PanModalHeight {
        return isShortFormEnabled ? .contentHeight(150.0) : longFormHeight
    }
    
    var longFormHeight: PanModalHeight {
        switch self.bottomSheetState {
        case .middle:
            return keyboardIsOpen ? .contentHeight(350 + keyboardHeight) : .contentHeight(350)
        case .small:
            return .contentHeight(150)
        case .long:
            return keyboardIsOpen ? .contentHeight(500 + keyboardHeight) : .contentHeight(500)
        default:
            return .contentHeight(150)
        }
    }
    
}

extension BottomSheetViewController: CustomBottomSheetDelegate {
    func addBet() {
        setUpBottomSheet(state: .long)
    }
    
    func makeBet() {
        dismiss(animated: true, completion: nil)
    }
    
    func keyboardIsOpen(_ open: Bool, keyboardHeight: CGFloat?) {
        switch open {
        case true:
            guard let keyboardHeight = keyboardHeight else { return }
            self.keyboardHeight = keyboardHeight
            keyboardIsOpen = true
            setUpBottomSheet(state: .middle)
        default:
            self.keyboardHeight = 0
            setUpBottomSheet(state: .middle)
        }
    }
    
    func toogleView(hide: Bool) {
        if hide {
            setUpBottomSheet(state: .middle)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setUpBottomSheet(state: BottomSheetStates) {
        self.bottomSheetState = state
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
    }
    
}
