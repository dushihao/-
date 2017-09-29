//
//  SHPlaceHodlerTextView.h
//  随便一个名字
//
//  Created by shihao on 2017/9/29.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPlaceHodlerTextView : UITextView

/// 占位文字 默认为：请输入内容
@property (nonatomic,copy) IBInspectable NSString *placeHolder;

/**
 站位文字颜色 默认为灰色
 */
@property (nonatomic) IBInspectable UIColor *placeHolderColor;

@end
