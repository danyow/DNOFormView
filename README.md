# DNOFormView
自定义表格

####你需要几行几列 默认4行8列
```objc
@property (nonatomic, assign) NSUInteger row;    //default is 4
@property (nonatomic, assign) NSUInteger column; //default is 8
```


####有号的数组
```objc
/** 有号数组 indexPath */
@property (nonatomic, strong) NSArray <NSIndexPath *>*canRegisters;
```

####点击之后的回调
```objc
// canRegister: 是否有号
// info       : 星期几 多少日 上下午？
@property (nonatomic, copy  ) void (^clickBlock)(BOOL canRegister, NSDictionary *info);
```

#### info字典
```objc
// 对应info里面的key
UIKIT_EXTERN NSString * const kWeek;
UIKIT_EXTERN NSString * const kDate;
UIKIT_EXTERN NSString * const kTime;
```
