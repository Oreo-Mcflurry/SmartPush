//
//  AddScheduleView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import SnapKit
import TextFieldEffects

// 도저히 스트레스 받아서..ㅠㅠㅠ 그냥 UI 기능 다 포기하고 학습에 전념할게요...

class AddScheduleView: BaseUIView {
	let senderTextField = HoshiTextField()
	let memoTextField = HoshiTextField()
	let selectDays = UIButton()
	let selectCategory = UIButton()

	override func configureHierarchy() {
		[senderTextField, memoTextField, selectDays, selectCategory].forEach { addSubview($0) }
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
	}

	override func configureView() {
		senderTextField.placeholder = "알림을 보내는 사람을 적어주세요."
		memoTextField.placeholder = "메모를 입력해주세요 (옵션)"
		[senderTextField, memoTextField].forEach {
			$0.placeholderColor = .gray
			$0.borderActiveColor = .red
			$0.borderInactiveColor = .black
		}

		[selectDays, selectCategory].forEach {
			$0.backgroundColor = .systemGray5
			$0.layer.cornerRadius = 15
		}
		selectDays.setTitle("날짜를 선택하세요", for: .normal)
		selectCategory.setTitle("카테고리를 선택하세요", for: .normal)
	}
}


#Preview {
	UINavigationController(rootViewController: AddScheduleViewController())
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
