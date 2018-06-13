//
//  DTSegmentedControl.swift
//  Pods
//
//  Created by Admin on 15/09/2017.
//
//

import UIKit

// Protocol
// SegmentedControl
public protocol DTSegmentedControlProtocol {
    
    var selectedSegmentIndex: Int { get set }
    
    func setTitle(_ title: String?, forSegmentAt segment: Int)
    
    func setImage(_ image: UIImage?, forSegmentAt segment: Int)
    
    func setTitleTextAttributes(_ attributes: [AnyHashable : Any]?, for state: UIControlState)
    
}

open class DTSegmentedControl: UISegmentedControl, DTSegmentedControlProtocol {
    public override init(items: [Any]?) {
        super.init(items: items)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        tintColor = UIColor.clear
        setDividerImage(UIImage(), forLeftSegmentState: UIControlState(), rightSegmentState: UIControlState.selected, barMetrics: UIBarMetrics.default)
        setDividerImage(UIImage(), forLeftSegmentState: UIControlState.selected, rightSegmentState: UIControlState(), barMetrics: UIBarMetrics.default)
    }

}
