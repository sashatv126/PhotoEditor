//
//  MainLayout.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 24.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

final class MainLayoutBuilder {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        return UICollectionViewCompositionalLayout(sectionProvider: { section, env in
            return createHorizontalSection()
        }, configuration: config)
    }
}

extension MainLayoutBuilder {
    private static func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
