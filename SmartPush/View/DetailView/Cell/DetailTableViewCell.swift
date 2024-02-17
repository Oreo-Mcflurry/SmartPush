//
//  DetailTableView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/17/24.
//

import UIKit
import SnapKit

class DetailTableViewCell: BaseTableViewCell {
	let titleLabel = UILabel()
	let memoLabel = UILabel()
	let categoryLabel = UILabel()
	let checkButton = UIButton()
	let starButton = UIButton()

	override func configureHierarchy() {
		[titleLabel, memoLabel, categoryLabel, checkButton, starButton].forEach { addSubview($0) }
	}

	override func configureLayout() {
		<#code#>
	}
}
