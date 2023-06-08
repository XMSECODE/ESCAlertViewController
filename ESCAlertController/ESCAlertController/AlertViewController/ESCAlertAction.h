//
//  ESCAlertAction.h
//  ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//

#import <UIKit/UIKit.h>



@interface ESCAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title titleColor:(UIColor *)titleColor handler:(void (^)(ESCAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;

@property (nonatomic, readonly) UIColor *titleColor;

@property(nonatomic,copy,readonly)void((^handler)(ESCAlertAction *action));

@end


