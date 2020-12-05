//
//  HomeTableViewController.swift
//  PracticeUI
//
//  Created by BenKu on 2020/12/4.
//

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import SwifterSwift

class HomeTableViewController: UIViewController {
    private let disposeBag = DisposeBag()
    lazy var tv: UITableView = {
        let v = UITableView(frame: .zero, style: .plain)
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeArea.topMargin)
            make.left.equalTo(self.view.safeArea.leftMargin)
            make.right.equalTo(self.view.safeArea.rightMargin)
            make.bottom.equalTo(self.view.safeArea.bottomMargin)
        }
        v.register(nibWithCellClass: HomeTableCell.self)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
    }

    private func setupUI() {
        tv.rx.setDelegate(self).disposed(by: disposeBag)

        let data = Observable.just([
            PageSection(name: "Section A", contents: [
                Page(name: "Line Pay",type: .line,
                     color: [.random,.random]),
                Page(name: "Uber",type: .uber,
                     color: [.random,.random]),
                Page(name: "Pinkoi",type: .pinkoi,
                     color: [.random,.random]),
                Page(name: "Google Photo",type: .google,
                     color: [.random,.random]),
            ]),
        ])
        
        let dataSource = RxTableViewSectionedReloadDataSource<PageSection>(configureCell: { (dataSource, tableView, indexPath, page) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withClass: HomeTableCell.self, for: indexPath)
            cell.titleLabel.text = page.name
            cell.bgView.applyGradient(colors: page.color)
            
            return cell
        }, titleForHeaderInSection: { (dataSource, index) -> String? in
            nil
        }, titleForFooterInSection: { (dataSource, index) -> String? in
            "FooterB"
        }, canEditRowAtIndexPath: { (dataSource, index) -> Bool in
            false
        }, canMoveRowAtIndexPath: { (dataSource, index) -> Bool in
            false
        }, sectionIndexTitles: { (dataSource) -> [String]? in
            nil
        }) { (dataSource, Str, index) -> Int in
            1
        }

        data.bind(to: tv.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
}

extension HomeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

struct PageSection {
    var name: String
    var contents: [Page]
}

struct Page {
    enum `Type` {
        case line
        case uber
        case google
        case pinkoi
    }
    let name: String
    let type: Type
    let color: [UIColor]
    
}

extension PageSection: SectionModelType {
    var items: [Page] {
        contents
    }

    init(original: PageSection, items: [Page]) {
        self = original
        contents = items
    }

    typealias Item = Page
}
