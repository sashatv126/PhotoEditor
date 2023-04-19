//
//  MainImageCell.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 17.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

final class MainImageCell: ReusableCell {
    private(set) var capturedImageView = CapturedImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ model: Image) {
        capturedImageView.image = model.image
    }
    
    private func setUI() {
        contentView.addSubview(capturedImageView)
        capturedImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            capturedImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            capturedImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            capturedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            capturedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        ])
    }
}

extension MainImageCell {
}
