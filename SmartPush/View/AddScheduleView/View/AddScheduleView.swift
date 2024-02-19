//
//  AddScheduleView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import SnapKit
import TextFieldEffects

class AddScheduleView: BaseUIView {
	let senderTextField = HoshiTextField()
	let memoTextField = HoshiTextField()
	let selectDays = UIButton()
	let selectCategory = UIButton()
	let selectPriority = UIButton()
	let imageView = UIImageView()
	let imageButton = UIButton()

	override func configureHierarchy() {
		[senderTextField, memoTextField, selectDays, selectCategory, selectPriority, imageView, imageButton].forEach { self.addSubview($0) }
	}

	override func configureLayout() {
		senderTextField.snp.makeConstraints {
			$0.top.equalTo(self.safeAreaLayoutGuide)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(55)
		}

		memoTextField.snp.makeConstraints {
			$0.top.equalTo(senderTextField.snp.bottom).offset(20)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(55)
		}

		selectDays.snp.makeConstraints {
			$0.top.equalTo(memoTextField.snp.bottom).offset(20)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(55)
		}

		selectCategory.snp.makeConstraints {
			$0.top.equalTo(selectDays.snp.bottom).offset(20)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(55)
		}

		selectPriority.snp.makeConstraints {
			$0.top.equalTo(selectCategory.snp.bottom).offset(20)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(55)
		}

		imageView.snp.makeConstraints {
			$0.top.equalTo(selectPriority.snp.bottom).offset(20)
			$0.centerX.equalToSuperview()
			$0.size.equalTo(150)
		}

		imageButton.snp.makeConstraints {
			$0.top.equalTo(imageView.snp.bottom).offset(20)
			$0.horizontalEdges.equalToSuperview().inset(20)
			$0.height.equalTo(55)
		}
	}

	override func configureView() {
		senderTextField.placeholder = "알림을 보내는 사람을 적어주세요."
		memoTextField.placeholder = "메모를 입력해주세요 (옵션)"
		[senderTextField, memoTextField].forEach {
			$0.placeholderColor = .gray
			$0.borderActiveColor = .red
			$0.borderInactiveColor = .black
		}

		[selectDays, selectCategory, selectPriority, imageButton].forEach {
			$0.backgroundColor = .systemGray5
			$0.layer.cornerRadius = 15
		}
		selectDays.setTitle("날짜를 선택하세요", for: .normal)
		selectCategory.setTitle("카테고리를 선택하세요", for: .normal)
		selectPriority.setTitle("우선순위를 선택하세요", for: .normal)
		imageButton.setTitle("사진 선택", for: .normal)
		imageView.layer.borderColor = UIColor.black.cgColor
		imageView.layer.borderWidth = 1
	}
}

//class AddScheduleView: BaseUIView {
//	let tableView = UITableView(frame: .zero, style: .insetGrouped)
//
//	override func configureHierarchy() {
//		addSubview(tableView)
//	}
//
//	override func configureLayout() {
//		tableView.snp.makeConstraints {
//			$0.edges.equalTo(self)
//		}
//	}
//}
