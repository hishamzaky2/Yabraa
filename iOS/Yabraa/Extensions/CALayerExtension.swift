//
//  CALayerExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 06/03/2023.
//

import UIKit

extension CALayer {
    
    func removeShadow() {
        self.shadowOpacity = 0
    }
    
    func shadow(color: UIColor, size: CGSize, radius: CGFloat, alpha: Float) {
        self.shadowColor = color.cgColor
        self.shadowOffset = size
        self.shadowRadius = radius
        self.shadowOpacity = alpha
        
    }
    
    func addDefaultShadow() {
        shadow(color: .black, size: CGSize(width: 0, height: 0), radius: 4, alpha: 0.2)
    }
    
    func addButtonShadow() {
        shadow(color: .lightGray, size: CGSize(width: 0, height: -3), radius: 2, alpha: 0.2)
    }
    
    func addOvalShadow(color: UIColor) {
    
        shadow(color: color, size: CGSize(width: 0, height: 3), radius: 15, alpha: 0.16)
        
        let space = frame.width * 0.1
        let contactWidth = frame.width * 0.8
        let contactRect = CGRect(x: space, y: 7, width: contactWidth, height: frame.height)
        
        self.shadowPath = UIBezierPath(rect: contactRect).cgPath
    }
    
    func addTabBarShadow() {
        shadow(color: .blue, size: CGSize(width: 0, height: -2), radius: 3, alpha: 0.5)
    }
    
    func addRoundedCorner(corner1: UIRectCorner, corner2: UIRectCorner, size: CGSize) {
        let rectShape = CAShapeLayer()
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [corner1 , corner2], cornerRadii: CGSize(width: size.width, height: size.height)).cgPath
        self.mask = rectShape
    }
    
    func addFeaturesShadow(){
        let shadowPath = UIBezierPath()
        
        shadow(color: .lightGray, size: .zero, radius: 10, alpha: 0.5)
        
        shadowPath.move(to: CGPoint(x: bounds.origin.x + 10, y: bounds.origin.y + 20))
        shadowPath.addLine(to: CGPoint(x: bounds.size.width - 10, y: bounds.origin.y + 20))
        shadowPath.addLine(to: CGPoint(x: bounds.size.width - 10, y: bounds.height))
        shadowPath.addLine(to: CGPoint(x: bounds.origin.x + 10, y: bounds.height))
        
        shadowPath.close()
        
        self.shadowPath = shadowPath.cgPath
    }
}
