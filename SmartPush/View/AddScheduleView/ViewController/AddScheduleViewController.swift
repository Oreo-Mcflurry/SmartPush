//
//  AddScheduleViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import RealmSwift

class AddScheduleViewController: BaseViewController, PassCategoryDelegate {

	let addView = AddScheduleView()
	let data = PushModel()

	override func loadView() {
		self.view = addView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
		navigationItem.leftBarButtonItem = cancelButton

		let addButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
		navigationItem.rightBarButtonItem = addButton

		addView.selectCategory.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
		addView.selectDays.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
	}

	func passCategory(text: String) {
		data.category = text
		addView.selectCategory.setTitle(text, for: .normal)
	}

	@objc func categoryButtonTapped() {
		let vc = SelectCategoryViewController()
		vc.delegate = self
//		transition(withStyle: .push, viewController: vc) // <-트렌지션이 이런 단점이.. 이거 못넘기는군요
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc func dateButtonTapped() {
		NotificationCenter.default.addObserver(self, selector: #selector(dateReceive(noti:)), name: NSNotification.Name(NotificationName.date.rawValue), object: nil)
		transition(withStyle: .push, viewController: SelectDateView.self)
	}

	@objc func dateReceive(noti: NSNotification) {
		if let value = noti.userInfo?[NotificationName.date.rawValue] as? Date {
			data.deadline = value
			addView.selectDays.setTitle("\(value)", for: .normal)
		}
	}

	@objc func cancelButtonClicked() {
		dismiss(animated: true)
	}

	@objc func saveButtonClicked() {
		dismiss(animated: true)
		data.title = addView.senderTextField.text!
		data.memo = addView.memoTextField.text
		let relam = try! Realm()
		try! relam.write {
			relam.add(data)
		}
	}
}

protocol PassCategoryDelegate {
	func passCategory(text: String)
}

//extension AddScheduleViewController: UITableViewDelegate, UITableViewDataSource {
//
//	func numberOfSections(in tableView: UITableView) -> Int {
//		return TableViewSection.allCases.count
//	}
//
//	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//		return TableViewSection.allCases[section].rawValue
//	}
//
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return 1
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//		if indexPath.section == 0 {
//			let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as! TextFieldCell
//			cell.selectionStyle = .none
//			cell.isUserInteractionEnabled = true
//			return cell
//		}
//		let cell = tableView.dequeueReusableCell(withIdentifier: "Test", for: indexPath)
//		cell.textLabel?.text = TableViewSection.allCases[indexPath.row].rawValue
//
//		return cell
//	}
//
//	func setTableView() {
//		addView.tableView.delegate = self
//		addView.tableView.dataSource = self
//		addView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Test")
//		addView.tableView.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.identifier)
//		addView.tableView.backgroundColor = .clear
//		addView.tableView.rowHeight = UITableView.automaticDimension
//	}
//}
//
//extension AddScheduleViewController {
//	enum TableViewSection: String, CaseIterable {
//		case title = ""
//	}
//}
