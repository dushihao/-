//
//  LayoutButton.h
//  cornerRadiusTest
//
//  Created by shihao on 2017/9/14.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 控制图片在UIButton里的位置，默认为QMUIButtonImagePositionLeft
typedef NS_ENUM(NSUInteger, QMUIButtonImagePosition) {
    QMUIButtonImagePositionTop,             // imageView在titleLabel上面
    QMUIButtonImagePositionLeft,            // imageView在titleLabel左边
    QMUIButtonImagePositionBottom,          // imageView在titleLabel下面
    QMUIButtonImagePositionRight,           // imageView在titleLabel右边
};

@interface LayoutButton : UIButton

/**
 * 设置按钮里图标和文字之间的间隔，会自动响应 imagePosition 的变化而变化，默认为0。<br/>
 * 系统默认实现需要同时设置 titleEdgeInsets 和 imageEdgeInsets，同时还需考虑 contentEdgeInsets 的增加（否则不会影响布局，可能会让图标或文字溢出或挤压），使用该属性可以避免以上情况。<br/>
 * @warning 会与 imageEdgeInsets、 imageEdgeInsets、 contentEdgeInsets 共同作用。
 */
@property(nonatomic, assign) IBInspectable CGFloat spacingBetweenImageAndTitle;

@property (nonatomic,assign) IBInspectable QMUIButtonImagePosition imagePosition;

@end
