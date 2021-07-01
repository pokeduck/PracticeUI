//
//  DragCollectionVC.swift
//  PracticeUI
//
//  Created by Well on 2021/7/1.
//

import UIKit
import RxSwift
class DragCollectionCellModel: NSObject,NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return ["A"]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        return nil
    }
    
    let title: String
    var isSelected: Bool
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

class DragColectionCell: UICollectionViewCell {
    let titleLabel = UILabel()
    
    let stateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func initUI() {
        addSubviews([titleLabel,stateLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        stateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}
class DragCollectionVC: UIViewController {
    
    let bag = DisposeBag()
    var isDraging = false
    var collectionView: UICollectionView!
    var models: [DragCollectionCellModel] = (0 ... 20).map { index in
        DragCollectionCellModel(title: "\(index)", isSelected: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        let flow = UICollectionViewFlowLayout()
        flow.minimumLineSpacing = 20
        flow.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        if #available(iOS 14.0, *) {
            navigationItem.rightBarButtonItem = UIBarButtonItem.init(systemItem: .edit)
        } else {
            // Fallback on earlier versions
        }
        navigationItem.rightBarButtonItem?.rx.tap.bind { [weak self] _ in
            guard let `self` = self else { return }
            self.isDraging = !self.isDraging
            self.collectionView.dragInteractionEnabled = self.isDraging
            self.collectionView.reloadData()
        }.disposed(by: bag)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellWithClass: DragColectionCell.self)
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = false
    }

    fileprivate func recorderItem(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
           let sourceIndexPath = item.sourceIndexPath
        {
            collectionView.performBatchUpdates {
                self.models.remove(at: sourceIndexPath.item)
                self.models.insert(item.dragItem.localObject as! DragCollectionCellModel, at: destinationIndexPath.item)

                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            } completion: { result in
                dLog(result)
            }
        }
    }
}

extension DragCollectionVC: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationindexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationindexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationindexPath = IndexPath(item: row - 1, section: 0)
        }

        if coordinator.proposal.operation == .move {
            recorderItem(coordinator: coordinator, destinationIndexPath: destinationindexPath, collectionView: collectionView)
        }
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if let destPath = destinationIndexPath,
           destPath.row == 0
           {
            return UICollectionViewDropProposal(operation: .forbidden)

        }
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
}

extension DragCollectionVC: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if indexPath.row == 0 { return [] }
        let item = models[indexPath.row]
        let itemProvider = NSItemProvider(object: item as DragCollectionCellModel)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}

extension DragCollectionVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDraging { return }
        let model = models[indexPath.row]
        var preIndex: Int?
        for (idx,model) in models.enumerated() {
            if model.isSelected {
                preIndex = idx
                model.isSelected = false
                break
            }
        }
        model.isSelected = true
        if let idx = preIndex,
           let cell = collectionView.cellForItem(at: IndexPath.init(row: idx, section: 0)) {
            cell.backgroundColor = .white
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? DragColectionCell {
            cell.backgroundColor = .red
        }
        
    }
    
}

extension DragCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 20, height: 50)
    }
}

extension DragCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: DragColectionCell.self, for: indexPath)
        let model = models[indexPath.row]
        cell.backgroundColor = model.isSelected ? .red : .white
        cell.titleLabel.text = model.title
        cell.stateLabel.text = isDraging ? "Drag" : "Select"
        cell.shadowDecorate()
        return cell
    }
}

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 4
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}
