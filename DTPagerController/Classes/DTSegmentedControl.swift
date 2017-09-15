//
//  DTSegmentedControl.swift
//  Pods
//
//  Created by Admin on 15/09/2017.
//
//

import UIKit

open class DTSegmentedControl: UISegmentedControl {
    public override init(items: [Any]?) {
        super.init(items: items)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        // addSidedBorder(UIRectEdge.bottom, color: UIColor.appBorderLine, thickness: 1/UIScreen.main.scale)
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
