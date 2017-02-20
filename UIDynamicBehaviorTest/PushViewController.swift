//
//  PushViewController.swift
//  FRZUIDynamicBehaviorTest
//
//  Created by Alex Neminsky on 27.01.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {

    // MARK: - Variables
    lazy var box: UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 80, height: 80))
        let image = UIImage(named: "shar")
        let imageView = UIImageView(image: image)
        imageView.frame = view.bounds
        view.addSubview(imageView)
        view.backgroundColor = UIColor.clear
        //view.transform = CGAffineTransform(rotationAngle: 45)
        return view
    }()
    
    lazy var animator: UIDynamicAnimator = {
        UIDynamicAnimator(referenceView: self.view)
    }()
    
    lazy var attach: UIAttachmentBehavior = {
        var attach = UIAttachmentBehavior(item: self.box, attachedToAnchor: self.view.center)
        attach.length = 100
        attach.frequency = 0.6
        attach.damping = 0.5
        
        return attach
    } ()
    
    lazy var push: UIPushBehavior = {
        var push = UIPushBehavior(items: [self.box], mode: .instantaneous)
        return push
    } ()
    
    lazy var collision: UICollisionBehavior = {
        let collision = UICollisionBehavior(items: [self.box])
        collision.collisionMode = .everything
        collision.translatesReferenceBoundsIntoBoundary = true
        //collision.addBoundary(withIdentifier: "ups" as NSCopying, for: UIBezierPath(rect: CGRect(x: 160, y: 300, width: 80, height: 80)))
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

        view.addSubview(box)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(addPan(pan:)))
        view.addGestureRecognizer(pan)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func addPan(pan: UIPanGestureRecognizer) {
        
        let point = pan.location(in: view)
        let state = pan.state
        
        //behavior1With(point: point, state: state)
        
        behavior2With(point: point, state: state)
        

}

    func behavior1With(point: CGPoint, state: UIGestureRecognizerState) {
        switch state {
        case .began:
            animator.removeAllBehaviors()
            print ("")
        case .changed:
            box.center = point
            let path = UIBezierPath()
            path.move(to: view.center)
            path.addLine(to: box.center)
            rope.path = path.cgPath
            print ("")
        case .ended:
            var distance = sqrt(pow(view.center.x - point.x, 2) + pow(view.center.y - point.y, 2))
            distance = max(distance, 10)
            let angle = atan2(view.center.y - point.y,  view.center.x - point.x)
            push.angle = angle
            push.magnitude = distance / 40
            push.active = true
            animator.addBehavior(attach)
            animator.addBehavior(push)
            print ("")
        default:
            print ("")
        }
    
    }

    
    var prevPoint: CGPoint?
    func behavior2With(point: CGPoint, state: UIGestureRecognizerState) {
        switch state {
        case .began:
            animator.removeAllBehaviors()
            prevPoint = point
            print ("")
        case .changed:
            box.center = point
            //prevPoint = point
            print ("")
        case .ended:
            var distance = sqrt(pow(view.center.x - point.x, 2) + pow(view.center.y - point.y, 2))
            distance = max(distance, 10)
            //let angle = atan2(view.center.y - point.y,  view.center.x - point.x)
            let angle = atan2(point.y - prevPoint!.y,  point.x - prevPoint!.x)
            push.angle = angle
            push.magnitude = distance / 40
            push.active = true
            animator.addBehavior(push)
            animator.addBehavior(collision)
            print ("")
        default:
            print ("")
        }
    }

}
