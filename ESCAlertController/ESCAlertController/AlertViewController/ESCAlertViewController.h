//
//  ESCAlertViewController.h
//  ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//

#import <UIKit/UIKit.h>
#import "ESCAlertAction.h"



@interface ESCAlertViewController : UIViewController

@property (nonatomic, assign)BOOL isFirstDismissViewController;

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

- (void)addAction:(ESCAlertAction *)action;

@end


