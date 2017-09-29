

//
//  SHPlaceHodlerTextView.m
//  随便一个名字
//
//  Created by shihao on 2017/9/29.
//  Copyright © 2017年 shihao. All rights reserved.
//

#import "SHPlaceHodlerTextView.h"

@implementation SHPlaceHodlerTextView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    
    self.font = [UIFont systemFontOfSize:15];
    self.placeHolder = @"请输入内容";
    self.placeHolderColor = [UIColor grayColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - Notification
- (void)textDidChange:(NSNotification *)note{
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
}

#pragma mark - Layout
- (void)layoutSubviews{
    [super layoutSubviews];
    //[self layoutIfNeeded];
}

#pragma mark - DrawRect
- (void)drawRect:(CGRect)rect{

    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;

    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeHolderColor;

    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeHolder drawInRect:rect withAttributes:attrs];
}

#pragma mark - setter
- (void)setPlaceHolder:(NSString *)placeHolder{

    _placeHolder = placeHolder;

    [self setNeedsDisplay];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;

    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];

    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text{
    [super setText:text];

    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];

    [self setNeedsDisplay];
}
#pragma mark - dealloc

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
