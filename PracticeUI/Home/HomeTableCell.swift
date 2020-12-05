//
//  HomeTableCell.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/5.
//

import UIKit

class HomeTableCell: UITableViewCell {

    lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "PingFangTC-Regular", size: 30)
        l.textColor = .white
        contentView.addSubview(l)
        l.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        return l
    } ()
    lazy var gradientView: UIView = {
        let v = UIView()
        contentView.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview().offset(-15)
            make.top.left.equalToSuperview().offset(15)
            make.height.equalTo(230)
        }
        v.cornerRadius = 10
        v.clipsToBounds = true
        return v
    }()
    lazy var shadowView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        contentView.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(gradientView)
        }
        v.cornerRadius = 10
        v.clipsToBounds = true
        return v
    } ()
    
    private var bgAnimator: UIViewPropertyAnimator
    private var originBgViewFrame: CGRect?
    
    private let animatorDuration: TimeInterval = 0.25
    private let animatorMargin: CGFloat = 5
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.bgAnimator = UIViewPropertyAnimator(duration: animatorDuration, curve: .linear, animations: nil)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        separatorInset = UIEdgeInsets(inset: .infinity)
    }
    required init?(coder: NSCoder) {
        self.bgAnimator = UIViewPropertyAnimator(duration: animatorDuration, curve: .linear, animations: nil)
        super.init(coder: coder)
        
        selectionStyle = .none
        separatorInset = UIEdgeInsets(inset: .infinity)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        originBgViewFrame = nil
    }
    override func draw(_ rect: CGRect) {
        

        shadowView.addShadow(ofColor: .black, radius: 8, offset: .zero, opacity: 0.5)
        gradientView.resizeGradient()
        contentView.bringSubviewToFront(gradientView)
        contentView.bringSubviewToFront(nameLabel)
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
            originBgViewFrame = gradientView.frame
        }
        guard let originBgFrame = originBgViewFrame else { return }

        if bgAnimator.isRunning {
            bgAnimator.reverseAndContinue()
        } else {
            self.originBgViewFrame = self.gradientView.frame
            bgAnimator.addAnimations {
                [weak self] in
                guard let `self` = self else { return }
                let newFrame = originBgFrame.insetBy(dx: self.animatorMargin, dy: self.animatorMargin)
                self.changeContentsFrame(frame: newFrame)
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
                self.changeContentsFrame(frame: originBgFrame)
            }
            bgAnimator.startAnimation()
        }
    }
    private func changeContentsFrame(frame: CGRect) {
        gradientView.frame = frame
        shadowView.frame = frame
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
