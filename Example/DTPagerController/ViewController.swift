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
        let button = UIButton(type: UIButtonType.custom)
        button.backgroundColor = UIColor.black
        button.setTitle("Push", for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.addSubview(button)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2)
        scrollView.frame = view.bounds
        
        let buttonHeight: CGFloat = 50
        let buttonWidth: CGFloat = 100
        button.frame = CGRect(x: (view.bounds.width - buttonWidth)/2, y: (view.bounds.height - buttonHeight)/2, width: buttonWidth, height: buttonHeight)
        button.layer.cornerRadius = buttonHeight/2
    }

    @objc func buttonTapped() {
        if pagerController is PagerController {
            let pagerController = PagerController()
            navigationController?.pushViewController(pagerController, animated: true)
        }
        else {
            let pagerController = CustomPagerController()
            navigationController?.pushViewController(pagerController, animated: true)
        }
    }
}

