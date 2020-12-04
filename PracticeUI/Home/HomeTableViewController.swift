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
            make.top.left.right.bottom.equalToSuperview()
        }
        v.register(cellWithClass: UITableViewCell.self)

        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        tv.rx.setDelegate(self).disposed(by: disposeBag)

        let data = Observable.just([
            PageSection(name: "Section A", contents: [
                Page(name: "Line Pay", color: .green),
                Page(name: "Uber", color: .black),
            ]),
        ])
        let dataSource = RxTableViewSectionedReloadDataSource<PageSection>(configureCell: { (dataSource, tableView, indexPath, page) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self, for: indexPath)
            cell.textLabel?.text = page.name
            return cell
        }, titleForHeaderInSection: { (dataSource, index) -> String? in
            "A"
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
}

struct PageSection {
    var name: String
    var contents: [Page]
}

struct Page {
    let name: String
    let color: UIColor
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
