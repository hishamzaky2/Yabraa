//
//  YBServicesDelegates.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import Foundation
extension YBServiceCheckingView {
    func didSelectDateAndTime(date: String, time: String) {
        self.viewModel?.selectedTime.accept(time)
        self.viewModel?.selectedDate.accept(date)
    }
}
