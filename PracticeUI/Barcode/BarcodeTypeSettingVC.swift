//
// BarcodeTypeSettingVC.swift
//
// Created by Ben for PracticeUI on 2021/2/24.
// Copyright © 2021 Alien. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeTypeSettingVC: UITableViewController {

    let store = BarcodeSettingStore.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        tableView.register(cellWithClass: UITableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.settingStates().count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let state = store.settingStates()[indexPath.row]
        store.swap(state)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        let type = store.settingStates()[indexPath.row]
        cell.textLabel?.text = type.type.rawValue
        
        cell.accessoryType = type.isOn ? .checkmark : .none
        // Configure the cell...

        return cell
    }
    

}
