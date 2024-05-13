//
//  ViewExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import UIKit

extension UIView {

    class var identifier: String {
        return String(describing: self)
    }
    
    class var estimatedHeight: CGFloat {
        guard let view = UIView().viewFromNib(String(describing: self)) else { return 0 }
        let height = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return height
    }

    /// shadow alpha
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    func viewFromNib(_ nibName: String) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return nil
        }
        return view
    }
    /// gets nib's class name and init nib from it
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    /// add radius to view
    func addCornerRadius() {
        self.layer.cornerRadius = self.frame.size.height / 2
    }
   
    /// animatly push view from bottom
    func pushTopTransition(_ duration: CFTimeInterval) {

        let animation: CATransition = CATransition()

        animation.timingFunction = CAMediaTimingFunction(name:
                CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    /// animatly hide view with pushing down
    func pushBottomTransition(_ duration: CFTimeInterval) {

        let animation: CATransition = CATransition()

        animation.timingFunction = CAMediaTimingFunction(name:
                CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
   
}

extension UIView {
    // MARK: - Load
    func xibSetup() {
        let nib = UINib(nibName: Self.identifier, bundle: nil)
        guard let mainView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        mainView.backgroundColor = .clear
        mainView.layoutIfNeeded()
        fitView(mainView)
        layoutIfNeeded()
    }
    
    func fitView(_ view: UIView, inset: UIEdgeInsets = .zero, fromSafeArea: Bool = false, animated: Bool = false) {
//        DispatchQueue.main.async {
            self.addSubview(view)
            let safe = self.safeAreaLayoutGuide
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: fromSafeArea ? safe.topAnchor : self.topAnchor, constant: inset.top).isActive = true
            view.bottomAnchor.constraint(equalTo: fromSafeArea ? safe.bottomAnchor : self.bottomAnchor, constant: -inset.bottom).isActive = true
            view.leadingAnchor.constraint(equalTo: fromSafeArea ? safe.leadingAnchor : self.leadingAnchor, constant: inset.left).isActive = true
            view.trailingAnchor.constraint(equalTo: fromSafeArea ? safe.trailingAnchor : self.trailingAnchor, constant: -inset.right).isActive = true
//        }
        
        if animated {
            view.alpha = 0

            UIView.animate(withDuration: 0.25) {
                view.alpha = 1
            }
        }
    }

    func removeSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    func add(target: Any?, action: Selector?) {
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Shadow
}

extension UIView {
    /// Constrain 4 edges of `self` to specified `view`.
    func edges(to view: UIView, top: CGFloat=0, left: CGFloat=0, bottom: CGFloat=0, right: CGFloat=0) {
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom)
            ])
    }
    
    func setAnimationSeldcted(){
        UIView.animate(withDuration: 0.5) {
            
            self.backgroundColor = #colorLiteral(red: 0.01568627451, green: 0.2705882353, blue: 0.337254902, alpha: 1)
        }
        
    }
    
    func removeAnimationSelected(){
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
   
   }
extension UIView{
@IBInspectable
   var cornerRadius: CGFloat {
       get {
           return layer.cornerRadius
       }
       set {
           layer.cornerRadius = newValue
            layer.masksToBounds = true
            
       }
   }

   @IBInspectable
   var borderWidth: CGFloat {
       get {
           return layer.borderWidth
       }
       set {
           layer.borderWidth = newValue
       }
   }

   @IBInspectable
   var borderColor: UIColor? {
       get {
           let color = UIColor.init(cgColor: layer.borderColor!)
           return color
       }
       set {
           layer.borderColor = newValue?.cgColor
       }
   }

   @IBInspectable
   var shadowRadius: CGFloat {
       get {
           return layer.shadowRadius
       }
       set {

           layer.shadowRadius = shadowRadius
       }
   }
   @IBInspectable
   var shadowOffset : CGSize{

       get{
           return layer.shadowOffset
       }set{

           layer.shadowOffset = newValue
       }
   }

   @IBInspectable
   var shadowColor : UIColor{
       get{
           return UIColor.init(cgColor: layer.shadowColor!)
       }
       set {
           layer.shadowColor = newValue.cgColor
            layer.shadowOpacity = 0.5
       }
   }
    
}
extension UIView {
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 3.0, opacity: Float = 0.1, color: CGColor = UIColor.black.cgColor) {

        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity
            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
        }
    }

    func removeAllShadows() {
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    func dropShadow() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2
    }
    func addShadowToAllEdges(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
    }
}
