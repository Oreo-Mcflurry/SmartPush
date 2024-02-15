//
//  DetailView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/16/24.
//

import UIKit
import SnapKit

class DetailView: BaseUIView {
	let tableView = UITableView()

	override func configureHierarchy() {
		addSubview(tableView)
	}

	override func configureLayout() {
		tableView.snp.makeConstraints {
			$0.edges.equalTo(self.safeAreaLayoutGuide)
		}
	}
}
