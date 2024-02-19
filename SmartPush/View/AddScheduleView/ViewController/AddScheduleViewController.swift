//
//  AddScheduleViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import RealmSwift

class AddScheduleViewController: BaseViewController, PassCategoryDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	let addView = AddScheduleView()
	let data = PushModel()
	var isEdit = false

	// 변수를 하나하나 만들었다면, 전부 검사할 수 있었을거같은데, data에 기본값을 넣어버린 바람에 제한적이네요.
	var saveButtonEnabled: Bool {
		return addView.senderTextField.text!.isEmpty && data.category.isEmpty
	}

	override func loadView() {
		self.view = addView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		if isEdit {
			addView.selectCategory.setTitle(data.category, for: .normal)
			addView.selectDays.setTitle("\(data.deadline)", for: .normal)
			addView.memoTextField.text = data.memo
			addView.senderTextField.text = data.title
			addView.selectPriority.setTitle(RealmManager().getPriority(withPriority: data.priority), for: .normal)
			addView.imageView.image = RealmManager().loadImageToDocument(withId: "\(data.id)")
			navigationItem.title = "수정"
		} else {
			navigationItem.title = "추가"
		}
	}

	override func configureView() {
		let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonClicked))
		navigationItem.leftBarButtonItem = cancelButton

		let addButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
		navigationItem.rightBarButtonItem = addButton

		addView.selectCategory.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
		addView.selectDays.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
		addView.selectPriority.addTarget(self, action: #selector(priortyButtonTapped), for: .touchUpInside)
		let menuItems: [UIAction] = [
			 UIAction(title: "사진첩에서 가져오기", image: nil, handler: { (_) in
				  let vc = UIImagePickerController()
				  vc.allowsEditing = true
				  vc.delegate = self
				  self.present(vc, animated: true)
			 }),
			 UIAction(title: "카메라로 촬영", image: nil, handler: { (_) in
				  let imagePicker = UIImagePickerController()
				  imagePicker.delegate = self
				  imagePicker.sourceType = .camera
				  imagePicker.allowsEditing = true
				  self.present(imagePicker, animated: true, completion: nil)
			 }),
		]
	  addView.imageButton.menu = UIMenu(title: "title입니다",image: UIImage(systemName: "heart.fill"),identifier: nil,options: .displayInline,children: menuItems)
		addView.imageButton.showsMenuAsPrimaryAction = true
	}


	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			addView.imageView.image = pickedImage
		}
		dismiss(animated: true)
	}

	func passCategory(text: String) {
		data.category = text
		addView.selectCategory.setTitle(text, for: .normal)
	}

	@objc func priortyButtonTapped() {
		let vc = PriorityViewController()
		vc.completionHandler = { result in
			self.data.priority = result
			print(result)
			self.addView.selectPriority.setTitle(RealmManager().getPriority(withPriority: result), for: .normal)
		}
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc func categoryButtonTapped() {
		let vc = SelectCategoryViewController()
		vc.delegate = self
		vc.textField.text = data.category
		navigationController?.pushViewController(vc, animated: true)
	}

	@objc func dateButtonTapped() {
		NotificationCenter.default.addObserver(self, selector: #selector(dateReceive(noti:)), name: NSNotification.Name(NotificationName.date.rawValue), object: nil)
		let vc = SelectDateView()
		vc.datePicker.date = data.deadline
		navigationController?.pushViewController(vc, animated: true)
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

		if saveButtonEnabled {
			showToast(withString: "제목 또는 카테고리는 필수로 입력해주세요")
			return
		}

		data.title = addView.senderTextField.text!
		data.memo = addView.memoTextField.text

		if isEdit {
			dismiss(animated: true)
			RealmManager().updateItem(data)
			RealmManager().deleteImageToDocument(withId: "\(data.id)")
		} else {
			dismiss(animated: true)
			RealmManager().addItem(data)

		}
		RealmManager().saveImageToDocument(image: addView.imageView.image ?? UIImage(systemName: "star")!, withId: "\(data.id)")
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
