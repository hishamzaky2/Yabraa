//
//  MedicalDescriptionViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/11/2023.
//

import Foundation
import RxSwift
import RxCocoa
class MedicalDescriptionViewModel {
    private let disposeBag = DisposeBag()
    let isLoading = PublishSubject<Bool>()
    let didDownloadFile = PublishSubject<URL?>()
    let prescription = PublishSubject<PrescriptionResponse>()
    let noDataFound = PublishSubject<Bool>()
    private var _tableViewDataSources: BehaviorSubject<[PrescriptionDataSource]> = BehaviorSubject(value: [])
    
    var tableViewDataSources: SharedSequence<DriverSharingStrategy, [PrescriptionDataSource]> {
        return _tableViewDataSources.asDriver(onErrorJustReturn: [])
    }
    private var appointmentId: Int
    init(appointmentId: Int) {
        self.appointmentId = appointmentId
    }
    func viewDidLoad() {
        getPrescription()
    }
    private func getPrescription() {
        isLoading.onNext(true)
        let url = URLS.PrescriptionDetails + String(appointmentId)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<PrescriptionResponse>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.onNext(false)
            if let statusCode = response.statusCode, statusCode == 200, let prescription = response.data  {
                self?.didGetPrescriptionData(prescription: prescription)
                
            }else {
                self?.noDataFound.onNext(true)
                print(response.error ?? "")
            }
        },onError: {error in
            self.isLoading.onNext(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func didGetPrescriptionData(prescription:PrescriptionResponse) {
        var sections: [PrescriptionDataSource] = []
        self.prescription.onNext(prescription)
        if let attachments = prescription.visitAttachments, !attachments.isEmpty{
            sections.append(PrescriptionDataSource.Attachments(title: "Attachments", items: [.Attachments(attachments)]))
        }
        if let notes = prescription.visitNotes, !notes.isEmpty {
            for note in notes {
                sections.append(PrescriptionDataSource.Notes(title: "Notes", items: [.Notes(note)]))
            }
        }
        if sections.isEmpty {
            noDataFound.onNext(true)
        }else {
            self._tableViewDataSources.onNext(sections)
        }
    }
    func downloadFile(filePath: String?) {
        guard let filePath = filePath, let fileUrl = URL(string: filePath) else {return}
        isLoading.onNext(true)
        URLSession.shared.downloadTask(with: fileUrl) { location, response, error in
            self.isLoading.onNext(false)
            guard let location = location, let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else { return }
            let fileName = httpURLResponse.suggestedFilename ?? httpURLResponse.url?.lastPathComponent ?? fileUrl.lastPathComponent
            let destination = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            do {
                if FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }
                try FileManager.default.moveItem(at: location, to: destination)
                self.didDownloadFile.onNext(destination)
            } catch {
                print(error)
            }
        }.resume()
    }
}
