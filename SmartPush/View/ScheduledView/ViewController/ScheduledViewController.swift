//
//  ScheduledViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import RealmSwift
import FSCalendar

class ScheduledViewController: BaseViewController {

	let scheduledView = ScheduledView()
	var datas: Results<PushModel>!

	override func loadView() {
		self.view = scheduledView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		navigationItem.title = "캘린더"
		navigationController?.navigationBar.prefersLargeTitles = true
		setCalendar()
		setTableView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		datas = RealmManager().fetchDataWithDate(date: Date())
	}
}

extension ScheduledViewController: UITableViewDelegate, UITableViewDataSource {
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
		cell.imageView?.image = RealmManager().loadImageToDocument(withId: "\(datas[indexPath.row].id)")
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = AddScheduleViewController()
		vc.isEdit = true
		// vc.data를 var로 바꾸고 값을 그대로 넣을라했는데, 메모리 주소까지 복사되는 바람에 realm.write밖에서 수정하지 말라는 오류 발생.
		vc.id = datas[indexPath.row].id
		vc.deadline = datas[indexPath.row].deadlineDate
		vc.category = datas[indexPath.row].category!
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

	func setTableView() {
		scheduledView.tableView.dataSource = self
		scheduledView.tableView.delegate = self
		scheduledView.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
	}
}

extension ScheduledViewController: FSCalendarDelegate, FSCalendarDataSource {
	func setCalendar() {
		scheduledView.calender.delegate = self
		scheduledView.calender.dataSource = self
	}

	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		datas = RealmManager().fetchDataWithDate(date: date)
		scheduledView.tableView.reloadData()
	}

	func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
		return RealmManager().fetchDataWithDate(date: date).count
	}
}

extension ScheduledViewController: TodoDelegate {
	func todoButtonTapped(id: UUID) {
		RealmManager().todoUpdate(id)
		scheduledView.tableView.reloadData()
		showToast(withString: "다했다옹")
	}
}

extension ScheduledViewController: StaredDelegate {
	func starButtonTapped(id: UUID) {
		RealmManager().starUpdate(id)
		scheduledView.tableView.reloadData()
		showToast(withString: "중요하다옹")
	}
}
