//
//  BKCheckbox.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import Foundation
import UIKit

@IBDesignable
public class Checkbox: UIButton {
    var path : UIBezierPath!
    var shapeLayer: CAShapeLayer!
    var wasSelected = false
    var btnType : BtnType = .radio {
        didSet {
            customInitialization()
        }
    }
    internal var outerCircleLayer = CAShapeLayer()
    internal var innerCircleLayer = CAShapeLayer()
    
    @IBInspectable public var outerCircleColor: UIColor = UIColor.green {
        didSet {
            outerCircleLayer.strokeColor = outerCircleColor.cgColor
        }
    }
    @IBInspectable public var innerCircleCircleColor: UIColor = UIColor.green {
        didSet {
            setFillState()
        }
    }
    
    @IBInspectable public var outerCircleLineWidth: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    @IBInspectable public var innerCircleGap: CGFloat = 3.0 {
        didSet {
            setCircleLayouts()
        }
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        customInitialization()
        
    }
    // MARK: Initialization
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInitialization()
    }
    
    
    internal var setCircleRadius: CGFloat {
        let width = bounds.width
        let height = bounds.height
        
        let length = width > height ? height : width
        return (length - outerCircleLineWidth) / 2
    }
    
    private var setCircleFrame: CGRect {
        let width = bounds.width
        let height = bounds.height
        
        let radius = setCircleRadius
        let x: CGFloat
        let y: CGFloat
        
        if width > height {
            y = outerCircleLineWidth / 2
            x = (width / 2) - radius
        } else {
            x = outerCircleLineWidth / 2
            y = (height / 2) - radius
        }
        
        let diameter = 2 * radius
        return CGRect(x: x, y: y, width: diameter, height: diameter)
    }
    
    private var circlePath: UIBezierPath {
        if btnType == .checkBox {
            return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: 0)
        }
        return UIBezierPath(roundedRect: setCircleFrame, cornerRadius: setCircleRadius)
    }
    
    private var fillCirclePath: UIBezierPath {
        let trueGap = innerCircleGap + (outerCircleLineWidth / 2)
        if btnType == .checkBox {
            return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: 0)
        }
        return UIBezierPath(roundedRect: setCircleFrame.insetBy(dx: trueGap, dy: trueGap), cornerRadius: setCircleRadius)
        
    }
    
    private func initShapeLayer() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: points(3.5), y: points(8.5)))
        path.addLine(to: CGPoint(x: points(7.5), y: points(12.5)))
        path.addLine(to: CGPoint(x: points(14.5), y: points(5.5)))
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        shapeLayer.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeLayer.lineWidth = 2
        
        shapeLayer.path = path.cgPath
    }
    
    private func check() {
        self.layer.addSublayer(shapeLayer)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.duration = 0.35
        shapeLayer.add(animation, forKey: "LineAnimation")
    }
    
    private func removeCheck() {
        if shapeLayer != nil {
            if btnType == .checkBox {
                shapeLayer.removeFromSuperlayer()
            }
        }
    }
    
    private func points(_ number: CGFloat) -> CGFloat {
        return bounds.width * number / 18
    }
    
    private func customInitialization() {
        initShapeLayer()
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.fillColor = UIColor.clear.cgColor
        outerCircleLayer.strokeColor = outerCircleColor.cgColor
        layer.addSublayer(outerCircleLayer)
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.fillColor = UIColor.clear.cgColor
        innerCircleLayer.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(innerCircleLayer)
        
        if btnType == .radio {
            self.innerCircleGap = 3
        } else {
            self.innerCircleGap = 0
        }
        
    }
    
    private func setCircleLayouts() {
        outerCircleLayer.frame = bounds
        outerCircleLayer.lineWidth = outerCircleLineWidth
        outerCircleLayer.path = circlePath.cgPath
        
        innerCircleLayer.frame = bounds
        innerCircleLayer.lineWidth = outerCircleLineWidth
        innerCircleLayer.path = fillCirclePath.cgPath
    }
    
    // MARK: Custom
    private func setFillState() {
        if self.isSelected {
            if btnType == .checkBox {
                if !wasSelected {
                    check()
                } else {
                    self.layer.addSublayer(shapeLayer)
                }
            }
            innerCircleLayer.fillColor = outerCircleColor.cgColor
        } else {
            if btnType == .checkBox {
                removeCheck()
            }
            innerCircleLayer.fillColor = UIColor.clear.cgColor
        }
    }
    // Overriden methods.
    override public func prepareForInterfaceBuilder() {
        customInitialization()
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        setCircleLayouts()
    }
    override public var isSelected: Bool {
        didSet {
            setFillState()
        }
    }
}
