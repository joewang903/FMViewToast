//
//  HYViewToastOrientation.h
//
//
//  Created By Administrator.Fyxrhyry on 2013-10-13.
//  Copyright (c) 2013年 FM®. All rights reserved.
//

#ifndef HYUI_HYViewToast_h
#define HYUI_HYViewToast_h

#import <UIKit/UIKit.h>

//自动消失信息框。
/**
 * @brief    自动消失信息框。
 */
@interface FMViewToast : UIView

+ (void)setImageBackground:(UIImage *)imageBackground;                    //默认: nil
+ (void)setImageViewContentMode:(UIViewContentMode)imageViewContentMode;  //默认: UIViewContentModeScaleToFill
+ (void)setColorBackground:(UIColor *)colorBackground;                    //默认: [UIColor blackColor]
+ (void)setColorMessage:(UIColor *)colorMessage;                          //默认: [UIColor whiteColor]
+ (void)setFontMessage:(UIFont *)fontMessage;                             //默认: [UIFont systemFontOfSize:17.0f]
+ (void)setTextAlignmentMessage:(NSTextAlignment)textAlignmentMessage;    //默认: NSTextAlignmentCenter
+ (void)setNumberOfLines:(NSInteger)numberOfLines;                        //默认: 10
+ (void)setAnimateDuration:(NSTimeInterval)animateDuration;               //默认: 0.2
+ (void)setDelayDismiss:(NSTimeInterval)delayDismiss;                     //默认: 2.0
+ (void)setAlphaBackground:(CGFloat)alphaBackground;                      //默认: 0.7f
+ (void)setCornerRadius:(CGFloat)cornerRadius;                            //默认: 4.0f
+ (void)setShowTop:(CGFloat)showTop;                                      //默认: 0.0f
+ (void)setShowBottom:(CGFloat)showBottom;                                //默认: 0.0f
+ (void)setShowCenter:(CGFloat)showCenter;                                //默认: 0.0f
+ (void)setTouchToDismiss:(BOOL)touchToDismiss;                           //默认: YES

+ (void)showMessage:(NSString *)message;
+ (void)showMessageModal:(NSString *)message;

@end

#endif









