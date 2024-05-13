//
//  PrescriptionAttechmecntCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
class PrescriptionAttechmecntCell: UICollectionViewCell {

    @IBOutlet weak var pathImage: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var downlaodBtn: UIButton!
    private let disposeBag = DisposeBag()
    var downloadTapped: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        bindButtonActions()
        setUpUi() 
        // Initialization code
    }
    private func setUpUi() {
        downlaodBtn.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    private func bindButtonActions() {
        downlaodBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.downloadTapped?()
        }).disposed(by: disposeBag)
    }
    func setUpCell(attachment: VisitAttachments) {
        titleLBL.text = attachment.title ?? ""
        if let fileUrl = URL(string: attachment.path ?? "") {
            checkFileType(from: fileUrl)
        }
    }
    func checkFileType(from url: URL) {
        let fileExtension = url.pathExtension.lowercased()
        switch fileExtension {
        case "pdf":
            pathImage.image = UIImage(named: "pdf")
        case "doc", "docx":
            pathImage.image = UIImage(named: "docx")
        default:
           break
        }
    }
}
