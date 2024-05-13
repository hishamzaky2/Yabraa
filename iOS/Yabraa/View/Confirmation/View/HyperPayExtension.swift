//
//  HyperPayExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 01/08/2023.
//

import Foundation
import SafariServices

extension YBConfirmationView:OPPCheckoutProviderDelegate,SFSafariViewControllerDelegate{
    func handleTransactionSubmission(transaction: OPPTransaction?, error: Error?) {
        guard let transaction = transaction else {
            showMessage(message:  error?.localizedDescription ?? "")
            return
        }
        
        self.transaction = transaction
        if transaction.type == .synchronous {
            self.requestPaymentStatus(PaymentMethodId: paymentMethodID)
        } else if transaction.type == .asynchronous {
            NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
            
        } else {
            showMessage(message: "Invalid transaction")
//            FPGToaster.showErrorMessage(message: "Invalid transaction")
        }
    }
    func requestPaymentStatus(PaymentMethodId: Int?) {
        if let checkOutId = checkOutId,let PaymentMethodId = PaymentMethodId{
            viewModel?.isLoading.accept(true)
            let url = URLS.PAYMENT_STATUS + checkOutId + "&PaymentMethodId=\(PaymentMethodId)" + "&FirebaseToken=\(UserDefualtUtils.getFirebaseToken())"
            NetworkServices.callAPI(withURL: url, responseType:BasicResponse<PaymentStatus>.self, method: .GET, parameters: nil).subscribe(onNext: {[weak self] response in
                self?.viewModel?.isLoading.accept(false)
               
                if  let isTransactionSuccess = self?.viewModel?.checkIfTransactionStatusCode(code: response.data?.code ?? ""), isTransactionSuccess == true {
                    self?.displayAlert(icon: .SUCCESS, message: "payment Done".localized, OkAction: {
                        self?.viewModel?.removeSelectedPackages()
                        self?.router?.backToHome()
                    })
                }else if let errorMessage = response.errorMessageAr, !errorMessage.isEmpty{
                    self?.showMessage(message:errorMessage)
                }
                else {
                    self?.showMessage(message: "We're sorry, but your payment transaction has failed.try again ".localized)
                }
            },onError: {error in
                self.viewModel?.isLoading.accept(false)
                self.showMessage(message: error.localizedDescription)
            }).disposed(by: disposeBag)
            self.transaction = nil
            
        }
    }
    
    
    // MARK: - OPPCheckoutProviderDelegate methods
    // This method is called right before submitting a transaction to the Server.
    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, continueSubmitting transaction: OPPTransaction, completion: @escaping (String?, Bool) -> Void) {
        completion(transaction.paymentParams.checkoutID, false)
    }
    func checkoutProviderDidFinishSafariViewController(_ checkoutProvider: OPPCheckoutProvider) {
        print("Did finish saferi")
    }
    // MARK: - Async payment callback
    
    @objc func didReceiveAsynchronousPaymentCallback() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        self.checkoutProvider?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
                self.requestPaymentStatus(PaymentMethodId: self.paymentMethodID)
            }
        }
    }
    private func showMessage(message: String) {
       displayAlert(icon: .ERROR, message: message, OkAction: nil)
    }
// MARK: APPle Pay
    func checkoutProvider(_ checkoutProvider: OPPCheckoutProvider, applePayDidAuthorizePayment payment: PKPayment, handler completion: @escaping (OPPApplePayRequestAuthorizationResult) -> Void) {
        completion(.init(status: .success, errors: []))
        print(payment)
    }
}
