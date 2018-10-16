//
//  TextViewFixed.swift
//  edl21-control
//
//  Created by Marius Montebaur on 18.10.17.
//  Copyright © 2017 Marius Montebaur. All rights reserved.
//

import UIKit


@IBDesignable class UITextViewFixed: UITextView {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}
