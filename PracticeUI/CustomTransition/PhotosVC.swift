//
// PhotosVC.swift
//
// Created by Ben for PracticeUI on 2021/5/7.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
class PhotosVC: UIViewController {
    var colors = [UIColor]()

    lazy var cv: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        v.delegate = self
        v.dataSource = self
        v.register(cellWithClass: PhotoCell.self)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        colors = (0 ... 10000).map { _ in UIColor.random }

        cv.reloadData()
        cv.setContentOffset(CGPoint(x: 0, y: cv.contentSize.height), animated: true)
    }
}

extension PhotosVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colors[indexPath.row]
        let contentVC = CustomTransitionContentDetailVC()
        contentVC.view.backgroundColor = color
        navigationController?.pushViewController(contentVC)
    }
}

extension PhotosVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: PhotoCell.self, for: indexPath)
        cell.backgroundColor = .white
        let color = colors[indexPath.row]
        cell.backgroundColor = color
        return cell
    }
}

extension PhotosVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(UIScreen.main.bounds.width / 3) - 10
        return CGSize(width: width, height: width)
    }
}

private func randomPlcaholder(with text: String) -> String {
    // https://via.placeholder.com/150/0CC000/FFFFCC/?text=IPaddress.net
    let txtColor = UIColor.random.hexString.dropFirst(1)
    let bgColor = UIColor.random.hexString.dropFirst(1)
    return "https://via.placeholder.com/999/\(bgColor)/\(txtColor)/?text=\(text)"
}
