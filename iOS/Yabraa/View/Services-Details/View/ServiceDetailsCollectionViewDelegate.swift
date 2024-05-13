//
//  CollectionViewDelegate.swift
//  Yabraa
//
//  Created by Hamada Ragab on 13/05/2023.
//

import Foundation
import UIKit
extension YBServicesDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionView {
            return CGSize(width: (collectionView.bounds.width / 2.5 ), height: 40)
        }else {
            return CGSize(width: collectionView.bounds.width, height: 140)
        }
    }
}
extension YBServicesDetailsView: ServciDescriptionProtocol{
    func didTapConfirm(package: Packages) {
        do {
            var packages = try! viewModel?.filteredPackages.value() ?? []
            if let index =  packages.firstIndex(where: {$0.packageId == package.packageId}) {
                packages[index] = package
                viewModel?.filteredPackages.onNext(packages)
            }
        }catch {
            
        }
        
        self.selectedIndexPathRelay.onNext(selectedIndex)
        self.displayAlert(package: package)
    }
}
