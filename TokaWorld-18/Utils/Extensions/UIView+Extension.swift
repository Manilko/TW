//
//  UIView+Extension.swift
//  TokaWorld-18
//
//  Created by Yevhenii Manilko on 03.12.2023.
//

import UIKit

extension UIView {
    func constraints(_ attribute: DimensionAttribute) -> [NSLayoutConstraint] {
        constraints.filter {
            ($0.firstItem  as? NSObject) == self &&
            $0.firstAttribute == attribute.nsAttribute
        }
    }
    
    func autoPinEdgesToSuperView(with constant: CGFloat = 0) {
        guard let superView = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: constant),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -constant),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant)
        ])
    }
    
    func autoPinLoadingViewToSuperView() {
        guard let superView = superview else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: 8),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 8),
            widthAnchor.constraint(equalToConstant: 0),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -8)
        ])
    }
}

enum DimensionAttribute {
    case width, height
    var nsAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .width:  return .width
        case .height: return .height }
    }
}

