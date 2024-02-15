//
//  SelectCategoryViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/15/24.
//

import UIKit
import SnapKit

class SelectCategoryViewController: BaseViewController {

	let textField = UITextField()
	var delegate: PassCategoryDelegate?

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		delegate?.passCategory(text: textField.text!)
	}

	override func configureHierarchy() {
		view.addSubview(textField)
	}

	override func configureLayout() {
		textField.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
		}
	}

	override func configureView() {
		textField.placeholder = "카테고리 입력"
	}
}
