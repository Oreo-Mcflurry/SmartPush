//
//  DetailViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/16/24.
//

import UIKit
import RealmSwift

protocol TodoDelegate: AnyObject {
	func todoButtonTapped(id: UUID)
}

protocol StaredDelegate: AnyObject {
	func starButtonTapped(id: UUID)
}

class DetailViewController: BaseViewController {

	let detailView = DetailView()
	var type: ListItems = .all
	var datas: Results<PushModel>!
	var category: Categorys? = nil

	override func loadView() {
		self.view = detailView
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		detailView.tableView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		setTableView()
		if category == nil {
			navigationItem.title = type.rawValue
			datas = ListItems.getFilteredData(enumCase: type, datas: RealmManager().fetchData())
		} else {
			navigationItem.title = category!.category
			datas = RealmManager().fetchData().where { $0.category == category}
		}
		detailView.tableView.reloadData()

		var menuItems: [UIAction] {
			return [
				UIAction(title: "날짜 순", image: nil, handler: { (_) in
					self.datas = self.datas.sorted(byKeyPath: "deadline", ascending: true)
					self.detailView.tableView.reloadData()
				}),
				UIAction(title: "날짜 역순", image: nil, handler: { (_) in
					self.datas = self.datas.sorted(byKeyPath: "deadline", ascending: false)
					self.detailView.tableView.reloadData()
				}),
				UIAction(title: "중요도 순", image: nil, handler: { (_) in
					self.datas = self.datas.sorted(byKeyPath: "priority", ascending: true)
					self.detailView.tableView.reloadData()
				}),
				UIAction(title: "중요도 역순", image: nil, handler: { (_) in
					self.datas = self.datas.sorted(byKeyPath: "priority", ascending: false)
					self.detailView.tableView.reloadData()
				}),
			]
		}
		let demoMenu: UIMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "sort", image: nil, primaryAction: nil, menu: demoMenu)


	}
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datas.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
		cell.titleLabel.text = RealmManager().getTitle(datas[indexPath.row])
		cell.memoLabel.text = datas[indexPath.row].memo
		cell.categoryLabel.text = datas[indexPath.row].category?.category
		cell.tododelegate = self
		cell.starDelegate = self
		cell.id = datas[indexPath.row].id
		cell.checkButton.setImage(RealmManager().getTodoSign(withBool: datas[indexPath.row].complete), for: .normal)
		cell.starButton.setImage(RealmManager().getStarSign(withBool: datas[indexPath.row].stared), for: .normal)
		cell.imagesView.setImage(RealmManager().loadImageToDocument(withId: "\(datas[indexPath.row].id)"), for: .normal)
		cell.completionHandler = { vc in
			self.present(vc, animated: true)
		}
		return cell
	}

	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = AddScheduleViewController()
		vc.isEdit = true
		// vc.data를 var로 바꾸고 값을 그대로 넣을라했는데, 메모리 주소까지 복사되는 바람에 realm.write밖에서 수정하지 말라는 오류 발생.
		vc.id = datas[indexPath.row].id
		vc.deadline = datas[indexPath.row].deadlineDate
		vc.category = datas[indexPath.row].category
		vc.memo = datas[indexPath.row].memo
		vc.titlestr = datas[indexPath.row].title
		vc.stared = datas[indexPath.row].stared
		vc.addDate = datas[indexPath.row].addDate
		vc.complete = datas[indexPath.row].complete
		vc.priority = datas[indexPath.row].priority
		let nav = UINavigationController(rootViewController: vc)
		nav.modalPresentationStyle = .fullScreen
		present(nav, animated: true)
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			RealmManager().deleteImageToDocument(withId: "\(datas[indexPath.row].id)")
			RealmManager().deleteItem(datas[indexPath.row])
			detailView.tableView.reloadData()
		}
	}

	func setTableView() {
		detailView.tableView.delegate = self
		detailView.tableView.dataSource = self
		detailView.tableView.rowHeight = UITableView.automaticDimension
		detailView.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
	}
}

extension DetailViewController: TodoDelegate {
	func todoButtonTapped(id: UUID) {
		RealmManager().todoUpdate(id)
		detailView.tableView.reloadData()
		showToast(withString: "다했다옹")
	}
}

extension DetailViewController: StaredDelegate {
	func starButtonTapped(id: UUID) {
		RealmManager().starUpdate(id)
		detailView.tableView.reloadData()
		showToast(withString: "중요하다옹")
	}
}
