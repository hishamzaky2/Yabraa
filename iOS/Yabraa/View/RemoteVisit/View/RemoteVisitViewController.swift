//
//  HomeVisitViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 27/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
class RemoteVisitViewController: BaseViewController {
    @IBOutlet weak var homeVisitCollectionView: UICollectionView!
    var viewModel: RemoteVisitViewModel?
    var router: RemoteVisitProtocol?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        bindCollectionView()
        bind()
        // Do any additional setup after loading the view.
    }
    private func bind() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
    }
    private func setUpCollectionView() {
        homeVisitCollectionView.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
        homeVisitCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindCollectionView() {
        viewModel?.homeVisits.bind(to: homeVisitCollectionView.rx.items(cellIdentifier: "ServiceCell",cellType: ServiceCell.self)) {index, model ,cell in
            cell.setUpcell(service: model)
        }.disposed(by: disposeBag)
        homeVisitCollectionView.rx.modelSelected(OneDimensionalService.self).subscribe(onNext: {[weak self] service in
            self?.router?.goToPackges(service: service)
        }).disposed(by: disposeBag)
    }

}
extension RemoteVisitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (homeVisitCollectionView.bounds.width - 10 ) / 2, height: 200)
    }
}
