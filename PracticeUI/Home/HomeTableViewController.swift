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
        v.register(cellWithClass: HomeTableCell.self)
        // v.register(nibWithCellClass: HomeTableCell.self)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupUI() {
        tv.rx.setDelegate(self).disposed(by: disposeBag)

        let data = Observable.just([
            PageSection(name: "Section A", contents: [
                Page(name: "TabBar", type: .tabbar, color: [.random,.random]),
                Page(name: "Font Size", type: .font, color: [.random,.random]),
                Page(name: "Locale", type: .locale, color: [.random,.random]),
                Page(name: "Barcode", type: .barcode, color: [.random,.random]),
                Page(name: "Shaped Tab Bar", type: .tabbar, color: [.random, .random]),
                Page(name: "Line Pay", type: .line,
                     color: [.random, .random]),
                Page(name: "Uber", type: .uber,
                     color: [.random, .random]),
                Page(name: "Pinkoi", type: .pinkoi,
                     color: [.random, .random]),
                Page(name: "Google Photo", type: .google,
                     color: [.random, .random])
            ]),
        ])

        let dataSource = RxTableViewSectionedReloadDataSource<PageSection>(configureCell: { (dataSource, tableView, indexPath, page) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withClass: HomeTableCell.self, for: indexPath)
            // cell.titleLabel.text = page.name
            // cell.bgView.applyGradient(colors: page.color)
            cell.nameLabel.text = page.name
            cell.gradientView.applyGradient(colors: page.color)
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
        tv.rx.modelSelected(Page.self).subscribe(onNext: { [weak self] page in
            switch page.type {
            case .barcode:
                self?.navigationController?.pushViewController(BarcodeVC())
            case .line:
                self?.navigationController?.pushViewController(LinePayHomeVC(), animated: true)
            case .uber:
                break
            case .google:
                break
            case .pinkoi:
                break
            case .tabbar:
                let tab = BDTabBarController()
                let vc1 = BDBaseViewController()
                let vc2 = BDBaseViewController()
                let vc3 = BDBaseViewController()
                
                let vcItem1 = BDTabBarItem()
                let vcItem2 = BDTabBarItem()
                let vcItem3 = BDTabBarItem()
                
                vcItem1.title = "Page1"
                vcItem2.title = "Page2"
                vcItem3.title = "Page3"
                
                vcItem1.image = UIImage.init(named: "home")
                vcItem1.selectedImage = UIImage.init(named: "home_1")
                vcItem2.image = UIImage.init(named: "find")
                vcItem2.selectedImage = UIImage.init(named: "find_1")
                vcItem3.image = UIImage.init(named: "favor")
                vcItem3.selectedImage = UIImage.init(named: "favor_1")
                
                
                
                vc1.tabBarItem = vcItem1
                vc2.tabBarItem = vcItem2
                vc3.tabBarItem = vcItem3
                
                tab.setViewControllers(vcs: [vc1,vc2,vc3])
                
                self?.navigationController?.pushViewController(tab)
            case .locale:
                self?.navigationController?.pushViewController(LocalizationDemoVC())
            case .font:
                self?.navigationController?.pushViewController(FontSizeVC())

            }

                
        }, onError: { error in
            print(error.localizedDescription)
        }, onCompleted: {
            print("complete")
        }).disposed(by: disposeBag)
    }
}

extension HomeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
        case tabbar
        case barcode
        case locale
        case font
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
