//
//  PackageFilterCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/06/2023.
//

import UIKit
import RxSwift
class PackageFilterCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var closeBTN: UIButton!
     let disposeBag = DisposeBag()
    override func layoutSubviews() {
        super.layoutSubviews()
//        containerView.addShadow(to: [.all],opacity: 1.0, color: UIColor.black.cgColor)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        filterTitle.adjustsFontSizeToFitWidth = true
    }

    func setUpCell(filter: Filters) {
        filterTitle.text = UserDefualtUtils.isArabic() ? filter.nameAR ?? "" : filter.nameEN ?? ""
        if filter.isSelected {
            containerView.backgroundColor = .mainColor
            filterTitle.textColor = .white
            closeBTN.isHidden = false
        }else {
            containerView.backgroundColor = .primaryColor
            filterTitle.textColor = .black
            closeBTN.isHidden = true
        }
        
    }
    
}
