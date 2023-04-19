//
//  CaptureButton.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.04.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

final class CaptureButton: UIButton {
    
    var handler: HandlerVoid?
    
    private var currentScale: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        defer {
            addGesturre()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc
    private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            startScaling()
        case .changed:
            break
        case .ended, .cancelled, .failed:
            stopScaling()
            break
        default:
            break
        }
    }
}

extension CaptureButton {
    private func addGesturre() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(
            target: self, action: #selector(handleLongPress(_:))
        )
        longPressGestureRecognizer.minimumPressDuration = 0.01
        addGestureRecognizer(longPressGestureRecognizer)
    }
    
    private func startScaling() {
        let animator = UIViewPropertyAnimator(duration: 0.6, curve: .easeInOut) { [weak self] in
               guard let self = self else { return }
            let scaleFactor: CGFloat = 1.6
               let newScale = max(1,self.currentScale * scaleFactor)
               if newScale > self.currentScale {
                   print(newScale)
                   let scaleTransform = CGAffineTransform(scaleX: 1 - newScale, y: 1 - newScale)
                   self.transform = scaleTransform
               }
           }
           animator.startAnimation()
    }
    
    private func stopScaling() {
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
        currentScale = 1.0
        handler?()
    }
}
