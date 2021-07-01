//
// LocalizeSettingTableViC.swift
//
// Created by Ben for PracticeUI on 2021/3/17.
// Copyright © 2021 Alien. All rights reserved.
//

import Localize_Swift
import UIKit

class LocalizeSettingTableVC: UIViewController {
    private var tv: UITableView!

    private let langs: [String] = Localize.availableLanguages()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(false, animated: false)
        tv = UITableView()
        view.addSubview(tv)
        tv.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        tv.register(cellWithClass: UITableViewCell.self)
        tv.delegate = self
        tv.dataSource = self
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationController?.navigationBar.barStyle = .default

        func localize() {
            print(R.string.localizable.setting.key.localized())

            navigationItem.title = R.string.localizable.setting.key.localized()
        }
        localize()
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: LCLLanguageChangeNotification), object: nil, queue: .main) { _ in
            localize()
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}

extension LocalizeSettingTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLang = langs[indexPath.row]
        Localize.setCurrentLanguage(selectedLang)
        tv.reloadData()
    }
}

extension LocalizeSettingTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        langs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        let title = Localize.displayNameForLanguage(langs[indexPath.row], dependOnLang: true)
        let currentLang = Localize.currentLanguage()
        if langs[indexPath.row] == currentLang {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = title
        cell.selectionStyle = .none
        return cell
    }
}
