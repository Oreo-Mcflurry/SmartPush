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
	let imagesView = UIImageView()

	var id: UUID?
	var tododelegate: TodoDelegate?
	var starDelegate: StaredDelegate?

	override func configureHierarchy() {
		// 와 contentView 이거... 까먹고 있었네요... 이거때문에 3시간 이상 날린거같은데....
		[titleLabel, memoLabel, categoryLabel, checkButton, starButton, imagesView].forEach { self.contentView.addSubview($0) }
	}

	override func configureLayout() {
		checkButton.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.leading.equalToSuperview().inset(10)
			$0.size.equalTo(40)
		}

		starButton.snp.makeConstraints {
			$0.trailing.equalToSuperview().inset(10)
			$0.centerY.equalToSuperview()
			$0.size.equalTo(40)
		}

		imagesView.snp.makeConstraints {
			$0.centerY.equalToSuperview()
//			$0.leading.equalTo(titleLabel)
			$0.trailing.equalTo(starButton.snp.leading).offset(-10)
			$0.size.equalTo(45)
		}

		titleLabel.snp.makeConstraints {
			$0.top.equalTo(self.contentView.snp.top)
			$0.leading.equalTo(checkButton.snp.trailing).offset(10)
			$0.trailing.equalTo(imagesView.snp.leading).offset(-10)
		}

		memoLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(10)
			$0.leading.equalTo(titleLabel)
			$0.trailing.equalTo(imagesView.snp.leading).offset(-10)
		}

		categoryLabel.snp.makeConstraints {
			$0.top.equalTo(memoLabel.snp.bottom).offset(10)
			$0.leading.equalTo(titleLabel)
			$0.trailing.equalTo(imagesView.snp.leading).offset(-10)
			$0.bottom.equalToSuperview()
		}


	}

	override func configureView() {
		self.checkButton.addTarget(self, action: #selector(todoButtonClicked), for: .touchUpInside)
		self.starButton.addTarget(self, action: #selector(starButtonClicked), for: .touchUpInside)
	}

	@objc func todoButtonClicked() {
		tododelegate?.todoButtonTapped(id: id!)
	}

	@objc func starButtonClicked() {
		starDelegate?.starButtonTapped(id: id!)
	}
}
