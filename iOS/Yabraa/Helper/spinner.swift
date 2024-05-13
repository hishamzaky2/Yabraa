//
//  Snpier.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/07/2023.
//

import Foundation
import RPCircularProgress

class spinner {
    
    lazy fileprivate var spinnerView: RPCircularProgress = {
        let progress = RPCircularProgress()
        progress.tag = 1010
        progress.progressTintColor = UIColor.mainColor
        progress.trackTintColor = UIColor.systemGray6
        progress.indeterminateDuration = 0.6
        progress.thicknessRatio = 0.3
        return progress
    }()
    
    func showAddedto(_ view:UIView) {
        
        spinnerView.enableIndeterminate()
        view.addSubview(spinnerView)
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinnerView.heightAnchor.constraint(equalToConstant: 40),
            spinnerView.widthAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    func hideFrom(_ view:UIView){
        let spinner = view.viewWithTag(1010)
        spinner?.removeFromSuperview()
    }
}
