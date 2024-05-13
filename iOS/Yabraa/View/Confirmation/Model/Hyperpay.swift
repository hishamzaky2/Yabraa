//
//  Hyperpay.swift
//  Yabraa
//
//  Created by Hamada Ragab on 01/08/2023.
//

import Foundation

class HyperPaymentManager {
    var checkoutId: String?
    var paymentMethod: String?
    init(checkoutId: String,paymentMethod:String) {
        self.checkoutId = checkoutId
        self.paymentMethod = paymentMethod
    }
    func paymentGatewayCheckoutSettings() -> OPPCheckoutSettings {
        let checkoutSettings = OPPCheckoutSettings.init()
        checkoutSettings.paymentBrands = [paymentMethod ?? ""]
        checkoutSettings.shopperResultURL = "com.Yabraa-Medical-Center.Yabraa.payments://result"
        checkoutSettings.displayTotalAmount = true
        let securityPolicyForTokens = OPPSecurityPolicy(forTokensWith: .deviceAuthNotRequired)
        checkoutSettings.language = UserDefualtUtils.getCurrentLanguage()
        checkoutSettings.theme.navigationBarBackgroundColor = .mainColor
        checkoutSettings.theme.confirmationButtonColor = .mainColor
        checkoutSettings.theme.accentColor = .mainColor
        checkoutSettings.theme.cellHighlightedBackgroundColor = .mainColor
        checkoutSettings.theme.sectionBackgroundColor = .mainColor.withAlphaComponent(0.05)
        let securityPolicyForPaymentBrands = OPPSecurityPolicy(paymentBrands: checkoutSettings.paymentBrands, mode: .deviceAuthNotRequired)
        checkoutSettings.securityPolicies = [securityPolicyForPaymentBrands,securityPolicyForTokens]
        return checkoutSettings
    }
    func configureCheckoutProvider() -> OPPCheckoutProvider? {
        guard let checkoutID = checkoutId else {return nil}
        let provider = OPPPaymentProvider(mode: OPPProviderMode.live)
        let checkoutSettings = paymentGatewayCheckoutSettings()
        if paymentMethod ?? "" == "APPLEPAY" {
            let paymentRequest = OPPPaymentProvider.paymentRequest(withMerchantIdentifier: "merchant.Yabraa.applePay", countryCode: "SA")
            paymentRequest.supportedNetworks = [.visa, .masterCard, .amex,.mada]
            paymentRequest.merchantCapabilities = .capability3DS
            checkoutSettings.applePayPaymentRequest = paymentRequest
            
        }
        return OPPCheckoutProvider(paymentProvider: provider, checkoutID: checkoutID, settings: checkoutSettings)
    }
}
