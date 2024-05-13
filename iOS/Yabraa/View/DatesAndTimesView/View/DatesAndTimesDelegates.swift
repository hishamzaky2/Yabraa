//
//  DatesAndTimesDelegates.swift
//  Yabraa
//
//  Created by Hamada Ragab on 16/05/2023.
//

import UIKit
extension YBDatesAndTimesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == timesCollection {
            return CGSize(width: 65, height: timesCollection.bounds.height)
        }else {
            return CGSize(width: 75, height: collectionView.bounds.height)
        }
    }
}
