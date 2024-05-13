//
//  DatesAndTimesViewModel.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import Foundation
import RxSwift
import RxCocoa


class DatesAndTimesViewModel {
    var dates: [DatesTimes] = []
    let times = BehaviorRelay<[Times]>(value: [])
    let allTimes = BehaviorRelay<[Times]>(value: [])
    let selectedDate = BehaviorRelay<DatesTimes?>(value: nil)
    let selectedTime = BehaviorRelay<Times?>(value: nil)
    var isDateAndTimeEntered: Observable<Bool>
    let didSelectDate = BehaviorRelay<DatesTimes?>(value: nil)
    
    let currentHourIndex = PublishSubject<IndexPath>()
    let currentDayAtMonthIndex = PublishSubject<IndexPath>()
    let filterDates = PublishSubject<[DatesTimes]>()
    var package: Packages?
    private let disposeBag = DisposeBag()
    private var CurrentHour: Int?
    private var CurrentMonthNumber: String?
    private var CurrentDayNumber: String?
    let hoursNameAr = [
        HourNameAr.am12, HourNameAr.am11, HourNameAr.am10, HourNameAr.am9, HourNameAr.am8, HourNameAr.am7,
        HourNameAr.am6, HourNameAr.am5, HourNameAr.am4, HourNameAr.am3, HourNameAr.am2, HourNameAr.am1,
        HourNameAr.pm12, HourNameAr.pm11, HourNameAr.pm10, HourNameAr.pm9, HourNameAr.pm8, HourNameAr.pm7,
        HourNameAr.pm6, HourNameAr.pm5, HourNameAr.pm4, HourNameAr.pm3, HourNameAr.pm2, HourNameAr.pm1
    ]
    let hoursNameEn = [
        HourNameEn.am12,HourNameEn.am1,HourNameEn.am2,HourNameEn.am3, HourNameEn.am4,HourNameEn.am5, HourNameEn.am6,HourNameEn.am7,HourNameEn.am8,HourNameEn.am9,  HourNameEn.am10, HourNameEn.am11,
        HourNameEn.pm12,HourNameEn.pm1,HourNameEn.pm2, HourNameEn.pm3,HourNameEn.pm4,HourNameEn.pm5,HourNameEn.pm6,HourNameEn.pm7,HourNameEn.pm8, HourNameEn.pm9,HourNameEn.pm10,HourNameEn.pm11 ]
    
    init(package: Packages,dates: [DatesTimes]){
        isDateAndTimeEntered = Observable.combineLatest(selectedDate, selectedTime).map({ (date,time) in
            return date != nil && time != nil
        })
        self.package = package
        if UserDefualtUtils.isArabic() {
            self.dates = Array(dates.reversed())
        }else {
            self.dates = dates
        }
    }
    
    func viewDidLoad() {
        let currentHour =  Calendar.current.component(.hour, from: Date())
        getAllTimesAtDay(currentHour: currentHour)
        getCurrntDay()
        getTimes()
        getcurrentHourIndex()
        self.filterDates.onNext(dates)
        getCurrentDayAtCurrentMonth()
    }
    private func getCurrentDayAtCurrentMonth() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMMM"
        let monthIndex = Calendar.current.component(.month, from: Date())
        let dayIndex = Calendar.current.component(.day, from: Date())
//        guard let monthNumber =
//        let currentMonth = dateFormatter.string(from: Date())
        if let index =  dates.firstIndex(where: {
            ($0.monthNumber ?? "" ) == String(monthIndex) && ($0.dayOfMonth ?? "" ) == String(dayIndex)
        }) {
            currentDayAtMonthIndex.onNext(IndexPath(row: index, section: 0))
        }
    }
    private func getcurrentHourIndex() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour24 = calendar.component(.hour, from: currentDate)
        let indexPath = IndexPath(row: currentHour24, section: 0)
        self.currentHourIndex.onNext(indexPath)
    }
    func didSelectDateAndTime() {
        let savedPackages = SelectedPackage.shared
        if var updatablePackage = savedPackages.packages.filter({$0.packageId == package?.packageId}).first, let date = selectedDate.value {
            let day = date.dayOfMonth ?? ""
            let month = date.monthNumber ?? ""
            let year = String(date.year ?? 0)
            let time = selectedTime.value?.hourNameEn ?? ""
            let serverDate = year + "-" + month + "-" + day + "T" + time + "Z"
            updatablePackage.date = day + "/" + month + "/" + year
            updatablePackage.time = time
            updatablePackage.serverDate = serverDate
            savedPackages.updatePackage(package: updatablePackage)
        }
        
    }
    private func getTimes() {
        didSelectDate.subscribe(onNext: {[weak self] selectedDate in
            guard let selectedDate = selectedDate else {return}
            if selectedDate.monthNumber == self?.CurrentMonthNumber && selectedDate.dayOfMonth == self?.CurrentDayNumber {
                self?.getTimesPerDay(currentHour: self?.CurrentHour ?? 0)
            }else {
                self?.getAllTimesAtDay(currentHour: nil)
            }
        }).disposed(by: disposeBag)
    }
    private func getCurrntDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MM"
        CurrentMonthNumber = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "dd"
        CurrentDayNumber = dateFormatter.string(from: Date())
        let calendar = Calendar.current
        CurrentHour = calendar.component(.hour, from: Date())
    }
    private func getAllTimesAtDay(currentHour: Int?) {
        var timesData: [Times] = []
        for index in 0..<24 {
            let hourName = UserDefualtUtils.isArabic() ? hoursNameAr[index].rawValue : hoursNameEn[index].rawValue
            timesData.append(Times(hour: index, hourNameAr: hoursNameEn[index].rawValue, hourNameEn: hoursNameEn[index].rawValue))
        }
        if UserDefualtUtils.isArabic() {
            timesData =  Array(timesData.reversed())
        }
        self.allTimes.accept(timesData)
        if let currentHour = currentHour {
            getTimesPerDay(currentHour: currentHour)
        }else {
            self.times.accept(timesData)
        }
    }
    private func getTimesPerDay(currentHour: Int) {
        let filteredTimeBasedOnCurrentHour = allTimes.value.filter{$0.hour > currentHour }
        self.times.accept(filteredTimeBasedOnCurrentHour)
    }
}

struct Times {
    var hour: Int
    var hourNameAr: String
    var hourNameEn: String
    init(hour: Int, hourNameAr: String, hourNameEn: String) {
        self.hour = hour
        self.hourNameAr = hourNameAr
        self.hourNameEn = hourNameEn
    }
}
enum HourNameEn: String, CaseIterable {
    case am12 = "00:00"
    case am11 = "11:00"
    case am10 = "10:00"
    case am9 = "09:00"
    case am8 = "08:00"
    case am7 = "07:00"
    case am6 = "06:00"
    case am5 = "05:00"
    case am4 = "04:00"
    case am3 = "03:00"
    case am2 = "02:00"
    case am1 = "01:00"
    case pm12 = "12:00"
    case pm11 = "23:00"
    case pm10 = "22:00"
    case pm9 = "21:00"
    case pm8 = "20:00"
    case pm7 = "19:00"
    case pm6 = "18:00"
    case pm5 = "17:00"
    case pm4 = "16:00"
    case pm3 = "15:00"
    case pm2 = "14:00"
    case pm1 = "13:00"
}
enum HourNameAr: String, CaseIterable {
    case am12 = "24:00"
    case am11 = "1:00"
    case am10 = "2:00"
    case am9 = "3:00"
    case am8 = "4:00"
    case am7 = "5:00"
    case am6 = "6:00"
    case am5 = "7:00"
    case am4 = "8:00"
    case am3 = "9:00"
    case am2 = "10:00"
    case am1 = "11:00"
    case pm12 = "12:00"
    case pm11 = "13:00"
    case pm10 = "14:00"
    case pm9 = "15:00"
    case pm8 = "16:00"
    case pm7 = "17:00"
    case pm6 = "18:00"
    case pm5 = "19:00"
    case pm4 = "20:00"
    case pm3 = "21:00"
    case pm2 = "22:00"
    case pm1 = "23:00"
}
