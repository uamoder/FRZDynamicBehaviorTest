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
        let image = UIImage(named: "shar")
        let imageView = UIImageView(image: image)
        imageView.frame = view.bounds
        view.addSubview(imageView)
        view.backgroundColor = UIColor.clear
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
        let image = UIImage(named: "shar")
        let imageView = UIImageView(image: image)
        imageView.frame = view.bounds
        view.addSubview(imageView)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var animator: UIDynamicAnimator = {
        UIDynamicAnimator(referenceView: self.view)
    }()
    
    lazy var attach: UIAttachmentBehavior = {
        var attach = UIAttachmentBehavior(item: self.box1, attachedToAnchor: self.box3.center)
        attach.length = 100
        attach.frequency = 0.6
        attach.damping = 0.5
        
        return attach
    } ()
    
    lazy var gravity: UIGravityBehavior = {
        let gravity = UIGravityBehavior(items: [self.box1])
        return gravity
    } ()
    
    lazy var collision: UICollisionBehavior = {
        let collision = UICollisionBehavior(items: [self.box1])
        collision.collisionMode = .everything
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.addBoundary(withIdentifier: "ups" as NSCopying, for: UIBezierPath(rect: CGRect(x: 160, y: 300, width: 80, height: 80)))
        return collision
    } ()
    
    lazy var rope: CAShapeLayer = {
        let rope = CAShapeLayer()
        rope.fillColor = UIColor.clear.cgColor
        rope.lineJoin = kCALineCapRound
        rope.lineWidth = 2
        rope.strokeColor = UIColor.black.cgColor
        rope.strokeEnd = 1
        self.view.layer.addSublayer(rope)
        return rope
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(box1)
        view.addSubview(box2)
        view.addSubview(box3)
        
        animator.addBehavior(attach)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan(pan:)))
        
        view.addGestureRecognizer(pan)
        // Do any additional setup after loading the view.
        
        box1.addObserver(self, forKeyPath: "center", options: .new, context: nil)
        box3.addObserver(self, forKeyPath: "center", options: .new, context: nil)
    }
    
    // MARK: - Methods
    func addPan(pan: UIPanGestureRecognizer) {
        
        box3.center = pan.location(in: view)
        attach.anchorPoint = pan.location(in: view)
        
        
        switch pan.state {
        case .began:
            print ("")
        case .changed:
            print ("")
        case .ended:
            print ("")
        default:
            print ("")
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if box1.isEqual(object) || box3.isEqual(object) {
            let path = UIBezierPath()
            path.move(to: box3.center)
            path.addLine(to: box1.center)
            rope.path = path.cgPath
        }

    }
    
    deinit {
        box1.removeObserver(self, forKeyPath: "center")
        box3.removeObserver(self, forKeyPath: "center")
    }
    


}
