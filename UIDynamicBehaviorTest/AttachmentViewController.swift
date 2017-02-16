//
//  AttachmentViewController.swift
//  FRZUIDynamicBehaviorTest
//
//  Created by Alex Neminsky on 27.01.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class AttachmentViewController: UIViewController {

    // MARK: - Variables
    lazy var box1: UIView = {
        let view = UIView(frame: CGRect(x: 140, y: 100, width: 20, height: 20))
        view.backgroundColor = UIColor.red
        //view.transform = CGAffineTransform(rotationAngle: 45)
        return view
    }()
    
    lazy var box2: UIView = {
        let view = UIView(frame: CGRect(x: 160, y: 300, width: 80, height: 80))
        view.backgroundColor = UIColor.green
        return view
    }()
    
    lazy var box3: UIView = {
        let view = UIView(frame: CGRect(x: 165, y: 305, width: 20, height: 20))
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    lazy var animator: UIDynamicAnimator = {
        UIDynamicAnimator(referenceView: self.view)
    }()
    
    lazy var attach: UIAttachmentBehavior = {
        var attach = UIAttachmentBehavior(item: self.box1, attachedTo: self.box3)
        attach.length = 100
        attach.frequency = 0
        attach.damping = 0.1
        
        return attach
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(box1)
        view.addSubview(box2)
        view.addSubview(box3)
        
        animator.addBehavior(attach)
//        
//        let gravity = UIGravityBehavior(items: [box1])
//        animator.addBehavior(gravity)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan(pan:)))
        
        view.addGestureRecognizer(pan)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func addPan(pan: UIPanGestureRecognizer) {
        animator.removeAllBehaviors()
        box1.center = pan.location(in: view)
        
        switch pan.state {
        case .began:
            //animator.addBehavior(attach)
            print ("")
        case .changed:
            animator.addBehavior(attach)
            print ("")
        case .ended:
            animator.removeAllBehaviors()
            print ("")
        default:
            print ("")
        }
    }
    


}
