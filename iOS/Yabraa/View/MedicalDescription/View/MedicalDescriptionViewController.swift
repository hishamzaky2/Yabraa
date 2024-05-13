//
//  MedicalDescriptionViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MedicalDescriptionViewController: UIViewController {
    @IBOutlet weak var noMedicalFileFound: UIView!
    @IBOutlet weak var packageName: UILabel!
    @IBOutlet weak var prescriptionTable: UITableView!
    @IBOutlet weak var backBTN: UIButton!
    
    var router: MedicalDescriptionRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: MedicalDescriptionViewModel?
    var documentController: UIDocumentInteractionController?
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        bindprescriptionTableViewData()
        didDownloadFile()
        bindButtonActions()
        registerCell()
        setUpUi()
        viewModel?.viewDidLoad()
    }
    private func bindprescriptionTableViewData() {
        let dataSource = dataSource()
        viewModel?
            .tableViewDataSources
            .drive(prescriptionTable.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    private func bindData() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {[weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
        viewModel?.prescription.map{
            return UserDefualtUtils.isArabic() ? ($0.packageNameAR ?? "") : ($0.packageNameEN ?? "")
        }.bind(to: packageName.rx.text).disposed(by: disposeBag)
        viewModel?.noDataFound.asDriver(onErrorJustReturn: false).drive(onNext: { [weak self] noData in
            self?.prescriptionTable.isHidden = noData
            self?.noMedicalFileFound.isHidden = !noData
        }).disposed(by: disposeBag)
    }
    func dataSource() -> RxTableViewSectionedReloadDataSource<PrescriptionDataSource> {
        return RxTableViewSectionedReloadDataSource<PrescriptionDataSource>(
            configureCell: { dataSource, tableView, indexPath, _ in
                switch dataSource[indexPath] {
                case let .Attachments(attachments:attachments):
                    return self.setUpAttachmentCell(attachments: attachments)
                case let.Notes(note: note):
                    return self.setUpNotesrCell(note: note)
                }
            }, titleForHeaderInSection: { dataSource, index in
                return ""
            })
    }
    private func setUpAttachmentCell(attachments: [VisitAttachments])-> AttachmentCell {
        let cell = prescriptionTable.dequeueReusableCell(withIdentifier: "AttachmentCell") as! AttachmentCell
        cell.attachmentCellDelegate = self
//        viewModelr?.prescription.map{$0}
        cell.attachments.onNext(attachments)
        return cell
    }
    private func setUpNotesrCell(note: VisitNotes)-> PrescriptionNoteCell {
        let cell = prescriptionTable.dequeueReusableCell(withIdentifier: "PrescriptionNoteCell") as! PrescriptionNoteCell
        cell.setUpCell(note: note)
        return cell
    }
    private func bindButtonActions() {
        backBTN.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.back()
        }).disposed(by: disposeBag)
    }
    private func didDownloadFile() {
        viewModel?.didDownloadFile.asDriver(onErrorJustReturn: nil).drive(onNext: { [weak self] fileUrl in
            guard let fileUrl = fileUrl else {return}
            self?.openDocument(at: fileUrl)
        }).disposed(by: disposeBag)
    }
    private func openDocument(at url: URL) {
        guard let url = URL(string: url.absoluteString) else {return}
        documentController = UIDocumentInteractionController(url: url)
        documentController?.delegate = self
        documentController?.presentPreview(animated: true)
    }
    private func setUpUi() {
        backBTN.imageView?.FlipImage()
    }
    private func registerCell() {
        prescriptionTable.register(UINib(nibName: "AttachmentCell", bundle: nil), forCellReuseIdentifier: "AttachmentCell")
        prescriptionTable.register(UINib(nibName: "PrescriptionNoteCell", bundle: nil), forCellReuseIdentifier: "PrescriptionNoteCell")
        prescriptionTable.rx.setDelegate(self).disposed(by: disposeBag)
    }

   
    
}
extension MedicalDescriptionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension MedicalDescriptionViewController:UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    private func documentInteractionControllerViewForPreview(controller: UIDocumentInteractionController!) -> UIView! {
        return self.view
    }
    
    func documentInteractionControllerRectForPreview(_ controller: UIDocumentInteractionController) -> CGRect {
        return self.view.frame
    }
}

extension MedicalDescriptionViewController:AttachmentCellProtocol{
    func didTapDwonload(filePath: String?) {
        viewModel?.downloadFile(filePath: filePath)
    }
}
