//
//  ESCAlertAction.m
//  ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//

#import "ESCAlertAction.h"

@interface ESCAlertAction ()


@property(nonatomic,copy,readwrite)NSString* title;

@property(nonatomic,copy,readwrite)UIColor* titleColor;

@property(nonatomic,copy,readwrite)void((^handler)(ESCAlertAction *action));

@end


@implementation ESCAlertAction

+ (instancetype)actionWithTitle:( NSString *)title titleColor:(UIColor *)titleColor handler:(void (^ )(ESCAlertAction *action))handler {
    ESCAlertAction *action = [[ESCAlertAction alloc] init];
    action.title = title;
    action.titleColor = titleColor;
    [action setHandler:^(ESCAlertAction *action) {
        if (handler) {
            handler(action);
        }
    }];
    return action;;
}



@end
