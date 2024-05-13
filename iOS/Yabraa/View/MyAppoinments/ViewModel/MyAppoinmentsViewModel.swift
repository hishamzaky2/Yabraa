//
//  MyAppoinmentsViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 20/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
class MyAppoinmentsViewModel {
    let myAppointments = BehaviorRelay<[MyAppointments]>(value: [])
    let isLoading = PublishSubject<Bool>()
    let isFails = PublishSubject<String>()
    let didCancelAppointmentSuccessfully = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    init() {
       
    }
    func viewDidLoad() {
        getMyAppointments()
        observeDidEditAppointment()
    }
    private func getMyAppointments() {
        isLoading.onNext(true)
        NetworkServices.callAPI(withURL: URLS.myappointments, responseType:BasicResponse<[MyAppointments]>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.didGetAppointments(appointments: response)
        },onError: {error in
            self.isLoading.onNext(false)
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    private func didGetAppointments(appointments:BasicResponse<[MyAppointments]>) {
        isLoading.onNext(false)
        if appointments.statusCode ?? 0 == 200 {
            let myAppointment = appointments.data ?? []
            myAppointments.accept(Array(myAppointment))
        }else {
            print(appointments.error ?? "")
        }
    }
    private func observeDidEditAppointment() {
        let notificationName = Notification.Name("DID_UPDATE_Appointment")
        NotificationCenter.default.rx.notification(notificationName)
            .subscribe(onNext: { notification in
                self.getMyAppointments()
            })
            .disposed(by: disposeBag)
    }
    func cancelAppointMent(at index: Int) {
        
        guard let canceledPackage = myAppointments.value[index].appointmentId else {return}
        isLoading.onNext(true)
        let url = URLS.cancelAppointment + String(canceledPackage) + "&FirebaseToken=\(UserDefualtUtils.getFirebaseToken())"
        NetworkServices.callAPI(withURL: url, responseType: MyAppointments.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.didCancelAppointment(at: index)
        },onError: { [weak self]error in
            self?.isLoading.onNext(false)
            self?.isFails.onNext(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func didCancelAppointment(at index: Int) {
        isLoading.onNext(false)
        var appointments = self.myAppointments.value
        appointments[index].status = "Canceled"
        self.myAppointments.accept(appointments)
        didCancelAppointmentSuccessfully.onNext(())
    }
}
