//
//  YBDatesAndTimesView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
protocol PackageUpdating: AnyObject {
    func didUpdatePackage()
}
class YBDatesAndTimesView: UIViewController {
//    @IBOutlet weak var closeBTN: UIButton!
//    @IBOutlet weak var timeLBL: UILabel!
//    @IBOutlet weak var dateLBL: UILabel!
    @IBOutlet weak var timesCollection: UICollectionView!
    @IBOutlet weak var datesCollection: UICollectionView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var coordinator: DatesAndTimesCoordinatorDelegate?
    var viewModel: DatesAndTimesViewModel?
    weak var delegate : PackageUpdating?
    private let disposeBag = DisposeBag()
    private var transformation: CGAffineTransform {
        if UserDefualtUtils.isArabic() {
            return CGAffineTransform(scaleX: -1.0, y: 1.0)
        }else {
            return CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        registerCell()
        bindData()
        viewModel?.viewDidLoad()
    }
    private func setUpUI() {
        DispatchQueue.main.async { 
            self.datesCollection.transform = self.transformation
            self.timesCollection.transform = self.transformation
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
       
    }
    private func registerCell() {
        datesCollection.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        timesCollection.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
        timesCollection.rx.setDelegate(self).disposed(by: disposeBag)
        datesCollection.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    private func bindData() {
        self.viewModel?.filterDates.bind(to: datesCollection.rx.items(cellIdentifier: "DateCell",cellType: DateCell.self)) {
            index, date,cell in
            cell.transform = self.transformation
            cell.setUpCell(dayNumber: date.dayOfMonth ?? "", day: date.dayName ?? "")
        }.disposed(by: disposeBag)
        self.viewModel?.times.bind(to: timesCollection.rx.items(cellIdentifier: "TimeCell",cellType: TimeCell.self)) {
            index, time,cell in
            cell.transform = self.transformation
            cell.setUpCell(time: time)
        }.disposed(by: disposeBag)
        self.datesCollection.rx.modelSelected(DatesTimes.self).subscribe(onNext: { [weak self]
            date in
            let selectedDate = "\(date.dayOfMonth ?? "")/\(date.monthNumber ?? "")/\(date.year ?? 0)"
            self?.viewModel?.selectedDate.accept(date)
            self?.viewModel?.didSelectDate.accept(date)
        }).disposed(by: disposeBag)
        self.timesCollection.rx.modelSelected(Times.self).subscribe(onNext: { [weak self]
            time in
            self?.viewModel?.selectedTime.accept(time)
        }).disposed(by: disposeBag)
        viewModel?.isDateAndTimeEntered.bind(to: confirmButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel?.isDateAndTimeEntered.map{$0 == true ? 1 : 0.5}.bind(to: confirmButton.rx.alpha).disposed(by: disposeBag)
        confirmButton.rx.tap.subscribe(onNext: {_ in
            self.viewModel?.didSelectDateAndTime()
            self.dismiss(animated: true) {
                self.delegate?.didUpdatePackage()
            }
        }).disposed(by: disposeBag)
        cancelButton.rx.tap.asDriver().drive(onNext: { _ in
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
    }
    private func getTransform() -> CGAffineTransform {
        if UserDefualtUtils.isArabic() {
            return CGAffineTransform(scaleX: -1.0, y: 1.0)
        }else {
            return CGAffineTransform(scaleX: 1, y: 1)
        }
       
    }
}
//class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
//        return true
//    }
//
//    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
//        return UIUserInterfaceLayoutDirection.rightToLeft
//    }
//}
//import UIKit

//class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {
//    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
//        return true
//    }
//
//    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection {
//        return .rightToLeft
//    }
//
//    override func prepare() {
//        super.prepare()
//        scrollDirection = .horizontal
//    }
//
////    private func adjustScrollDirection() {
////        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
////            scrollDirection = .horizontal // Set the scroll direction to horizontal for RTL
////        } else {
////            scrollDirection = .vertical // Set the scroll direction to vertical for LTR (left-to-right)
////        }
////    }
//}
