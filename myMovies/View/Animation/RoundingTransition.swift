//
//  RoundingTransition.swift
//  myMovies
//
//  Created by Raman Kozar on 14/07/2023.
//

import Foundation
import UIKit

class RoundingTransition: NSObject {
    
    // Animation properties
    
    // View of the round
    var round = UIView()
    
    // Coordinates
    var start = CGPoint.zero {
        didSet {
            round.center = start
        }
    }
    
    // Color of the round (default)
    var roundColor = UIColor.red
    
    // Animation duration
    var time = 0.55
    
    // Conditions of the animation
    enum RoundingTransitionProfile: Int {
        case show
        case cancel
        case pop
    }
    
    // Working condition
    var transitionProfile: RoundingTransitionProfile = .show
    
}

extension RoundingTransition: UIViewControllerAnimatedTransitioning {
    
    // Method for getting duration
    //
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return time
    }
    
    // Method for transition
    //
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        if transitionProfile == .show {
            
            if let showedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                
                let viewCenter = showedView.center
                let viewSize = showedView.frame.size
                
                round = UIView()
                round.frame = roundFrame(withViewCenter: viewCenter, size: viewSize, startPoint: start)
                
                round.layer.cornerRadius = round.frame.size.height / 2
                round.center = start
                round.backgroundColor = roundColor
                round.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                container.addSubview(round)
                
                showedView.center = start
                showedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                showedView.alpha = 0
                container.addSubview(showedView)
                
                UIView.animate(withDuration: time, animations: {
                    
                    self.round.transform = CGAffineTransform.identity
                    
                    showedView.transform = CGAffineTransform.identity
                    showedView.alpha = 1
                    showedView.center = viewCenter
                    
                }, completion: {(success: Bool) in
                    transitionContext.completeTransition(success)
                })
                
            }
            
        } else {
         
            let transitionModeKey = (transitionProfile == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returnableView = transitionContext.view(forKey: transitionModeKey) {
                
                let viewCenter = returnableView.center
                let viewSize = returnableView.frame.size
                
                round.frame = roundFrame(withViewCenter: viewCenter, size: viewSize, startPoint: start)
                
                round.layer.cornerRadius = round.frame.size.height / 2
                round.center = start
                
                UIView.animate(withDuration: time, animations: {
                    
                    self.round.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    
                    returnableView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returnableView.center = self.start
                    returnableView.alpha = 0
                    
                    if self.transitionProfile == .pop {
                        
                        container.insertSubview(returnableView, belowSubview: returnableView)
                        container.insertSubview(self.round, belowSubview: returnableView)
                        
                    }
                    
                }, completion: {(success: Bool) in
                    
                    returnableView.center = viewCenter
                    returnableView.removeFromSuperview()
                    
                    self.round.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                    
                })
                
            }
            
        }
        
    }
    
    // Method for round frame
    //
    func roundFrame(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
}
