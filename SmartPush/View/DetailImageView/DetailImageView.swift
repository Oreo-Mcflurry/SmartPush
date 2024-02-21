//
//  DetailImageView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/21/24.
//

import UIKit
import SnapKit

class DetailImageView: BaseViewController {
	let scrollView = UIScrollView()
	lazy var imageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFill
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setSCrollView()
	}

	override func configureHierarchy() {
		view.addSubview(scrollView)
		scrollView.addSubview(imageView)
	}

	override func configureLayout() {
		scrollView.snp.makeConstraints {
			$0.edges.equalTo(view.safeAreaLayoutGuide)
		}

		imageView.snp.makeConstraints {
			$0.center.equalTo(scrollView)
			$0.width.equalTo(view)
		}
	}
}

extension DetailImageView: UIScrollViewDelegate {
	func setSCrollView() {
		scrollView.delegate = self
		scrollView.zoomScale = 1.0
		scrollView.minimumZoomScale = 1.0
		scrollView.maximumZoomScale = 10.0
	}

	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return self.imageView
	}
}
