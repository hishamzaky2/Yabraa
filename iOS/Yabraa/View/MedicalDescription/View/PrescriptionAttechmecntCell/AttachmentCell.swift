//
//  AttachmentCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
protocol AttachmentCellProtocol: AnyObject {
    func didTapDwonload(filePath: String?)
}
class AttachmentCell: UITableViewCell {
    @IBOutlet weak var prescriptionCollectionView: UICollectionView!
    let attachments = PublishSubject<[VisitAttachments]>()
    private let disposeBag = DisposeBag()
    var attachmentCellDelegate: AttachmentCellProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        setUpPrescriptionCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func registerCell() {
        prescriptionCollectionView.register(UINib(nibName: "PrescriptionAttechmecntCell", bundle: nil), forCellWithReuseIdentifier: "PrescriptionAttechmecntCell")
        prescriptionCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func setUpPrescriptionCollectionView() {
        attachments.bind(to: prescriptionCollectionView.rx.items(cellIdentifier: "PrescriptionAttechmecntCell",cellType: PrescriptionAttechmecntCell.self)){  index ,attachment, cell in
            cell.setUpCell(attachment: attachment)
            cell.downloadTapped = {
                self.attachmentCellDelegate?.didTapDwonload(filePath: attachment.path)
            }
        }.disposed(by: disposeBag)
    }
}
extension AttachmentCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 110)
    }
}
