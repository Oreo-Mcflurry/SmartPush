//
//  SelectCategoryViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/15/24.
//

import UIKit
import SnapKit
import RealmSwift

class SelectCategoryViewController: BaseViewController {

	let tableView = UITableView()
	let textField = UISearchBar()
	var delegate: PassCategoryDelegate?
	var category: Results<Categorys>!
	override func viewDidLoad() {
		super.viewDidLoad()
		setTableView()
		setTextField()
		category = RealmManager().fetchCategory()
	}

	override func configureHierarchy() {
		view.addSubview(tableView)
		view.addSubview(textField)
	}

	override func configureLayout() {
		textField.snp.makeConstraints {
			$0.height.equalTo(40)
			$0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
		}
		tableView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
			$0.bottom.equalTo(textField.snp.top)
		}

	}

	override func configureView() {
		textField.placeholder = "카테고리 입력"
	}
}

extension SelectCategoryViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return category.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SelectCategoryViewController.identifier, for: indexPath)
		cell.textLabel?.text = "\(category[indexPath.row].category ?? "카테고리 없음") \(category[indexPath.row].main.count)개가 이거 함"
		cell.detailTextLabel?.text = ""
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.passCategory(text: "\(category[indexPath.row].category!)")
		navigationController?.popViewController(animated: true)
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			RealmManager().deleteCategory(category[indexPath.row].id)
			tableView.reloadData()
		}
	}

	func setTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: SelectCategoryViewController.identifier)
	}
}

extension SelectCategoryViewController: UISearchBarDelegate {
	func setTextField() {
		textField.delegate = self
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		RealmManager().addCategory(withString: textField.text!)
		textField.text = ""
		tableView.reloadData()
	}
}
