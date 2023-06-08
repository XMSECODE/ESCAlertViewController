//
//  ESCAlertAction.swift
//  Swift_ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//

import UIKit

class ESCAlertAction: NSObject {
    
    var title:String?
    
    var titleColor:UIColor?
    
    var handler:((_ alertAction:ESCAlertAction)->Void)?
    
    public init(title: String? = nil, titleColor: UIColor? = nil,handler:@escaping ((_ alertAction:ESCAlertAction)->Void)) {
        self.title = title
        self.titleColor = titleColor
        self.handler = handler
    }
    


}
