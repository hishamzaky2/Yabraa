//
//  EditMyAppointmentViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
class EditMyAppointmentViewModel {
    let appointment = BehaviorRelay<Appointment?>(value: nil)
    let appointmentLat = BehaviorRelay<Double?>(value: 0.0)
    let appointmentLng = BehaviorRelay<Double?>(value: 0.0)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    let didUpdateAppointment = PublishRelay<Void>()
    let didFailsUpdateAppointment = PublishRelay<String>()
    init(appointmentId: Int?) {
        if let appointmentId = appointmentId{
            getUpadtedAppointment(AppointmentId: appointmentId)
        }
    }
    private func getUpadtedAppointment(AppointmentId: Int) {
        self.isLoading.accept(true)
        let url = URLS.appointmentDetails + String(AppointmentId)
        NetworkServices.callAPI(withURL: url, responseType:BasicResponse<Appointment>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
            self?.isLoading.accept(false)
            if response.statusCode ?? 0 == 200 {
                self?.appointment.accept(response.data)
                self?.appointmentLat.accept(response.data?.locationLatitude)
                self?.appointmentLng.accept(response.data?.locationLongitude)
            }else {
                print(response.error ?? "")
            }
        },onError: {error in
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    func editAppointMent(notes: String){
        self.isLoading.accept(true)
        if let apppointment = appointment.value {
            let parameters =  EditAppointmentRequest(appointmentId: apppointment.appointmentId ?? 0, locatioLongitude: appointmentLng.value!, locationLatitude: appointmentLat.value! , locatioAltitude: appointmentLng.value!, notes: notes)
            NetworkServices.callAPI(withURL: URLS.updateAppointments, responseType:BasicResponse<Appointment>.self, method: .PUT, parameters: parameters.toJosn()).subscribe(onNext: {[weak self] response in
                self?.isLoading.accept(false)
                if response.statusCode ?? 0 == 200 {
                    self?.didUpdateAppointment.accept(())
                }else {
                    self?.didFailsUpdateAppointment.accept(response.error ?? "")
                }
            },onError: {error in
                self.isLoading.accept(false)
                self.didFailsUpdateAppointment.accept(error.localizedDescription)
            }).disposed(by: disposeBag)
        }
    }
//    func didEditAppointment() {
//        let notificationName = Notification.Name("DID_UPDATE_Appointment")
//        NotificationCenter.default.post(name: notificationName, object: nil)
//    }
}
