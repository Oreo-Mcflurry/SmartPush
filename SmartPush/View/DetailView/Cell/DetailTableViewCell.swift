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
		checkButton.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.leading.equalToSuperview().inset(10)
			$0.size.equalTo(40)
		}

		titleLabel.snp.makeConstraints {
			$0.top.equalToSuperview().inset(10)
			$0.leading.equalTo(starButton.snp.trailing).offset(10)
		}

		memoLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(10)
			$0.leading.equalTo(titleLabel)
		}

		categoryLabel.snp.makeConstraints {
			$0.top.equalTo(memoLabel.snp.bottom).offset(10)
			$0.leading.equalTo(titleLabel)
		}

		starButton.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(10)
			$0.centerY.equalToSuperview()
			$0.size.equalTo(40)
			$0.leading.lessThanOrEqualTo(titleLabel.snp.trailing)
		}
	}
}
