//
//  YBPackagesView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 19/06/2023.
//

import UIKit
import RxSwift
import RxCocoa
class YBPackagesView: UIViewController {
    @IBOutlet weak var packagesTableView: UITableView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
//    {
//        didSet {
//            if !UserDefualtUtils.isArabic() {
//                filterCollectionView.semanticContentAttribute = .forceRightToLeft
//            }else {
//                filterCollectionView.semanticContentAttribute = .forceLeftToRight
//            }
//        }
//    }
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var claerFilter: UIButton!
    @IBOutlet weak var serviceTitle: UILabel!
    @IBOutlet weak var confirmViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var cancelPackages: UIButton!
    var router: PackagesRouterProtocol?
    private let disposeBag = DisposeBag()
    var viewModel: PackagesViewModel?
    let selectedFilters = BehaviorRelay<[Filters]>(value: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFilterCollectionView()
        setUpPackagesCollectionView()
        bindData()
        setUpUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        UIView.appearance().semanticContentAttribute = .forceRightToLeft
        showAndConfirmingView()
        viewModel?.checkSelectedPackages()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(view.semanticContentAttribute)
    }
    private func setUpUI() {
        confirm.titleLabel?.adjustsFontSizeToFitWidth = true
        backBtn.imageView?.FlipImage()
    }
    private func setUpFilterCollectionView() {
        filterCollectionView.register(UINib(nibName: "PackageFilterCell", bundle: nil), forCellWithReuseIdentifier: "PackageFilterCell")
        filterCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        bindFilterCollectionViewData()
    }
    private func setUpPackagesCollectionView() {
        packagesTableView.register(UINib(nibName: "packagesCell", bundle: nil), forCellReuseIdentifier: "packagesCell")
        packagesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        bindPackagesCollectionViewData()
    }
    private func bindFilterCollectionViewData() {
        //        selectedFilters.bind(to: viewModel!.selectedFilters).disposed(by: disposeBag)
        viewModel?.filter.bind(to: filterCollectionView.rx.items(cellIdentifier: "PackageFilterCell",cellType: PackageFilterCell.self)){
            index ,filter, cell in
            cell.setUpCell(filter: filter)
            cell.closeBTN.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.viewModel?.removeFilter(filter: filter)
                self?.claerFilter.isHidden = true
            }).disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)
        filterCollectionView.rx.modelSelected(Filters.self).subscribe(onNext: { [weak self] selectedFilter in
            self?.viewModel?.filterPackage(filter: selectedFilter)
            self?.claerFilter.isHidden = false
        }).disposed(by: disposeBag)
    }
    private func bindPackagesCollectionViewData() {
        viewModel?.filteredPackages.bind(to: packagesTableView.rx.items(cellIdentifier: "packagesCell",cellType: packagesCell.self)){
            index ,package, cell in
            cell.makeAppointmentTapped = {
                self.router?.goToPackgeDetails(package: package, isReadMore: false)
            }
            cell.readMore = {
                self.router?.goToPackgeDetails(package: package,isReadMore: true)
            }
            cell.setUpCell(package: package)
        }.disposed(by: disposeBag)
        //        packagesTableView.rx.modelSelected(Packages.self).subscribe(onNext: { [weak self] package in
        //            self?.router?.goToPackgeDetails(package: package)
        //        }).disposed(by: disposeBag)
    }
    private func bindData() {
        claerFilter.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.viewModel?.clearFilter.accept(())
            self?.filterCollectionView.reloadData()
        }).disposed(by: disposeBag)
        viewModel?.serviceTitle.bind(to: serviceTitle.rx.text).disposed(by: disposeBag)
        backBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.viewModel?.emptySelectedPackages()
            self?.router?.backToHome()
        }).disposed(by: disposeBag)
        confirm.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.router?.goToMakeAppintMent()
        }).disposed(by: disposeBag)
        cancelPackages.rx.tap.asDriver().drive(onNext: {[weak self] _ in
            self?.viewModel?.removeAllSelectedPakagse()
        }).disposed(by: disposeBag)
    }
    func showAndConfirmingView() {
        viewModel?.hideConfirmingView.asDriver(onErrorJustReturn: true).drive(onNext: { [weak self] is_Hidden in
            if self?.confirmViewBottomConstraint.constant == -70 && is_Hidden {
                
            }else {
                let heightOfview =  is_Hidden  ? -70.0 : 0
                UIView.animate(withDuration: 0.4) {
                    self?.confirmViewBottomConstraint.constant = heightOfview
                    self?.view.layoutIfNeeded()
                }
            }
        }).disposed(by: disposeBag)
        
    }
}
extension YBPackagesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
extension YBPackagesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = viewModel?.getStringWidthAtIndex(index: indexPath.row) ?? (collectionView.bounds.width / 2.5 )
        return CGSize(width: width + 20, height: 50)
    }
}
extension YBPackagesView: MakeAppointmentProtocol {
    func didCancelPackage() {
        viewModel?.removeAllSelectedPakagse()
    }
    
    
}
