//
//  ViewController.swift
//  Swift_ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func didClickAlertButton(_ sender: Any) {
        
        let action1 = ESCAlertAction(title: "确认", titleColor: .blue) { alertAction in
            
        }
        let action2 = ESCAlertAction(title: "取消", titleColor: .gray) { alertAction in
            
        }
        let alertController = ESCAlertViewController(isFirstDismissViewController: false, message: "内容", titleString: "标题", actionArray: [action1,action2])
        self.present(alertController, animated: true)
    }
}

