//
//  ServicesFilterCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import UIKit
import RxCocoa
import RxSwift
class ServicesFilterCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterTitle: UILabel!
    @IBOutlet weak var closeBTN: UIButton!
     let disposeBag = DisposeBag()

    override var isSelected: Bool {
        didSet {
            if isSelected{
                containerView.backgroundColor = .mainColor
                filterTitle.textColor = .white
            }else {
                containerView.backgroundColor = .primaryColor
                filterTitle.textColor = .black
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpCell(filter: Filters) {
        filterTitle.text = UserDefualtUtils.isArabic() ? filter.nameAR ?? "" : filter.nameEN ?? ""
       
    }
    
    @IBAction func DeSelectTapped(_ sender: Any) {
//        self.delegate?.didTapOnClose()
    }
    
}
