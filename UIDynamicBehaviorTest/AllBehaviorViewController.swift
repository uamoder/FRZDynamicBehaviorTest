//
//  AllBehaviorViewController.swift
//  FRZUIDynamicBehaviorTest
//
//  Created by Alex Neminsky on 27.01.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class AllBehaviorViewController: UIViewController {
    
    var boxes = [UIView]()
    
    var animator: UIDynamicAnimator!
    
    
    var attach: UIAttachmentBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: view)
        
        for i in 0...5 {
            let box = UIView(frame: CGRect(x: i*60, y: 200, width: 30, height: 30))
            box.backgroundColor = UIColor.red
            box.layer.cornerRadius = 15
            box.layer.masksToBounds = true
            view.addSubview(box)
            boxes.append(box)
        }
        
        let itemBehavior = UIDynamicItemBehavior(items: boxes)
        itemBehavior.angularResistance = 0.5
        itemBehavior.density = 10
        itemBehavior.elasticity = 0.6
        itemBehavior.friction = 0.3
        itemBehavior.resistance = 0.3
        animator.addBehavior(itemBehavior)
        // Do any additional setup after loading the view.
        
        let gravity = UIGravityBehavior(items: boxes)
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: boxes)
        collision.collisionMode = .everything
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        attach = UIAttachmentBehavior(item: boxes.first!, attachedToAnchor: boxes.first!.center)
        attach.anchorPoint = CGPoint(x: 150, y: 80)
        attach.frequency = 1
        attach.damping = 1
        attach.length = 20
        animator.addBehavior(attach)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan(pan:)))
        view.addGestureRecognizer(pan)
        
        for i in 1..<boxes.count {
            let view = boxes[i]
            let attach = UIAttachmentBehavior(item: view, attachedTo: boxes[i-1])
            attach.frequency = 3
            attach.damping = 1
            attach.length = 15
            animator.addBehavior(attach)
        }

    }
    
    // MARK: - Methods
    func addPan(pan: UIPanGestureRecognizer) {
        
        let point = pan.location(in: view)
        let state = pan.state
        
        if !animator.behaviors.contains(attach) {
            animator.addBehavior(attach)
        }
        
        attach.anchorPoint = point
        
        if state == .ended {
            animator.removeBehavior(attach)
        }
        
    }

}
