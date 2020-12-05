//
//  HomeTableCell.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/5.
//

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    private var bgAnimator: UIViewPropertyAnimator
    private var originBgViewFrame: CGRect?
    
    private let animatorDuration: TimeInterval = 0.25
    private let animatorMargin: CGFloat = 5
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.bgAnimator = UIViewPropertyAnimator(duration: animatorDuration, curve: .linear, animations: nil)
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    required init?(coder: NSCoder) {
        self.bgAnimator = UIViewPropertyAnimator(duration: animatorDuration, curve: .linear, animations: nil)
        super.init(coder: coder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont(name: "PingFangTC-Medium", size: 30)
        titleLabel.textColor = .white
        bgView.backgroundColor = .clear
        selectionStyle = .none
        separatorInset = UIEdgeInsets(inset: .infinity)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        originBgViewFrame = nil
    }
    override func draw(_ rect: CGRect) {
        bgView.resizeGradient()
        bgView.addShadow(ofColor: .black, radius: 5, offset: .zero, opacity: 0.5)
        bgView.setBgGradientCornerRadius(radius: 10)


    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        if highlighted {
            reduceBgViewSize()
        } else {
            resumeBgViewSize()
        }
    }
    
    private func reduceBgViewSize() {
        if originBgViewFrame == nil {
            originBgViewFrame = bgView.frame
        }
        guard let originBgFrame = originBgViewFrame else { return }

        if bgAnimator.isRunning {
            bgAnimator.reverseAndContinue()
        } else {
            self.originBgViewFrame = self.bgView.frame
            bgAnimator.addAnimations {
                [weak self] in
                guard let `self` = self else { return }
                self.bgView.frame = originBgFrame.insetBy(dx: self.animatorMargin, dy: self.animatorMargin)
            }

            bgAnimator.startAnimation()
        }
       
    }
    private func resumeBgViewSize() {
        guard let originBgFrame = originBgViewFrame else { return }

        if bgAnimator.isRunning {
            bgAnimator.reverseAndContinue()
        } else {
            bgAnimator.addAnimations {
                [weak self] in
                guard let `self` = self else { return }
                self.bgView.frame = originBgFrame
            }
            bgAnimator.startAnimation()
        }
    }
    
}
extension UIViewPropertyAnimator {
    fileprivate func reverseAndContinue() {
        if isRunning {
            pauseAnimation()
            isReversed = !isReversed
            continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
extension UIViewAnimatingState: CustomStringConvertible {
    public var description: String {
        switch self {
            
        case .inactive:
            return "inactive"
        case .active:
            return "active"
        case .stopped:
            return "stopped"
        @unknown default:
            return "unknown"
        }
    }
    
}

extension UIViewAnimatingPosition: CustomStringConvertible {
    public var description: String {
        switch self {
            
        case .start:
            return "start"
        case .end:
            return "end"
        case .current:
            return "current"
        @unknown default:
            return "unknown"
        }
    }
    
}
