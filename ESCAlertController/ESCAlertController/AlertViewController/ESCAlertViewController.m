//
//  ESCAlertViewController.m
//  ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//


#import "ESCAlertViewController.h"
#import "Masonry.h"


@interface ESCAlertViewController ()

@property(nonatomic,copy)NSString* message;

@property(nonatomic,copy)NSString* titleString;

@property(nonatomic,weak)UIView* contentView;

@property(nonatomic,strong)NSMutableArray<ESCAlertAction *>* actionArray;

@end

@implementation ESCAlertViewController


+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message {
    ESCAlertViewController *alertController = [[ESCAlertViewController alloc] init];
    alertController.message = message;
    alertController.titleString = title;
    return alertController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)addAction:(ESCAlertAction *)action {
    if (action != nil && [action isKindOfClass:[ESCAlertAction class]]) {
        [self.actionArray addObject:action];
    }
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverFullScreen;
}

- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCrossDissolve;
}

- (void)setupUI {
    //设置内容view
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 6;
    
    CGFloat contentViewHeight = 32;
    CGFloat titleLabelHeight = 16;
    contentViewHeight += titleLabelHeight;
    contentViewHeight += 12;

    CGFloat contentLabelHeight = 0;
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.message];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置文字居中
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.message length])];
    [attributedString  addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [self.message length])];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [self.message length])];
    
    if (self.message) {
        CGSize infoSize = CGSizeMake(300 - 64, 100);
//        NSDictionary *dic = @{NSFontAttributeName : FFTextFont(14)};
        //默认的
//        [self.message boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
        
        CGRect infoRect = [attributedString boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil];
        
        contentLabelHeight = infoRect.size.height + 1;
    }
    contentViewHeight += contentLabelHeight;
    contentViewHeight += 32;
    contentViewHeight += 1;
    CGFloat buttonHeight = 48;
    contentViewHeight += buttonHeight;

    //
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.offset(300);
        make.height.offset(contentViewHeight);
    }];
    
    
    UILabel *titleLabel;
    if (self.titleString && self.titleString.length > 0) {
        //设置标题
        //设置内容
        titleLabel = [[UILabel alloc] init];
        [contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(32);
            make.right.equalTo(contentView).offset(-32);
            make.top.equalTo(contentView).offset(32);
            make.height.offset(titleLabelHeight);
        }];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.text = self.titleString;
    }
    
    //设置内容
    UILabel *contentLabel = [[UILabel alloc] init];
    [contentView addSubview:contentLabel];
    if (titleLabel) {
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.height.offset(contentLabelHeight);
            make.top.equalTo(titleLabel.mas_bottom).offset(13);
            make.width.lessThanOrEqualTo(contentView).offset(-64);
        }];
    }

    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 3;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    
    
    contentLabel.attributedText = attributedString;
    
    UIView *spaceView = [[UIView alloc] init];
    [contentView addSubview:spaceView];
    spaceView.backgroundColor = [UIColor grayColor];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentLabel.mas_bottom).offset(32);
        make.height.offset(1);
    }];
    
    //设置按钮
    int actionCount = (int)self.actionArray.count;
    NSMutableArray *buttonArray = [NSMutableArray array];
    for (int i = 0; i < actionCount; i++) {
        ESCAlertAction *action = [self.actionArray objectAtIndex:i];
        UIButton *actionButton = [[UIButton alloc] init];
        [actionButton setTitle:action.title forState:UIControlStateNormal];
        [actionButton setTitleColor:action.titleColor forState:UIControlStateNormal];
        actionButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [buttonArray addObject:actionButton];
        [contentView addSubview:actionButton];
        [actionButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];

        actionButton.tag = i;
    }
    
    
    if (actionCount == 0) {
        
    }else if (actionCount == 1) {
        UIButton *button = [buttonArray firstObject];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(contentView);
            make.top.equalTo(spaceView.mas_bottom);
        }];
    }else if (actionCount == 2) {
        UIView *centerView = [[UIView alloc] init];
        [contentView addSubview:centerView];
        centerView.backgroundColor = [UIColor grayColor];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.bottom.equalTo(contentView);
            make.width.offset(1);
            make.top.equalTo(spaceView.mas_bottom);
        }];
        
        UIButton *firstButton = [buttonArray firstObject];
        [firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(contentView);
            make.top.equalTo(spaceView.mas_bottom);
            make.right.equalTo(centerView.mas_left);
        }];
        UIButton *lastButton = [buttonArray lastObject];
        [lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView.mas_right);
            make.top.equalTo(spaceView.mas_bottom);
            make.bottom.right.equalTo(contentView);
        }];
    }
}

- (void)didClickButton:(UIButton *)button {
    if(self.isFirstDismissViewController == YES){
        int index = (int)button.tag;
        self.view.userInteractionEnabled = NO;
        ESCAlertAction *action = [self.actionArray objectAtIndex:index];
        [self dismissViewControllerAnimated:YES completion:^{
            action.handler(action);
        }];
    }else {
        int index = (int)button.tag;
        self.view.userInteractionEnabled = NO;
        ESCAlertAction *action = [self.actionArray objectAtIndex:index];
        action.handler(action);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

- (NSMutableArray *)actionArray {
    if (_actionArray == nil) {
        _actionArray = [NSMutableArray array];
    }
    return _actionArray;
}


@end

