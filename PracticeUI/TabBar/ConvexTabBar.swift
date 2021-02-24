//
// ConvexTabBar.swift
//
// Created by Ben for PracticeUI on 2021/2/17.
// Copyright © 2021 Alien. All rights reserved.
//

import ESTabBarController_swift

@IBDesignable
class ConvexTabBar: ESTabBar {
    private var shapeLayer: CALayer?

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0

        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    override func draw(_ rect: CGRect) {
        addShape()
        print("BB")
    }
    
    func createPath() -> CGPath {
        print("Tag:\(selectedItem?.tag ?? 99)")
        if let tag = selectedItem?.tag,
           let _items = items {
            _items.forEach { (item) in
                if item.tag == tag {
                    item.imageInsets = UIEdgeInsets(horizontal: 0, vertical: -10)
                } else {
                    item.imageInsets = UIEdgeInsets.zero
                }
            }
        }
        
        let height: CGFloat = 20.0
        let deltaXBezier1 = height - 7
        let deltaXBezier2 = height - 2
        
        let path = UIBezierPath()
        let centerWidth = frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0)) // start top left
        path.addLine(to: CGPoint(x: centerWidth - height * 2, y: 0)) // the beginning of the trough
        
        // up point
        let upEndPnt = CGPoint(x: centerWidth, y: -height)
        let upControlPnt1 = CGPoint(x: centerWidth - deltaXBezier1, y: 0)
        let upControlPnt2 = CGPoint(x: centerWidth - deltaXBezier2, y: -height)
        
        // down point
        let downEndPnt = CGPoint(x: centerWidth + height * 2, y: 0)
        let downControlPnt1 = CGPoint(x: centerWidth + deltaXBezier2, y: -height)
        let downControlPnt2 = CGPoint(x: centerWidth + deltaXBezier1, y: 0)
        
        // first curve up
        path.addCurve(to: upEndPnt,
                      controlPoint1: upControlPnt1,
                      controlPoint2: upControlPnt2)
        // second curve down
        path.addCurve(to: downEndPnt,
                      controlPoint1: downControlPnt1,
                      controlPoint2: downControlPnt2)

        // complete the rect
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()

        return path.cgPath
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event)
//        let buttonRadius: CGFloat = 35
//        return abs(center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
    }

    func createPathCircle() -> CGPath {
        let radius: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerWidth - radius * 2, y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0), radius: radius, startAngle: CGFloat(180).degreesToRadians, endAngle: CGFloat(0).degreesToRadians, clockwise: false)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()
        return path.cgPath
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { self * .pi / 180 }
    var radiansToDegrees: CGFloat { self * 180 / .pi }
}

extension ConvexTabBar {

    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        print("AA")
        /// Customise in here.
    }

    // Modify the height.
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 120.0)
    }
}
