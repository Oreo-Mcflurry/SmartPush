//
//  ScheduledView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/19/24.
//

import UIKit
import SnapKit
import FSCalendar

class ScheduledView: BaseUIView {
	let calender = FSCalendar()
	let tableView = UITableView()

	override func configureHierarchy() {
		[calender,tableView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		calender.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
			$0.height.equalTo(300)
		}

		tableView.snp.makeConstraints {
			$0.top.equalTo(calender.snp.bottom)
			$0.bottom.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
		}
	}

	override func configureView() {
		calender.locale = Locale(identifier: "ko_KR")
	}
}
