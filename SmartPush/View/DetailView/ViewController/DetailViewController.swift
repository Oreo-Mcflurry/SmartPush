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
	var datas: Results<PushModel>!

	override func loadView() {
		self.view = detailView
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		detailView.tableView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
		navigationItem.title = type.rawValue
		datas = ListItems.getFilteredData(enumCase: type, datas: RealmManager().fetchData())
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

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = AddScheduleViewController()
		vc.isEdit = true
		// vc.data를 var로 바꾸고 값을 그대로 넣을라했는데, 메모리 주소까지 복사되는 바람에 realm.write밖에서 수정하지 말라는 오류 발생.
		vc.data.id = datas[indexPath.row].id
		vc.data.deadline = datas[indexPath.row].deadline
		vc.data.category = datas[indexPath.row].category
		vc.data.memo = datas[indexPath.row].memo
		vc.data.title = datas[indexPath.row].title
		vc.data.stared = datas[indexPath.row].stared
		vc.data.addDate = datas[indexPath.row].addDate
		vc.data.complete = datas[indexPath.row].complete
		vc.data.priority = datas[indexPath.row].priority
		let nav = UINavigationController(rootViewController: vc)
		nav.modalPresentationStyle = .fullScreen
		present(nav, animated: true)
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			RealmManager().deleteItem(datas[indexPath.row])
			detailView.tableView.reloadData()
		}
	}

	func setTableView() {
		detailView.tableView.delegate = self
		detailView.tableView.dataSource = self
		detailView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Test")
	}
}
