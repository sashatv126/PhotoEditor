//
//  MainDataSource.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 17.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

protocol MainDataSourceProtocol {
    func reloadData(model: [Image], animate: Bool)
}

final class MainDataSource: MainDataSourceProtocol {
    private var dataSource: UICollectionViewDiffableDataSource<MainSections,Image>?
    
    init(collection: UICollectionView) {
        createDataSource(collection: collection)
    }
    
    func reloadData(model: [Image], animate: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<MainSections, Image>()
        snapshot.appendSections([.images])
        
        snapshot.appendItems(model, toSection: .images)
        
        dataSource?.apply(snapshot, animatingDifferences: animate)
    }
}

extension MainDataSource {
    private func createDataSource(collection: UICollectionView) {
        let config = imageConfig()
        dataSource = UICollectionViewDiffableDataSource<MainSections,Image>(collectionView: collection, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: config,
                for: indexPath,
                item: itemIdentifier
            )
        })
    }
    
    private func imageConfig() -> UICollectionView.CellRegistration<MainImageCell,Image> {
        let config = UICollectionView.CellRegistration<MainImageCell,Image> { cell, indexPath, itemIdentifier in
            cell.configure(itemIdentifier)
        }
        return config
    }
}

