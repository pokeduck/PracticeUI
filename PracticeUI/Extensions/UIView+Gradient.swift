//
//  UIView+Gradient.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/5.
//

import UIKit
extension UIView {
    func resizeGradient() {
        bgGradientLayer()?.frame = bounds
    }

    func setBgGradientCornerRadius(radius: CGFloat) {
        bgGradientLayer()?.cornerRadius = radius
    }

    fileprivate static let kBgGradientLayerName: String = "key.gradient.layer.pokeduck"
    func applyGradient(colors: [UIColor],
                       start sPoint: CGPoint = CGPoint(x: 0, y: 0.5),
                       end ePoint: CGPoint = CGPoint(x: 1.0, y: 0.5))
    {
        let gradientLayer = bgGradientLayer() ?? CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = sPoint
        gradientLayer.endPoint = ePoint
        gradientLayer.frame = bounds
        gradientLayer.name = UIView.kBgGradientLayerName
        layer.insertSublayer(gradientLayer, at: 0)
    }

    private func bgGradientLayer() -> CAGradientLayer? {
        let layers = layer.sublayers?.filter { $0.name == UIView.kBgGradientLayerName }
        return layers?.first?.model() as? CAGradientLayer
    }
}
