//
//  UINavigation+Extension.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

extension UINavigationController {
	open override func viewWillLayoutSubviews() {
		navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
}
