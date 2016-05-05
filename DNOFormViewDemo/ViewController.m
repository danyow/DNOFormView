//
//  ViewController.m
//  表格
//
//  Created by Danyow.Ed on 16/5/5.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import "ViewController.h"
#import "DNOFormView.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DNOFormView *formView = [DNOFormView new];
    formView.center       = self.view.center;
    formView.canRegisters = @[[NSIndexPath indexPathForRow:1 inSection:1],
                              [NSIndexPath indexPathForRow:5 inSection:2],
                              [NSIndexPath indexPathForRow:3 inSection:3]];
    [formView setClickBlock:^(BOOL canRegister, NSDictionary *info) {
        
        NSLog(@"%@  %@--%@--%@", canRegister ? @"YES" : @"NO", info[kTime], info[kDate], info[kWeek]);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"点击了" message:canRegister ? @"有号" : @"空的" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        });
        
    }];
    
    [self.view addSubview:formView];
}

@end
