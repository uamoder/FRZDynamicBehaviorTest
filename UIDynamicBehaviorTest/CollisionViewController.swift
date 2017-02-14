//
//  CollisionViewController.swift
//  FRZUIDynamicBehaviorTest
//
//  Created by Alex Neminsky on 27.01.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class CollisionViewController: UIViewController {

    
    // MARK: - Variables
    lazy var box1: UIView = {
        let view = UIView(frame: CGRect(x: 140, y: 100, width: 80, height: 80))
        view.backgroundColor = UIColor.red
        view.transform = CGAffineTransform(rotationAngle: 45)
        return view
    }()
    
    lazy var box2: UIView = {
        let view = UIView(frame: CGRect(x: 160, y: 300, width: 40, height: 40))
        view.backgroundColor = UIColor.green
        return view
    }()
    
    lazy var animator: UIDynamicAnimator = {
        UIDynamicAnimator(referenceView: self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(box1)
        view.addSubview(box2)

        let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan(pan:)))
        
        view.addGestureRecognizer(pan)
        
        addStartBehavior()  
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func addPan(pan: UIPanGestureRecognizer) {
        animator.removeAllBehaviors()
        box1.center = pan.location(in: view)
        
        switch pan.state {
        case .changed:
            addCollision()
        case .ended:
            addStartBehavior()
        default:
            print ("")
        }
    }
    
    func addStartBehavior () {
        addGravity()
        addCollision()
    }
    
    func addCollision() {
        let coll = UICollisionBehavior(items: [box1, box2])
        coll.collisionMode = .everything
        coll.translatesReferenceBoundsIntoBoundary = true
        coll.collisionDelegate = nil
        animator.addBehavior(coll)
    }
    
    func addGravity() {
        let gravity = UIGravityBehavior(items: [box1, box2])
        animator.addBehavior(gravity)
    }

}
