//
//  ServicesCollectionViewCell.swift
//  Yabraa
//
//  Created by Hamada Ragab on 27/08/2023.
//

import UIKit
import RxCocoa
import RxSwift
class ServicesCollectionViewCell: UITableViewCell {

    @IBOutlet weak var serviceCollectionViewCell: UICollectionView!
     let disposeBag = DisposeBag()
    var viewModel = ServicesCellViewModel()
    let services = BehaviorRelay<[OneDimensionalService]>(value: [])
    var selectedServices: ((OneDimensionalService)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        bindCollectionView()
    }

    private func setUpCollectionView() {
        serviceCollectionViewCell.register(UINib(nibName: "ServiceCell", bundle: nil), forCellWithReuseIdentifier: "ServiceCell")
        serviceCollectionViewCell.rx.setDelegate(self).disposed(by: disposeBag)
    }
    private func bindCollectionView() {
        services.bind(to: serviceCollectionViewCell.rx.items(cellIdentifier: "ServiceCell",cellType: ServiceCell.self)) { index, model ,cell in
            cell.setUpcell(service: model)
        }.disposed(by: disposeBag)
        serviceCollectionViewCell.rx.modelSelected(OneDimensionalService.self).subscribe(onNext: { [weak self] service in
            self?.selectedServices?(service)
        }).disposed(by: disposeBag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension ServicesCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (serviceCollectionViewCell.bounds.width) / 2, height: 160)
    }
}
