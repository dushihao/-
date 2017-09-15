
//
//  LayoutButton.m
//  cornerRadiusTest
//
//  Created by shihao on 2017/9/14.
//  Copyright © 2017年 shihao. All rights reserved.
/// 0.0

#import "LayoutButton.h"
#import "QMUICommonDefines.h"

CGFloat padding = 3;

@interface LayoutButton()


@end

@implementation LayoutButton

- (void)setImagePosition:(QMUIButtonImagePosition)imagePosition{
    _imagePosition = imagePosition;
    
    [self setNeedsLayout];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }
    
    BOOL isImageViewShowing = self.imageView && !self.imageView.hidden;
    BOOL isTitleLabelShowing = self.titleLabel && !self.titleLabel.hidden;
    CGSize imageLimitSize = CGSizeZero;
    CGSize titleLimitSize = CGSizeZero;
    CGSize imageTotalSize = CGSizeZero;// 包含 imageEdgeInsets 那些空间
    CGSize titleTotalSize = CGSizeZero;// 包含 titleEdgeInsets 那些空间
    CGFloat spacingBetweenImageAndTitle = isImageViewShowing && isTitleLabelShowing ? self.spacingBetweenImageAndTitle : 0;// 如果图片或文字某一者没显示，则这个 spacing 不考虑进布局
    CGRect imageFrame = CGRectZero;
    CGRect titleFrame = CGRectZero;
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets), CGRectGetHeight(self.bounds) - UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets));
    
    // 图片的布局原则都是尽量完整展示，所以不管 imagePosition 的值是什么，这个计算过程都是相同的
    if (isImageViewShowing) {
        imageLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets));
        CGSize imageSize = [self.imageView sizeThatFits:imageLimitSize];
        imageSize.width = fmin(imageLimitSize.width, imageSize.width);
        imageSize.height = fmin(imageLimitSize.height, imageSize.height);
        imageFrame = CGRectMakeWithSize(imageSize);
        imageTotalSize = CGSizeMake(imageSize.width + UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), imageSize.height + UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets));
    }
    
    if (self.imagePosition == QMUIButtonImagePositionTop || self.imagePosition == QMUIButtonImagePositionBottom) {
        
        if (isTitleLabelShowing) {
            titleLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), contentSize.height - imageTotalSize.height - spacingBetweenImageAndTitle - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
            CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
            titleSize.width = fmin(titleLimitSize.width, titleSize.width);
            titleSize.height = fmin(titleLimitSize.height, titleSize.height);
            titleFrame = CGRectMakeWithSize(titleSize);
            titleTotalSize = CGSizeMake(titleSize.width + UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), titleSize.height + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
        }
        
        switch (self.contentHorizontalAlignment) {
            case UIControlContentHorizontalAlignmentLeft:
                imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left) : imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left) : titleFrame;
                break;
            case UIControlContentHorizontalAlignmentCenter:
                imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left + CGFloatGetCenter(imageLimitSize.width, CGRectGetWidth(imageFrame))) : imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left + CGFloatGetCenter(titleLimitSize.width, CGRectGetWidth(titleFrame))) : titleFrame;
                break;
            case UIControlContentHorizontalAlignmentRight:
                imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - CGRectGetWidth(imageFrame)) : imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.titleEdgeInsets.right - CGRectGetWidth(titleFrame)) : titleFrame;
                break;
            case UIControlContentHorizontalAlignmentFill:
                if (isImageViewShowing) {
                    imageFrame = CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left);
                    imageFrame = CGRectSetWidth(imageFrame, imageLimitSize.width);
                }
                if (isTitleLabelShowing) {
                    titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                    titleFrame = CGRectSetWidth(titleFrame, titleLimitSize.width);
                }
                break;
            default:
                break;
        }
        
        if (self.imagePosition == QMUIButtonImagePositionTop) {
            switch (self.contentVerticalAlignment) {
                case UIControlContentVerticalAlignmentTop:
                    imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top) : imageFrame;
                    titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, self.contentEdgeInsets.top + imageTotalSize.height + spacingBetweenImageAndTitle + self.titleEdgeInsets.top) : titleFrame;
                    break;
                case UIControlContentVerticalAlignmentCenter: {
                    CGFloat contentHeight = imageTotalSize.height + spacingBetweenImageAndTitle + titleTotalSize.height;
                    CGFloat minY = CGFloatGetCenter(contentSize.height, contentHeight) + self.contentEdgeInsets.top;
                    imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, minY + self.imageEdgeInsets.top) : imageFrame;
                    titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, minY + imageTotalSize.height + spacingBetweenImageAndTitle + self.titleEdgeInsets.top) : titleFrame;
                }
                    break;
                case UIControlContentVerticalAlignmentBottom:
                    titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - CGRectGetHeight(titleFrame)) : titleFrame;
                    imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - titleTotalSize.height - spacingBetweenImageAndTitle - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame)) : imageFrame;
                    break;
                case UIControlContentVerticalAlignmentFill: {
                    if (isImageViewShowing && isTitleLabelShowing) {
                        
                        // 同时显示图片和 label 的情况下，图片高度按本身大小显示，剩余空间留给 label
                        imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top) : imageFrame;
                        titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, self.contentEdgeInsets.top + imageTotalSize.height + spacingBetweenImageAndTitle + self.titleEdgeInsets.top) : titleFrame;
                        titleFrame = isTitleLabelShowing ? CGRectSetHeight(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - CGRectGetMinY(titleFrame)) : titleFrame;
                        
                    } else if (isImageViewShowing) {
                        imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                        imageFrame = CGRectSetHeight(imageFrame, contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets));
                    } else {
                        titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                        titleFrame = CGRectSetHeight(titleFrame, contentSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
                    }
                }
                    break;
            }
        } else { // bottom
            switch (self.contentVerticalAlignment) {
                case UIControlContentVerticalAlignmentTop:
                    titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top) : titleFrame;
                    imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, self.contentEdgeInsets.top + titleTotalSize.height + spacingBetweenImageAndTitle + self.imageEdgeInsets.top) : imageFrame;
                    break;
                case UIControlContentVerticalAlignmentCenter: {
                    CGFloat contentHeight = imageTotalSize.height + titleTotalSize.height + spacingBetweenImageAndTitle;
                    CGFloat minY = CGFloatGetCenter(contentSize.height, contentHeight) + self.contentEdgeInsets.top;
                    titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, minY + self.titleEdgeInsets.top) : titleFrame;
                    imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, minY + titleTotalSize.height + spacingBetweenImageAndTitle + self.imageEdgeInsets.top) : imageFrame;
                }
                    break;
                case UIControlContentVerticalAlignmentBottom:
                    imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame)) : imageFrame;
                    titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - imageTotalSize.height - spacingBetweenImageAndTitle - self.titleEdgeInsets.bottom - CGRectGetHeight(titleFrame)) : titleFrame;
                    break;
                case UIControlContentVerticalAlignmentFill: {
                    if (isImageViewShowing && isTitleLabelShowing) {
                        
                        // 同时显示图片和 label 的情况下，图片高度按本身大小显示，剩余空间留给 label
                        imageFrame = CGRectSetY(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame));
                        titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                        titleFrame = CGRectSetHeight(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - imageTotalSize.height - spacingBetweenImageAndTitle - self.titleEdgeInsets.bottom - CGRectGetMinY(titleFrame));
                        
                    } else if (isImageViewShowing) {
                        imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                        imageFrame = CGRectSetHeight(imageFrame, contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets));
                    } else {
                        titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                        titleFrame = CGRectSetHeight(titleFrame, contentSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
                    }
                }
                    break;
            }
        }
        
        self.imageView.frame = CGRectFlatted(imageFrame);
        self.titleLabel.frame = CGRectFlatted(titleFrame);
        
    } else if (self.imagePosition == QMUIButtonImagePositionLeft || self.imagePosition == QMUIButtonImagePositionRight) {
        
        if (isTitleLabelShowing) {
            titleLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) - imageTotalSize.width - spacingBetweenImageAndTitle, contentSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
            CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
            titleSize.width = fmin(titleLimitSize.width, titleSize.width);
            titleSize.height = fmin(titleLimitSize.height, titleSize.height);
            titleFrame = CGRectMakeWithSize(titleSize);
            titleTotalSize = CGSizeMake(titleSize.width + UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), titleSize.height + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
        }
        
        switch (self.contentVerticalAlignment) {
            case UIControlContentVerticalAlignmentTop:
                imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top) : imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top) : titleFrame;
                
                break;
            case UIControlContentVerticalAlignmentCenter:
                imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, self.contentEdgeInsets.top + CGFloatGetCenter(contentSize.height, CGRectGetHeight(imageFrame)) + self.imageEdgeInsets.top) : imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, self.contentEdgeInsets.top + CGFloatGetCenter(contentSize.height, CGRectGetHeight(titleFrame)) + self.titleEdgeInsets.top) : titleFrame;
                break;
            case UIControlContentVerticalAlignmentBottom:
                imageFrame = isImageViewShowing ? CGRectSetY(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame)) : imageFrame;
                titleFrame = isTitleLabelShowing ? CGRectSetY(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - CGRectGetHeight(titleFrame)) : titleFrame;
                break;
            case UIControlContentVerticalAlignmentFill:
                if (isImageViewShowing) {
                    imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                    imageFrame = CGRectSetHeight(imageFrame, contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets));
                }
                if (isTitleLabelShowing) {
                    titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                    titleFrame = CGRectSetHeight(titleFrame, contentSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
                }
                break;
        }
        
        if (self.imagePosition == QMUIButtonImagePositionLeft) {
            switch (self.contentHorizontalAlignment) {
                case UIControlContentHorizontalAlignmentLeft:
                    imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left) : imageFrame;
                    titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, self.contentEdgeInsets.left + imageTotalSize.width + spacingBetweenImageAndTitle + self.titleEdgeInsets.left) : titleFrame;
                    break;
                case UIControlContentHorizontalAlignmentCenter: {
                    CGFloat contentWidth = imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width;
                    CGFloat minX = self.contentEdgeInsets.left + CGFloatGetCenter(contentSize.width, contentWidth);
                    imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, minX + self.imageEdgeInsets.left) : imageFrame;
                    titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, minX + imageTotalSize.width + spacingBetweenImageAndTitle + self.titleEdgeInsets.left) : titleFrame;
                }
                    break;
                case UIControlContentHorizontalAlignmentRight: {
                    if (imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width > contentSize.width) {
                        // 图片和文字总宽超过按钮宽度，则优先完整显示图片
                        imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left) : imageFrame;
                        titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, self.contentEdgeInsets.left + imageTotalSize.width + spacingBetweenImageAndTitle + self.titleEdgeInsets.left) : titleFrame;
                    } else {
                        // 内容不超过按钮宽度，则靠右布局即可
                        titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.titleEdgeInsets.right - CGRectGetWidth(titleFrame)) : titleFrame;
                        imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - titleTotalSize.width - spacingBetweenImageAndTitle - imageTotalSize.width + self.imageEdgeInsets.left) : imageFrame;
                    }
                }
                    break;
                case UIControlContentHorizontalAlignmentFill: {
                    if (isImageViewShowing && isTitleLabelShowing) {
                        // 同时显示图片和 label 的情况下，图片按本身宽度显示，剩余空间留给 label
                        imageFrame = CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left);
                        titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + imageTotalSize.width + spacingBetweenImageAndTitle + self.titleEdgeInsets.left);
                        titleFrame = CGRectSetWidth(titleFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.titleEdgeInsets.right - CGRectGetMinX(titleFrame));
                    } else if (isImageViewShowing) {
                        imageFrame = CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left);
                        imageFrame = CGRectSetWidth(imageFrame, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets));
                    } else {
                        titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                        titleFrame = CGRectSetWidth(titleFrame, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets));
                    }
                }
                    break;
                default:
                    break;
            }
        } else {
            switch (self.contentHorizontalAlignment) {
                case UIControlContentHorizontalAlignmentLeft: {
                    if (imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width > contentSize.width) {
                        // 图片和文字总宽超过按钮宽度，则优先完整显示图片
                        imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - CGRectGetWidth(imageFrame)) : imageFrame;
                        titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - imageTotalSize.width - spacingBetweenImageAndTitle - titleTotalSize.width + self.titleEdgeInsets.left) : titleFrame;
                    } else {
                        // 内容不超过按钮宽度，则靠左布局即可
                        titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left) : titleFrame;
                        imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, self.contentEdgeInsets.left + titleTotalSize.width + spacingBetweenImageAndTitle + self.imageEdgeInsets.left) : imageFrame;
                    }
                }
                    break;
                case UIControlContentHorizontalAlignmentCenter: {
                    CGFloat contentWidth = imageTotalSize.width + spacingBetweenImageAndTitle + titleTotalSize.width;
                    CGFloat minX = self.contentEdgeInsets.left + CGFloatGetCenter(contentSize.width, contentWidth);
                    titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, minX + self.titleEdgeInsets.left) : titleFrame;
                    imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, minX + titleTotalSize.width + spacingBetweenImageAndTitle + self.imageEdgeInsets.left) : imageFrame;
                }
                    break;
                case UIControlContentHorizontalAlignmentRight:
                    imageFrame = isImageViewShowing ? CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - CGRectGetWidth(imageFrame)) : imageFrame;
                    titleFrame = isTitleLabelShowing ? CGRectSetX(titleFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - imageTotalSize.width - spacingBetweenImageAndTitle - self.titleEdgeInsets.right - CGRectGetWidth(titleFrame)) : titleFrame;
                    break;
                case UIControlContentHorizontalAlignmentFill: {
                    if (isImageViewShowing && isTitleLabelShowing) {
                        // 图片按自身大小显示，剩余空间由标题占满
                        imageFrame = CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - CGRectGetWidth(imageFrame));
                        titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                        titleFrame = CGRectSetWidth(titleFrame, CGRectGetMinX(imageFrame) - self.imageEdgeInsets.left - self.spacingBetweenImageAndTitle - self.titleEdgeInsets.right - CGRectGetMinX(titleFrame));
                        
                    } else if (isImageViewShowing) {
                        imageFrame = CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left);
                        imageFrame = CGRectSetWidth(imageFrame, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets));
                    } else {
                        titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                        titleFrame = CGRectSetWidth(titleFrame, contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets));
                    }
                }
                    break;
                default:
                    break;
            }
        }
        
        self.imageView.frame = CGRectFlatted(imageFrame);
        self.titleLabel.frame = CGRectFlatted(titleFrame);
    }
}

@end
