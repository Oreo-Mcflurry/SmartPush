//
//  TextFieldCell.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/15/24.
//

import UIKit

class TextFieldCell: BaseTableViewCell {
	let titleTextfield = UITextField()
	let memoTextField = UITextField()

	override func configureHierarchy() {
		addSubview(titleTextfield)
		addSubview(memoTextField)
	}

	override func configureLayout() {
		titleTextfield.snp.makeConstraints {
			$0.top.equalToSuperview().offset(10)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(35)
		}

		memoTextField.snp.makeConstraints {
			$0.top.equalTo(titleTextfield.snp.bottom)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(80)
			$0.bottom.equalToSuperview().offset(10)
		}
	}

	override func configureView() {
		titleTextfield.placeholder = "Hello"
		memoTextField.placeholder = "gg"
	}
}
