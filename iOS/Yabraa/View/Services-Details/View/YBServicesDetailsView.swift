//
//  YBServicesDetailsView.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import UIKit
import RxCocoa
import RxSwift
class YBServicesDetailsView: UIViewController {
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var clearBTN: UIButton!
    var viewModel: ServicesDetailsViewModel?
    let disposeBag = DisposeBag()
    var router: ServicesDetailsDelegate?
    let selectedIndexPathRelay = PublishSubject<Int?>()
    var selectedIndex: Int?
    var confirmAppointMent: ConfirmAppointmentView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFilterCollectionView()
        setUpServicesCollectionView()
        bind()
        didSelectItem()
        // Do any additional setup after loading the view.
    }
    private func bind() {
        viewModel?.fillter.bind(to: filterCollectionView.rx.items(cellIdentifier: "ServicesFilterCell",cellType: ServicesFilterCell.self)) {
            index , filterModel , cell in
            cell.closeBTN.rx.tap.asDriver().drive(onNext: {
                if  cell.isSelected {
                    self.viewModel!.didTapOnClose.accept(())
                    cell.isSelected = false
                }
            }).disposed(by: cell.disposeBag)
            cell.setUpCell(filter: filterModel)
        }.disposed(by: disposeBag)
        viewModel?.filteredPackages.bind(to: servicesCollectionView.rx.items(cellIdentifier: "ServicesDetailsCell",cellType: ServicesDetailsCell.self)) {
            index , package , cell in
            cell.readMore = {
                
            }
            cell.setUpCell(package: package)
            
            self.selectedIndexPathRelay.map { $0 == index ? .mainColor : .primaryColor }
                .bind(to: cell.makeAppointMent.rx.backgroundColor)
                .disposed(by: cell.disposeBag)
            
        }.disposed(by: disposeBag)
        self.servicesCollectionView.rx.itemSelected.map{$0.row}.asObservable().subscribe { selectedRow in
            self.viewModel?.didSelectItem.onNext(selectedRow)
            self.selectedIndex = selectedRow
        }.disposed(by: disposeBag)
        viewModel?.selectedPackage.asObservable().subscribe(onNext: {
            package in
        self.router?.goToServiceDescription(package: package)
        }).disposed(by: disposeBag)
       
    }
    private func didSelectItem() {
        filterCollectionView.rx.modelSelected(Filters.self).map{$0.filterId}.bind(to: viewModel!.selectedFiletr).disposed(by: disposeBag)
    }
    private func setUpFilterCollectionView() {
        filterCollectionView.register(UINib(nibName: "ServicesFilterCell", bundle: nil), forCellWithReuseIdentifier: "ServicesFilterCell")
        filterCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func setUpServicesCollectionView() {
        servicesCollectionView.register(UINib(nibName: "ServicesDetailsCell", bundle: nil), forCellWithReuseIdentifier: "ServicesDetailsCell")
        servicesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    @IBAction func clearAllTapped(_ sender: Any) {
       
        clearData()
    }
    private func clearData() {
        confirmAppointMent?.view.removeFromSuperview()
        selectedIndexPathRelay.onNext(nil)
        self.viewModel!.didTapOnClose.accept(())
        for cell in filterCollectionView.visibleCells {
            cell.isSelected = false
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func displayAlert(package: Packages) {
        confirmAppointMent = ConfirmAppointmentView()
        guard let confirmAppointMent = confirmAppointMent else {return}
        let sourceViewFrame = CGRect(x: 0, y: self.view.bounds.height - 60, width: self.view.bounds.width, height: 60)
            confirmAppointMent.view.frame = sourceViewFrame
            self.addChild(confirmAppointMent)
            self.view.addSubview(confirmAppointMent.view)
            confirmAppointMent.didMove(toParent: self)
        confirmAppointMent.make_AppointMent.rx.tap.subscribe(onNext: {
                self.router?.goToSeviceChecking(package: package)
            }).disposed(by: self.disposeBag)
            confirmAppointMent.cancelBtn.rx.tap.subscribe(onNext: {
                self.clearData()
            }).disposed(by: self.disposeBag)
        }
//    }
}

