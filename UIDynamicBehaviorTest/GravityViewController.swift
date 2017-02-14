//
//  GravityViewController.swift
//  FRZUIDynamicBehaviorTest
//
//  Created by Alex Neminsky on 27.01.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {

    // MARK: - Variables
    lazy var square: UIView = {
        let view = UIView(frame: CGRect(x: 140, y: 200, width: 50, height: 50))
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    lazy var animator: UIDynamicAnimator = {
        UIDynamicAnimator(referenceView: self.view)
    }()
    
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        view.addSubview(square)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan(pan:)))
        
        view.addGestureRecognizer(pan)
    }
    
    // MARK: - Methods
    func addPan(pan: UIPanGestureRecognizer) {
        animator.removeAllBehaviors()
        square.center = pan.location(in: view)
        
        switch pan.state {
        case .ended:
            let gravity = UIGravityBehavior(items: [square])
            animator.addBehavior(gravity)
        default:
            print ("")
        }
    }

}
