//
//  ESCAlertViewController.swift
//  Swift_ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//

import UIKit

class ESCAlertViewController: UIViewController {
    
    var isFirstDismissViewController:Bool = false
    
    var message:String?
    
    var titleString:String?

    var contentView:UIView?

    var actionArray:[ESCAlertAction]?
    
  

    init(isFirstDismissViewController: Bool, message: String? = nil, titleString: String? = nil, contentView: UIView? = nil, actionArray: [ESCAlertAction]? = nil) {
        
        self.isFirstDismissViewController = isFirstDismissViewController
        self.message = message
        self.titleString = titleString
        self.contentView = contentView
        self.actionArray = actionArray
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    @objc func didClickButton(button:UIButton) {
        if self.isFirstDismissViewController == true {
            let index = button.tag
            self.view.isUserInteractionEnabled = false
            let action = self.actionArray![index]
            self.dismiss(animated: true) {
                action.handler!(action)
            }
        }else{
            let index = button.tag
            self.view.isUserInteractionEnabled = false
            let action = self.actionArray![index]
            action.handler!(action)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: DispatchWorkItem(block: {
                self.dismiss(animated: true)
            }))

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        //设置内容view
        self.view.backgroundColor = .init(white: 0, alpha: 0.6)
        
        let contentView = UIView()
        self.view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 6

        var contentViewHeight = 32
        var titleLabelHeight = 16
        contentViewHeight += titleLabelHeight
        contentViewHeight += 12

        var contentLabelHeight = 0;
        
        let attributedString = NSMutableAttributedString(string: self.message!)
        let paragraphStyle = NSMutableParagraphStyle()
        // 设置文字居中
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineSpacing = 5
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.message!.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: self.message!.count))
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 14), range: NSRange(location: 0, length: self.message!.count))

        if let message = self.message {
            let infoSize = CGSize(width: 300 - 64, height: 100)
            // 默认的
            // let dic = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            // message.boundingRect(with: infoSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: dic, context: nil)
            
            let infoRect = attributedString.boundingRect(with: infoSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
            
            contentLabelHeight = Int(infoRect.size.height + 1)
        }
        
        
        
        contentViewHeight += contentLabelHeight;
        contentViewHeight += 32;
        contentViewHeight += 1;
        var buttonHeight = 48;
        contentViewHeight += buttonHeight;
        
        contentView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(contentViewHeight)
        }
        
      
        
        var titleLabel: UILabel?
        if let titleString = self.titleString, !titleString.isEmpty {
            // 设置标题
            titleLabel = UILabel()
            contentView.addSubview(titleLabel!)
            titleLabel!.textAlignment = .center
            titleLabel!.textColor = .black
            titleLabel!.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel!.text = titleString
            titleLabel!.snp.makeConstraints { make in
                make.left.equalTo(contentView).offset(32)
                make.right.equalTo(contentView).offset(-32)
                make.top.equalTo(contentView).offset(32)
                make.height.equalTo(titleLabelHeight)
            }
        }
 
        // 设置内容
        let contentLabel = UILabel()
        contentView.addSubview(contentLabel)
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 3
        contentLabel.textColor = .black
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.attributedText = attributedString
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.height.equalTo(contentLabelHeight)
            if let titleLabel = titleLabel {
                make.top.equalTo(titleLabel.snp.bottom).offset(13)
                make.width.lessThanOrEqualTo(contentView).offset(-64)
            } else {
                make.top.equalTo(contentView).offset(32)
                make.left.right.equalTo(contentView).inset(32)
            }
        }

        let spaceView = UIView()
        contentView.addSubview(spaceView)
        spaceView.backgroundColor = .gray
        spaceView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(contentLabel.snp.bottom).offset(32)
            make.height.equalTo(1)
        }
       
        
        
       
        var buttonArray = [UIButton]()
        let actionCount = self.actionArray!.count
        for i in 0..<actionCount {
            let action = self.actionArray![i]
            let actionButton = UIButton()
            actionButton.setTitle(action.title, for: .normal)
            actionButton.setTitleColor(action.titleColor, for: .normal)
            actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            buttonArray.append(actionButton)
            contentView.addSubview(actionButton)
            actionButton.addTarget(self, action: #selector(didClickButton(button:)), for: .touchUpInside)
            actionButton.tag = i
        }

        if actionCount == 0 {
            // Do nothing
        } else if actionCount == 1 {
            let button = buttonArray.first!
            button.snp.makeConstraints { make in
                make.left.right.bottom.equalTo(contentView)
                make.top.equalTo(spaceView.snp.bottom)
            }
        } else if actionCount == 2 {
            let centerView = UIView()
            contentView.addSubview(centerView)
            centerView.backgroundColor = .gray
            centerView.snp.makeConstraints { make in
                make.centerX.equalTo(contentView)
                make.bottom.equalTo(contentView)
                make.width.equalTo(1)
                make.top.equalTo(spaceView.snp.bottom)
            }

            let firstButton = buttonArray.first!
            firstButton.snp.makeConstraints { make in
                make.left.bottom.equalTo(contentView)
                make.top.equalTo(spaceView.snp.bottom)
                make.right.equalTo(centerView.snp.left)
            }

            let lastButton = buttonArray.last!
            lastButton.snp.makeConstraints { make in
                make.left.equalTo(centerView.snp.right)
                make.top.equalTo(spaceView.snp.bottom)
                make.bottom.right.equalTo(contentView)
            }
        }
       
    }
    
    public func addAction(action:ESCAlertAction) {
        if self.actionArray == nil {
            self.actionArray = [action]
        }else {
            self.actionArray?.append(action)
        }
    }

}
