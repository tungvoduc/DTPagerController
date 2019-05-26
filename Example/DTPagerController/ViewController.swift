//
//  ViewController.swift
//  DTPagerController
//
//  Created by tungvoduc on 09/15/2017.
//  Copyright (c) 2017 tungvoduc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let scrollView = UIScrollView()

    lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.black
        button.setTitle("Push", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.addSubview(button)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
        scrollView.frame = view.bounds

        let buttonHeight: CGFloat = 50
        let buttonWidth: CGFloat = 100
        // swiftlint:disable line_length
        button.frame = CGRect(x: (view.bounds.width - buttonWidth) / 2, y: (view.bounds.height - buttonHeight) / 2, width: buttonWidth, height: buttonHeight)
        // swiftlint:enable line_length
        button.layer.cornerRadius = buttonHeight / 2
    }

    @objc
    func buttonTapped() {
        if pagerController is PagerController {
            let pagerController = PagerController()
            navigationController?.pushViewController(pagerController, animated: true)
        } else {
            let pagerController = CustomPagerController()
            navigationController?.pushViewController(pagerController, animated: true)
        }
    }
}
