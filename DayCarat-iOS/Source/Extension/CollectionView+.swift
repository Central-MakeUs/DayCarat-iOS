//
//  CollectionView+.swift
//  DayCarat-iOS
//
//  Created by 최지철 on 1/8/24.
//

import UIKit

extension UICollectionView {
    func currentPageIndex() -> Int {
        let visibleRect = CGRect(origin: contentOffset, size: bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

        guard let indexPath = indexPathForItem(at: visiblePoint) else {
            return 0 
        }

        return indexPath.item
    }
}
