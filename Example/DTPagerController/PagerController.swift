//
//  PagerController.swift
//  DTPagerController
//
//  Created by Admin on 22/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import DTPagerController

class PagerController: DTPagerController {
    init() {
        super.init(viewControllers: [])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewController1 = ViewController()
        viewController1.title = "Test 1"
        viewController1.scrollView.backgroundColor = UIColor.green
        
        let viewController2 = ViewController()
        viewController2.title = "Test 2"
        viewController2.scrollView.backgroundColor = UIColor.purple
        
        viewControllers = [viewController1, viewController2]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
