//
//  AddScheduleViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class AddScheduleViewController: BaseViewController {
	let addView = AddScheduleView()

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
	}

	@objc func cancelButtonClicked() {
		dismiss(animated: true)
	}

	@objc func saveButtonClicked() {
		// TODO: 저장기능
	}
}
