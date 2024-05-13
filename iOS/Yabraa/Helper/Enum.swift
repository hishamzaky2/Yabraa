//
//  Enum.swift
//  Yabraa
//
//  Created by Hamada Ragab on 28/02/2023.
//

import Foundation
enum BtnType {
    case radio
    case checkBox
}
enum ErrorStatus: String, Error {
    case NoInternet = "No Internet Connection"
    case InvalidUrl = "The Requested Url Is Invalid"
    case ValidationError = "Validation Error"
    case UnexpectedError = "Unexpected Error Please try again Later"
    case ParsingError = "Error When Parsing Data"
    
}


enum HttpMethod: String {
    case POST = "Post"
    case GET = "Get"
    case DELETE = "Delete"
    case PUT = "Put"
    
}
enum ToastStatus: String {
    case ERROR = "error"
    case WARING = "waring"
    case SUCCESS = "success"
    case INFO = "info"
}

enum Diseases: String {
    case Allergies = "Allergies"
    case ChronicDiseases = "Chronic Diseases"
    case CurrentMedications = "Current Medications"
    case Injuries = "Injuries"
    case PastMedications = "Past Medications"
    case Surgeries = "Surgeries"
}
enum PaymentCodeStatus {
    case success
    case reject
    case decline
    case cancel
    case unknown
}
