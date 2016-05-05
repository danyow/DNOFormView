//
//  DNOFormView.m
//  表格
//
//  Created by Danyow.Ed on 16/5/3.
//  Copyright © 2016年 Danyow.Ed. All rights reserved.
//

#import "DNOFormView.h"

NSString * const kWeek = @"week";
NSString * const kDate = @"date";
NSString * const kTime = @"time";

#define myWidth  [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  (myWidth / 8)
#define kHeight (kWidth + 8)
#define kMargin 4

@interface DNOFormView ()

@property (nonatomic, strong) NSIndexPath *selectedIndex;

@end

@implementation DNOFormView


- (void)awakeFromNib
{
    [self prepareUI];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    [self prepareUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    self.row    = 4;
    self.column = 8;
    self.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick:)];
    [self addGestureRecognizer:tap];
}

- (void)didClick:(UITapGestureRecognizer *)tap
{
    CGPoint clickPoint = [tap locationInView:self];
    
    NSInteger row    = clickPoint.x / kWidth;
    NSInteger column = clickPoint.y / kHeight;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:column];
    
    if (row == 0 || column == 0) {
        return;
    }
    if ([self.selectedIndex isEqual:indexPath]) {
        self.selectedIndex = nil;
        return;
    }
    self.selectedIndex = indexPath;
    
    /** 调用block */
    if (self.clickBlock) {
        __block BOOL canRegister = NO;
        [self.canRegisters enumerateObjectsUsingBlock:^(NSIndexPath *index, NSUInteger idx, BOOL *stop) {
            if ([index isEqual:indexPath]) {
                canRegister = YES;
                *stop = YES;
            }
        }];
        
        NSDictionary *info = @{kWeek : [self firstRowText][indexPath.row - 1],
                               kDate : [self firstRowDateText][indexPath.row - 1],
                               kTime : [self firstColumnText][indexPath.section - 1 ]};
        
        self.clickBlock(canRegister, info);
        
    }
    
    
}

- (void)drawRect:(CGRect)rect {
    
    /** 背景色 */
    UIBezierPath *backgroundColorPath = [UIBezierPath bezierPathWithRect:({
        CGRectMake(0, 0, rect.size.width, kHeight);
    })];
    [[UIColor colorWithWhite:0.9 alpha:0.5] set];
    [backgroundColorPath fill];
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 0.2;
    [[UIColor lightGrayColor] set];
    
    /** 横线 */
    [path moveToPoint:CGPointMake(0, 1)];
    for (int i = 0; i < _row + 1; ++i) {
        [path addLineToPoint:CGPointMake(rect.size.width, i == 0 ? 1 : i * kHeight)];
        [path stroke];
        [path moveToPoint:CGPointMake(0, (i + 1) * kHeight)];
    }
    
    /** 竖线 */
    [path moveToPoint:CGPointMake(1, 0)];
    for (int i = 0; i < _column + 1; ++i) {
        [path addLineToPoint:CGPointMake(i == 0 ? 1 : i * kWidth, rect.size.height)];
        [path stroke];
        [path moveToPoint:CGPointMake((i + 1) * kWidth, 0)];
    }
    
    /** 第一行文字 */
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    [[self firstRowText] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        
        [text drawAtPoint:CGPointMake((idx + 1) * kWidth + kMargin * 1.5, kMargin)
           withAttributes:attributes];
        
        [[self firstRowDateText][idx] drawAtPoint:({
            CGPointMake((idx + 1) * kWidth + kMargin * 2, kHeight * 0.5 + kMargin * 2);
        }) withAttributes:nil];
        
    }];
    
    /** 第一列文字 */
    [[self firstColumnText] enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL *stop) {
        [text drawAtPoint:CGPointMake(kMargin * 3, (idx + 1) * kHeight + kMargin * 5)
           withAttributes:nil];
    }];
    
    
    /** 高亮 */
    if (self.selectedIndex.row || self.selectedIndex.section) {
        CGRect rectFrame = CGRectMake(self.selectedIndex.row * kWidth, self.selectedIndex.section * kHeight, kWidth, kHeight);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:rectFrame];
        [[UIColor greenColor] set];
        [rectPath fill];
    }
    
    /** 有号 */
    [[self canRegisters] enumerateObjectsUsingBlock:^(NSIndexPath *index, NSUInteger idx, BOOL *stop) {
        [@"有号" drawAtPoint:CGPointMake(kMargin * 3 + index.row * kWidth, index.section * kHeight + kMargin * 5) withAttributes:nil];
    }];
}


- (void)setRow:(NSUInteger)row
{
    _row = row;
    [self setFrame:({
        CGRect frame      = self.frame;
        frame.size.height = row * kHeight;
        if (frame.size.height > myHeight) {
            frame.size.height = myHeight;
        }
        frame;
    })];
    [self setNeedsDisplay];
}

- (void)setColumn:(NSUInteger)column
{
    _column = column;
    [self setFrame:({
        CGRect frame     = self.frame;
        frame.size.width = column * kWidth;
        if (frame.size.width > myWidth) {
            frame.size.width = myWidth;
        }
        frame;
    })];
    [self setNeedsDisplay];
}

- (void)setSelectedIndex:(NSIndexPath *)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self setNeedsDisplay];
}

- (void)setCanRegisters:(NSArray<NSIndexPath *> *)canRegisters
{
    _canRegisters = canRegisters;
    [self setNeedsDisplay];
}

- (NSArray *)firstRowText
{
    return @[@"周四",
             @"周五",
             @"周六",
             @"周日",
             @"周一",
             @"周二",
             @"周三",];
}

- (NSArray *)firstRowDateText
{
    return @[@"05-05",
             @"05-06",
             @"05-07",
             @"05-08",
             @"05-09",
             @"05-10",
             @"05-11",];
}

- (NSArray *)firstColumnText
{
    return @[@"上午",
             @"下午",
             @"晚上"];
}

@end
