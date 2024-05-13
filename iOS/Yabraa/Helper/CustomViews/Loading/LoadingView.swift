//
//  LoadingView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/04/2023.
//

import Foundation
import UIKit
class CircleLoadingView: UIView {
    private let circleLayer = CAShapeLayer()
    private let animationDuration: CFTimeInterval = 0.6
    private var isAnimating = false
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLoader()
    }
    
    private func setupLoader() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - 2
        
        // Create the path for the outer circle
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi - CGFloat.pi / 2, clockwise: true)
        
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.mainColor.cgColor
        circleLayer.lineWidth = 3.4
        circleLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleLayer)
    }
    
    func startAnimating() {
        if isAnimating {
            // If the animation is already running, return
            return
        }
        
        isAnimating = true
        
        let circleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circleAnimation.duration = animationDuration
        circleAnimation.fromValue = 0.0
        circleAnimation.toValue = 1.0
        circleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        circleAnimation.repeatCount = .infinity
        circleLayer.add(circleAnimation, forKey: "circleAnimation")
        
        // Set the animation speed to 1 to resume the paused animation
        circleLayer.speed = 1
    }
    
    func stopAnimating() {
        if !isAnimating {
            // If the animation is not running, return
            return
        }
        
        isAnimating = false
        
        // Set the animation speed to 0 to pause the animation
        circleLayer.speed = 0
    }
}
