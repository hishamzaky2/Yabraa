//
//  DiseasesCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 09/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
class DiseasesCell: UITableViewCell {

    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var diseaseName: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var addView: UIView!
    private let disposeBag = DisposeBag()
    var deleteTapped: (()->())?
    var addTapped: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        bindButtonsAction()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func bindButtonsAction() {
        deleteBtn.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.deleteTapped?()
        }).disposed(by: disposeBag)
        addBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.addTapped?()
        }).disposed(by: disposeBag)
    }
    func setUpCell(diseasesData: DiseasesData) {
        diseaseName.text = UserDefualtUtils.isArabic() ? diseasesData.titleAR : diseasesData.titleEN
        if diseasesData.isAdded {
            deleteView.isHidden = false
            addView.isHidden = true
        }else {
            deleteView.isHidden = true
            addView.isHidden = false
        }
    }
}
