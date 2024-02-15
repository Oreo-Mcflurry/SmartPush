//
//  DetailViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/16/24.
//

import UIKit
import RealmSwift

class DetailViewController: BaseViewController {

	let detailView = DetailView()
	var type: ListItems = .all
	var datas: [PushModel] = []

	override func loadView() {
		self.view = detailView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
		navigationItem.title = type.rawValue
		let realm = try! Realm()
		datas = ListItems.getFilteredData(enumCase: type, datas: realm.objects(PushModel.self).shuffled())
		detailView.tableView.reloadData()
	}
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
		cell.textLabel?.text = "\(datas[indexPath.row].deadline)"
		return cell
	}
	
	func setTableView() {
		detailView.tableView.delegate = self
		detailView.tableView.dataSource = self
		detailView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Test")
	}
}
