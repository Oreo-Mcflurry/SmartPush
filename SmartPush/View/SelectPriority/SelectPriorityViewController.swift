//
//  SelectPriorityViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/17/24.
//

import UIKit
import SnapKit

class PriorityViewController: BaseViewController {

	let button1 = UIButton()
	let button2 = UIButton()
	let button3 = UIButton()

	var completionHandler: ((Int)->Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureHierarchy() {
		view.addSubview(button1)
		view.addSubview(button2)
		view.addSubview(button3)
	}

	override func configureLayout() {
		button1.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
		}

		button2.snp.makeConstraints {
			$0.top.equalTo(button1.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
		}

		button3.snp.makeConstraints {
			$0.top.equalTo(button2.snp.bottom).offset(10)
			$0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
		}
	}

	override func configureView() {
		var cnt = 0
		[button1, button2, button3].forEach {
			$0.backgroundColor = .gray
			$0.tintColor = .white
			$0.tag = cnt
			$0.setTitle(RealmManager().getPriority(withPriority: cnt), for: .normal)
			cnt += 1
			$0.addTarget(self, action: #selector(tapPriority(sender:)), for: .touchUpInside)
		}
	}

	@objc func tapPriority(sender: UIButton) {
		completionHandler?(sender.tag)
		navigationController?.popViewController(animated: true)
	}
}
