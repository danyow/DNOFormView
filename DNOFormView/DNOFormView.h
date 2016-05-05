//
//  DNOFormView.h
//  表格
//
//  Created by Danyow.Ed on 16/5/3.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const kWeek;
UIKIT_EXTERN NSString * const kDate;
UIKIT_EXTERN NSString * const kTime;

@interface DNOFormView : UIView

@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) NSUInteger column;

/** 有号数组 indexPath */
@property (nonatomic, strong) NSArray <NSIndexPath *>*canRegisters;

@property (nonatomic, copy  ) void (^clickBlock)(BOOL canRegister, NSDictionary *info);

@end
