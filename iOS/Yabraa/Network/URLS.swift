//
//  URLS.swift
//  Yabraa
//
//  Created by Hamada Ragab on 12/05/2023.
//URLS.PAYMENT

import Foundation
class URLS {
    // live url
    static let BASE_URL = "http://yabraa-001-site1.anytempurl.com/api/"
//    static let BASE_URL = "http://yabraa-001-site2.anytempurl.com/api/"
    static let GALLERY = BASE_URL + "Gallery"
    static let FORGET_PASSWORD = BASE_URL + "Auth/forgotpassword"
    static let LOGIN = BASE_URL + "Auth/login"
    static let REGISTER = BASE_URL + "Auth/register"
    static let NATIONALITIES = BASE_URL + "Auth/PrepareRegistration"
    static let START_PAGES = BASE_URL + "StartPages"
    static let RESET_PASSWORD = BASE_URL + "Auth/ResetPassword"
    static let SERVICES_DETAILS = BASE_URL + "Services/servicesDetails?serviceTypeId="
    static let SERVICES_DATES = BASE_URL + "Services/getDates"
    static let PAYMENT = BASE_URL + "Payment/GetCheckoutId"
    static let PAYMENT_STATUS = BASE_URL + "Payment/GetCheckoutStatus?CheckoutId="
    static let userFamily = BASE_URL + "UserFamily"
    static let userInfo = BASE_URL + "auth/GetUserInformation"
    static let eidtUserInfo = BASE_URL + "auth/EditeAccount"
    static let deleteAccount = BASE_URL + "auth/DeleteAccount"
    static let myappointments = BASE_URL + "Appointment/GetAppointmentsByUser"
    static let appointmentDetails = BASE_URL + "Appointment/GetAppointmentDetailsByAppointmentId?AppointmentId="
    static let updateAppointments = BASE_URL + "Appointment/Edit"
    static let paymentHistory = BASE_URL + "Payment/HistoryPayment"
    static let UserValidation = BASE_URL + "auth/userInputsValidation"
    static let PaymentsMethods = BASE_URL + "Payment/GetPaymentMethods"
    static let GetAllergies = BASE_URL + "Allergies/GetAllergies"
    static let GetChronicDiseases = BASE_URL + "ChronicDiseases/GetChronicDiseases"
    static let GetCurrentMedications = BASE_URL + "Medication/GetMedications"
    static let GetInjuries = BASE_URL + "Injuries/GetInjuries"
    static let GetPastMedications = BASE_URL + "Medication/GetMedications"
    static let GetSurgeries = BASE_URL + "Surgeries/GetSurgeries"
    
    static let GetUserAllergies = BASE_URL + "Allergies/GetAllergiesUser?UserFamilyId="
    static let GetUserChronicDiseases = BASE_URL + "ChronicDiseases/GetChronicDiseasesUser?UserFamilyId="
    static let GetUserCurrentMedications = BASE_URL + "Medication/GetCurrentMedicationsUser?UserFamilyId="
    static let GetUserInjuries = BASE_URL + "Injuries/GetInjuriesUser?UserFamilyId="
    static let GetUserPastMedications = BASE_URL + "Medication/GetPastMedicationsUser?UserFamilyId="
    static let GetUserSurgeries = BASE_URL + "Surgeries/GetSurgeriesUser?UserFamilyId="
    
    static let AddAllergies = BASE_URL + "Allergies/AddAllergyUser?"
    static let AddChronicDiseases = BASE_URL + "ChronicDiseases/AddChronicDiseaseUser?"
    static let AddCurrentMedications = BASE_URL + "Medication/AddCurrentMedicationUser?"
    static let AddInjuries = BASE_URL + "Injuries/AddInjuryUser?"
    static let AddPastMedications = BASE_URL + "Medication/AddPastMedicationUser?"
    static let AddSurgeries = BASE_URL + "Surgeries/AddSurgeryUser?"
    
    static let DeleteAllergies = BASE_URL + "Allergies/DeleteAllergyUser?"
    static let DeleteChronicDiseases = BASE_URL + "ChronicDiseases/DeleteChronicDiseaseUser?"
    static let DeleteCurrentMedications = BASE_URL + "Medication/DeleteCurrentMedicationUser?"
    static let DeleteInjuries = BASE_URL + "Injuries/DeleteInjuryUser?"
    static let DeletePastMedications = BASE_URL + "Medication/DeletePastMedicationUser?"
    static let DeleteSurgeries = BASE_URL + "Surgeries/DeleteSurgeryUser?"
    static let cancelAppointment = BASE_URL + "Appointment/CancelAppointment?AppointmentId="
    static let PrescriptionDetails = BASE_URL + "Appointment/GetAppointmentDetailsByAppointmentId?AppointmentId="
    static let sendFirebaseToken = BASE_URL + "Payment/FirebaseTest"
    static let Notifications = BASE_URL + "Notification/GetNotifications?pageSize=10&pageNumber="
    static let ReadNotification = BASE_URL + "Notification/ReadNotification?notificationId="
}
