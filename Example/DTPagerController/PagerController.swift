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
        viewController1.title = "VC 1"
        viewController1.scrollView.backgroundColor = UIColor.green
        
        let viewController2 = ViewController()
        viewController2.title = "VC 2"
        viewController2.scrollView.backgroundColor = UIColor.purple
        
        let viewController3 = ViewController()
        viewController3.title = "VC 3"
        viewController3.scrollView.backgroundColor = UIColor.red
        
        viewControllers = [viewController1, viewController2, viewController3]
        
        // Change the height of segmented control
        self.preferredSegmentedControlHeight = 42
        
        // Change normal font of each segmented control
        self.font = UIFont.systemFont(ofSize: 15)
        
        // Change selected font of each segmented control
        self.selectedFont = UIFont.systemFont(ofSize: 15)
        
        // Change normal text color of each segmented control
        self.textColor = UIColor.black
        
        // Change selected text color of each segmented control
        self.selectedTextColor = UIColor.red
        
        // Change scroll indicator height
        self.perferredScrollIndicatorHeight = 3
        
        // Change scroll indicator color
        self.scrollIndicator.backgroundColor = UIColor.black
        
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
