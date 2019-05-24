//
//  ViewController.swift
//  Panel
//
//  Created by Pablo Cornejo on 5/23/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dragView: UIView!
    @IBOutlet weak var dragViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dragView.layer.cornerRadius = 15
        dragViewBottomConstraint.constant = -200
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        dragView.addGestureRecognizer(panRecognizer)
    }

    @IBAction func didTapButton() {
        dragViewBottomConstraint.constant = 20
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        var yTranslation = recognizer.translation(in: view).y
        
        switch recognizer.state {
        case .began, .possible: break
        case .changed:
            if yTranslation < 0 { yTranslation /= 6 }
            dragView.transform = CGAffineTransform(translationX: 0, y: yTranslation)
        case .ended, .failed, .cancelled:
            let shouldHide = yTranslation > dragView.bounds.height / 2
            if shouldHide {
                self.dragViewBottomConstraint.constant = -200
            }
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, animations: {
                if shouldHide {
                    self.view.layoutIfNeeded()
                }
                self.dragView.transform = .identity
            })
        @unknown default: break
        }
        
    }
    
}

