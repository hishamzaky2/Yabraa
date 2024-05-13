//
//  DatesViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 18/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
class DatesViewController: UIViewController {
    @IBOutlet weak var timesCollection: UICollectionView!
    @IBOutlet weak var datesCollection: UICollectionView!
    private let disposeBag = DisposeBag()
    var viewModel: DatesAndTimesViewModel?
    let filterDates = BehaviorRelay<[DatesTimes]>(value: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindData() 
        // Do any additional setup after loading the view.
    }
    private func registerCell() {
        datesCollection.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "DateCell")
        timesCollection.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
//        timesCollection.rx.setDelegate(self).disposed(by: disposeBag)
        datesCollection.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    private func bindData() {
       filterDates.bind(to: datesCollection.rx.items(cellIdentifier: "DateCell",cellType: DateCell.self)) {
            index, date,cell in
            cell.setUpCell(dayNumber: date.dayOfMonth ?? "", day: date.dayName ?? "")
        }.disposed(by: disposeBag)
    }
}
extension DatesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: collectionView.bounds.height)
    }
}
