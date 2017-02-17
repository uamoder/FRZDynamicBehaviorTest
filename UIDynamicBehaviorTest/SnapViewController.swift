//
//  SnapViewController.swift
//  FRZUIDynamicBehaviorTest
//
//  Created by Alex Neminsky on 27.01.17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {

    // MARK: - Variables
    lazy var box: UIView = {
        let view = UIView(frame: CGRect(x: 140, y: 100, width: 80, height: 80))
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
    
    lazy var snap: UISnapBehavior = {
        UISnapBehavior(item: self.box, snapTo: CGPoint(x: 0, y: 0))
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
        
        switch pan.state {
        case .began, .cancelled:
            animator.removeAllBehaviors()
            UIView.animate(withDuration: 0.1, animations: {
                self.box.center = point
            })
            print ("")
        case .changed:
            box.center = point
            print ("")
        case .ended:
            animator.removeAllBehaviors()
            let size = view.frame.size
            let left = point.x
            let right = size.width - point.x
            let bottom = size.height - point.y
            let edge: CGFloat = 100
            let edgeToCenterW = edge + box.bounds.size.width / 2
            let edgeToCenterH = edge + box.bounds.size.height / 2
            var newPoint: CGPoint?
            
            if left < edgeToCenterW {
                newPoint = CGPoint(x: box.bounds.size.width / 2, y: point.y)
            }
            
            if right < edgeToCenterW {
                newPoint = CGPoint(x: size.width - box.bounds.size.width / 2, y: point.y)
            }
            
            if bottom < edgeToCenterH {
                newPoint = newPoint != nil ? CGPoint(x: newPoint!.x, y: size.height - box.bounds.size.height / 2) : CGPoint(x: point.x, y: size.height - box.bounds.size.height / 2)
            }
            
            if let newPoint = newPoint {
                snap.snapPoint = newPoint
                snap.damping = 0.77
                animator.addBehavior(snap)
            }
            
            print ("")
        default:
            print ("")
        }
    }

}
