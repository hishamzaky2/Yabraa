//
//  TestViewController.swift
//  Yabraa
//
//  Created by Hamada Ragab on 14/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class YBHomeViewController: BaseViewController {
    
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var ServiceTableView: UITableView!
    @IBOutlet weak var searchText: UITextField!{
        didSet {
            searchText.textAlignment = UserDefualtUtils.isArabic() ? .right : .left
        }
    }
    var viewModel: HomeViewModel?
    var router: HomeRouter?
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        goToNotification()
        bind()
        bindServiceTableViewData()
        registerTableViewCells()
        bindSearchData()
    }
    private func goToNotification() {
        notificationBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.router?.goToNotifications()
        }).disposed(by: disposeBag)
    }
    private func bindSearchData() {
        searchText.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.viewModel?.search(query: text)
            })
            .disposed(by: disposeBag)
    }
    private func registerTableViewCells() {
        ServiceTableView.register(UINib(nibName: "collectionSlidersCell", bundle: nil), forCellReuseIdentifier: "collectionSlidersCell")
        ServiceTableView.register(UINib(nibName: "ServicesCollectionViewCell", bundle: nil), forCellReuseIdentifier: "ServicesCollectionViewCell")
        ServiceTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<TableViewDataSources> {
        return RxTableViewSectionedReloadDataSource<TableViewDataSources>(
            configureCell: { dataSource, tableView, indexPath, _ in
                switch dataSource[indexPath] {
                case let.Gallery(galleryData:galleryData):
                    return self.setUpSliderCell(galleryData: galleryData)
                case let.Services(services:services):
                    return self.setUpServicesCell(services: services)
                }
            }, titleForHeaderInSection: { dataSource, index in
                return ""
            })
    }
    private func setUpServicesCell(services: [OneDimensionalService])-> ServicesCollectionViewCell  {
        let cell = ServiceTableView.dequeueReusableCell(withIdentifier: "ServicesCollectionViewCell") as! ServicesCollectionViewCell
        cell.selectedServices = {[weak self] service in
            self?.router?.goToPackges(service: service)
            self?.viewModel?.didSelectServices(service: service)
        }
        cell.services.accept(services)
        return cell
    }
    private func setUpSliderCell(galleryData: [String])-> collectionSlidersCell {
        let cell = ServiceTableView.dequeueReusableCell(withIdentifier: "collectionSlidersCell") as! collectionSlidersCell
        cell.delegate = self
        cell.sliders.accept(galleryData)
        return cell
    }
    private func bind() {
        viewModel?.isLoading.asDriver(onErrorJustReturn: false).drive(onNext: {  [weak self] isLoading in
            self?.showHud(showLoding: isLoading)
        }).disposed(by: disposeBag)
    }
    private func bindServiceTableViewData() {
        let dataSource = dataSource()
        viewModel?
            .tableViewDataSources
            .drive(ServiceTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        ServiceTableView.rx.itemSelected.asDriver().drive(onNext: {[weak self] indexPath in
            self?.viewModel?.getPackagesAt(Index: indexPath.row)
        }).disposed(by: disposeBag)
    }

}

extension YBHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }else {
            let numberOfServcies = (viewModel?.filteredServices.value.count ?? 0) / 2
            return ceil(CGFloat(numberOfServcies)) * 200
        }
    }
}
