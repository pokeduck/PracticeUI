//
//  UINib+VIew.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/8.
//  Copyright © 2020 pokeduck. All rights reserved.
//

import Foundation
import UIKit

protocol NibInstantiable {}

extension UIView: NibInstantiable {}

extension NibInstantiable where Self: UIView {
    static func instantiateFromNib() -> Self {
        if let view = Bundle(for: self).loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as? Self {
            return view
        } else {
            assert(false, "The nib named \(self) is not found")
            return Self()
        }
    }
}

protocol NibCellProtocol {}
extension UITableViewCell: NibCellProtocol {}
extension NibCellProtocol where Self: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }

    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UICollectionViewCell: NibCellProtocol {}
extension NibCellProtocol where Self: UICollectionViewCell {
    static var reuseIdentifier: String { String(describing: self) }

    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}
