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

    func insertSegment(withTitle title: String?, at segment: Int, animated: Bool) // insert before segment number. 0..#segments. value pinned
    
    func insertSegment(with image: UIImage?, at segment: Int, animated: Bool)
    
    func removeSegment(at segment: Int, animated: Bool)
    
    func removeAllSegments()
    
    func setTitle(_ title: String?, forSegmentAt segment: Int) // can only have image or title, not both. must be 0..#segments - 1 (or ignored). default is nil
    
    func titleForSegment(at segment: Int) -> String?
    
    func setTitleTextAttributes(_ attributes: [AnyHashable : Any]?, for state: UIControlState)
    
    func titleTextAttributes(for state: UIControlState) -> [AnyHashable : Any]?
    
}

open class DTSegmentedControl: UISegmentedControl, DTSegmentedControlProtocol {
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
