//
//  YBIntroductionView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/02/2023.
//

import UIKit
import RxCocoa
import RxSwift
//import MOLH
class YBIntroductionView: BaseViewController {
    
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var OnbordingCollecion: UICollectionView!
    @IBOutlet weak var progressCollectionView: UICollectionView!
    var router: YBIntroductionRouter?
    var viewModel:IntroductionViewModel?
    let disposeBag = DisposeBag()
    var indexPath = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCellForOnbordingCollecion()
        bindOnbordingData()
//        if !(viewModel?.onbordingData.value.isEmpty ?? false) {
//            OnbordingCollecion.scrollToItem(at: IndexPath(row: 0, section: 0), at: [], animated: true)
//        }
//        viewModel?.ssss()
    }
   
    private func bindOnbordingData() {
        viewModel?.onbordingData.bind(to: OnbordingCollecion.rx.items(cellIdentifier: "OnbordingDataCell",cellType: OnbordingDataCell.self)) {index , model , cell in
            cell.configureCell(slider: model)
//            cell.transform = CGAffineTransform(scaleX: -1, y: 1)
        }.disposed(by: disposeBag)
        viewModel?.onbordingData.bind(to: progressCollectionView.rx.items(cellIdentifier: "ProgressCell",cellType: ProgressCell.self)) {index , model , cell in
            let range = 0...self.indexPath
            if range.contains(index) {
                cell.backgroundColor = UIColor(named: "textBlackColor")
            }else {
                cell.backgroundColor = UIColor(named: "TextGrayColor")
            }

        }.disposed(by: disposeBag)
        viewModel?.onbordingData.filter{$0.count > 0}.asDriver(onErrorJustReturn: []).drive(onNext: {[weak self] sliders in
            self?.OnbordingCollecion.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
        }).disposed(by: disposeBag)
        skipBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.goToLogin()
        }).disposed(by: self.disposeBag)
    }
    private func setUpCellForOnbordingCollecion() {
        OnbordingCollecion.register(UINib(nibName: "OnbordingDataCell", bundle: nil), forCellWithReuseIdentifier: "OnbordingDataCell")
        progressCollectionView.register(UINib(nibName: "ProgressCell", bundle: nil), forCellWithReuseIdentifier: "ProgressCell")
        OnbordingCollecion.rx.setDelegate(self).disposed(by: disposeBag)
        progressCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func goToLogin() {
        UserDefualtUtils.setIsOnbordingViewed(isViewed: true)
        router?.goToLogin()
    }
}

extension YBIntroductionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == OnbordingCollecion {
            return CGSize(width: OnbordingCollecion.bounds.width, height: OnbordingCollecion.bounds.height)
        }else {
            return CGSize(width: 35, height: 2)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == OnbordingCollecion {
            for cell in OnbordingCollecion.visibleCells {
                if let row = OnbordingCollecion.indexPath(for: cell)?.item {
                    indexPath = row
                    self.progressCollectionView.reloadData()
                }
            }
        }
    }
}
