//
//  SelectDateView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/15/24.
//

import UIKit
import SnapKit

class SelectDateView: BaseViewController {

	let datePicker = UIDatePicker()

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		NotificationCenter.default.post(name: NSNotification.Name(NotificationName.date.rawValue), object: nil, userInfo: [NotificationName.date.rawValue: datePicker.date])
	}

	override func configureHierarchy() {
		view.addSubview(datePicker)
	}

	override func configureLayout() {
		datePicker.snp.makeConstraints {
			$0.top.horizontalEdges.equalToSuperview().inset(10)
		}
	}

	override func configureView() {
		datePicker.datePickerMode = .date
		datePicker.preferredDatePickerStyle = .inline
	}
}
