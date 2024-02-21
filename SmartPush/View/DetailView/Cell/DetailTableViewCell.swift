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
	let imagesView = UIButton()

	var id: UUID?
	var tododelegate: TodoDelegate?
	var starDelegate: StaredDelegate?
	var completionHandler : ((_ AnyClass: UIViewController)->())?

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
		checkButton.addTarget(self, action: #selector(todoButtonClicked), for: .touchUpInside)
		starButton.addTarget(self, action: #selector(starButtonClicked), for: .touchUpInside)
		imagesView.addTarget(self, action: #selector(imageClicked), for: .touchUpInside)
	}

	@objc func imageClicked() {
		let vc = DetailImageView()
		vc.imageView.image = imagesView.currentImage
		completionHandler?(vc)
	}

	@objc func todoButtonClicked() {
		tododelegate?.todoButtonTapped(id: id!)
	}

	@objc func starButtonClicked() {
		starDelegate?.starButtonTapped(id: id!)
	}
}
