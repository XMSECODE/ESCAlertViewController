//
//  ViewController.m
//  ESCAlertController
//
//  Created by xiatian on 2023/6/8.
//

#import "ViewController.h"
#import "ESCAlertViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didClicAlert:(UIButton *)sender {
    
    ESCAlertViewController* alertViewController = [ESCAlertViewController alertControllerWithTitle:@"标题" message:@"提示内容"];
    
    ESCAlertAction *action1 = [ESCAlertAction actionWithTitle:@"确认" titleColor:[UIColor blueColor] handler:^(ESCAlertAction *action) {
        
    }];
    ESCAlertAction *action2 = [ESCAlertAction actionWithTitle:@"取消" titleColor:[UIColor grayColor] handler:^(ESCAlertAction *action) {
        
    }];
    [alertViewController addAction:action1];
    [alertViewController addAction:action2];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
    
}


@end
