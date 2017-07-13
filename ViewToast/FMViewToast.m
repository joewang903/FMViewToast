//
//  HYViewToastOrientation.m
//
//
//  Created By Administrator.Fyxrhyry on 2013-10-13.
//  Copyright (c) 2013年 FM®. All rights reserved.
//

#import "FMViewToast.h"

@interface FMViewToast ()
@property (nonatomic, strong) UIView * viewWindowMask;
@property (nonatomic, assign) CGFloat showTopDismiss;
@property (nonatomic, assign) CGFloat showBottomDismiss;
@property (nonatomic, assign) CGFloat showCenterDismiss;
@property (nonatomic, assign) BOOL finishedAnimate;
@property (nonatomic, strong) UIImage * imageBackground;
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;
@property (nonatomic, assign) UIColor * colorBackground;
@property (nonatomic, assign) UIColor * colorMessage;
@property (nonatomic, assign) UIFont * fontMessage;
@property (nonatomic, assign) NSTextAlignment textAlignmentMessage;
@property (nonatomic, assign) NSInteger numberOfLines;
@property (nonatomic, assign) NSTimeInterval animateDuration;
@property (nonatomic, assign) NSTimeInterval delayDismiss;
@property (nonatomic, assign) CGFloat alphaBackground;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat showTop;
@property (nonatomic, assign) CGFloat showBottom;
@property (nonatomic, assign) CGFloat showCenter;
@property (nonatomic, assign) BOOL touchToDismiss;
@end

@implementation FMViewToast

//======================================================================================================================================================================================================
//
#pragma mark -
#pragma mark Method

+ (void)dismiss
{
	FMViewToast * viewToast = [FMViewToast sharedInstance];
	if (viewToast.finishedAnimate == NO)
	{
		return;
	}
	viewToast.finishedAnimate = NO;
	if (viewToast.showTopDismiss != 0.0f || viewToast.showBottomDismiss != 0.0f)
	{
		CGRect rectToast = viewToast.frame;
		if (viewToast.showTopDismiss != 0.0f)
		{
			rectToast.origin.y = -viewToast.frame.size.height;
		}
		else
		{
			CGRect rectScreen = [[UIScreen mainScreen] bounds];
			rectToast.origin.y = rectScreen.size.height;
		}
		[UIView animateWithDuration:viewToast.animateDuration animations:^(void){
			CGRect rectAnimate = rectToast;
			viewToast.frame = rectAnimate;
			viewToast.alpha = 0.0f;
		}completion:^(BOOL finished){
			for (UIView * viewSub in viewToast.subviews)
			{
				[viewSub removeFromSuperview];
			}
			[viewToast.viewWindowMask removeFromSuperview];
			[viewToast removeFromSuperview];
		}];
	}
	else
	{
		[UIView animateWithDuration:viewToast.animateDuration animations:^(void){
			viewToast.alpha = 0.0f;
			viewToast.transform = CGAffineTransformMakeScale(0.3f, 0.3f);
		}completion:^(BOOL finished){
			for (UIView * viewSub in viewToast.subviews)
			{
				[viewSub removeFromSuperview];
			}
			viewToast.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
			[viewToast.viewWindowMask removeFromSuperview];
			[viewToast removeFromSuperview];
		}];
	}
}

//======================================================================================================================================================================================================
//
#pragma mark -
#pragma mark Callback

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	FMViewToast * viewToast = [FMViewToast sharedInstance];
	if (viewToast.touchToDismiss && viewToast.finishedAnimate)
	{
		[self.class cancelPreviousPerformRequestsWithTarget:self];
		[self.class dismiss];
	}
	[viewToast.nextResponder touchesEnded:touches withEvent:event];
}

//======================================================================================================================================================================================================
//
#pragma mark -
#pragma mark Setter

+ (void)setImageBackground:(UIImage *)imageBackground
{
	if ([FMViewToast sharedInstance].imageBackground == imageBackground)
	{
		return;
	}
	[FMViewToast sharedInstance].imageBackground = imageBackground;
}

+ (void)setImageViewContentMode:(UIViewContentMode)imageViewContentMode
{
	[FMViewToast sharedInstance].imageViewContentMode = imageViewContentMode;
}

+ (void)setColorBackground:(UIColor *)colorBackground
{
	if ([FMViewToast sharedInstance].colorBackground == colorBackground)
	{
		return;
	}
	[FMViewToast sharedInstance].colorBackground = colorBackground;
}

+ (void)setColorMessage:(UIColor *)colorMessage
{
	if ([FMViewToast sharedInstance].colorMessage == colorMessage)
	{
		return;
	}
	[FMViewToast sharedInstance].colorMessage = colorMessage;
}

+ (void)setFontMessage:(UIFont *)fontMessage
{
	if ([FMViewToast sharedInstance].fontMessage == fontMessage)
	{
		return;
	}
	[FMViewToast sharedInstance].fontMessage = fontMessage;
}

+ (void)setTextAlignmentMessage:(NSTextAlignment)textAlignmentMessage
{
	[FMViewToast sharedInstance].textAlignmentMessage = textAlignmentMessage;
}

+ (void)setNumberOfLines:(NSInteger)numberOfLines
{
	[FMViewToast sharedInstance].numberOfLines = numberOfLines <= 10 ? numberOfLines : 10;
}

+ (void)setAnimateDuration:(NSTimeInterval)animateDuration
{
	[FMViewToast sharedInstance].animateDuration = MIN(MAX(animateDuration, 0.0), 3.0);
}

+ (void)setDelayDismiss:(NSTimeInterval)delayDismiss
{
	[FMViewToast sharedInstance].delayDismiss = delayDismiss <= 10.0 ? delayDismiss : 10.0;
}

+ (void)setAlphaBackground:(CGFloat)alphaBackground
{
	[FMViewToast sharedInstance].alphaBackground = alphaBackground;
}

+ (void)setCornerRadius:(CGFloat)cornerRadius
{
	[FMViewToast sharedInstance].cornerRadius = cornerRadius;
}

+ (void)setShowTop:(CGFloat)showTop
{
	[FMViewToast sharedInstance].showTop = [FMViewToast sharedInstance].showBottom = [FMViewToast sharedInstance].showCenter = 0.0f;
	[FMViewToast sharedInstance].showTop = showTop;
}

+ (void)setShowBottom:(CGFloat)showBottom
{
	[FMViewToast sharedInstance].showTop = [FMViewToast sharedInstance].showBottom = [FMViewToast sharedInstance].showCenter = 0.0f;
	[FMViewToast sharedInstance].showBottom = showBottom;
}

+ (void)setShowCenter:(CGFloat)showCenter
{
	[FMViewToast sharedInstance].showTop = [FMViewToast sharedInstance].showBottom = [FMViewToast sharedInstance].showCenter = 0.0f;
	[FMViewToast sharedInstance].showCenter = showCenter;
}

+ (void)setTouchToDismiss:(BOOL)touchToDismiss
{
	[FMViewToast sharedInstance].touchToDismiss = touchToDismiss;
}

//======================================================================================================================================================================================================
//
#pragma mark -
#pragma mark System

+ (FMViewToast *)sharedInstance
{
	static FMViewToast * viewToast = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		CGRect rect = [[UIScreen mainScreen] bounds];
		rect.size.width -= 40.0f;
		rect.size.height -= 40.0f;
		viewToast = [[self alloc] initWithFrame:rect];
	});
	return viewToast;
}

+ (void)showMessage:(NSString *)message
{
	if (message.length == 0)
	{
		return;
	}
	FMViewToast * viewToast = [FMViewToast sharedInstance];
	if (viewToast == nil)
	{
		return;
	}
	CGRect rectScreen = [[UIScreen mainScreen] bounds];
	CGRect rectToast = rectScreen;
	rectToast.size.width -= 40.0f;
	rectToast.size.height -= 40.0f;
	for (UIView * viewSub in viewToast.subviews)
	{
		[viewSub removeFromSuperview];
	}
	[viewToast removeFromSuperview];
	[self.class cancelPreviousPerformRequestsWithTarget:self];
	
	CGRect rectLabel = rectToast;
	rectLabel.size.width -= 20.0f;
	rectLabel.size.height -= 20.0f;
	UILabel * label = [[UILabel alloc] initWithFrame:rectLabel];
	label.textAlignment = viewToast.textAlignmentMessage;
	label.backgroundColor = [UIColor clearColor];
	label.textColor = viewToast.colorMessage;
	label.font = viewToast.fontMessage;
	label.numberOfLines = viewToast.numberOfLines;
	label.text = message;
	rectLabel = [label textRectForBounds:rectLabel limitedToNumberOfLines:viewToast.numberOfLines];
	label.frame = rectLabel;
	
	rectToast.size.width = rectLabel.size.width + 20.0f;
	rectToast.size.height = rectLabel.size.height + 20.0f;
	rectToast.origin.x = (rectScreen.size.width - rectToast.size.width) / 2.0f;
	rectToast.origin.y = (rectScreen.size.height - rectToast.size.height) / 2.0f;
	viewToast.frame = rectToast;
	
	if (viewToast.imageBackground == nil)
	{
		UIView * viewMask = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, rectToast.size.width, rectToast.size.height)];
		viewMask.backgroundColor = viewToast.colorBackground;
		viewMask.alpha = viewToast.alphaBackground;
		viewMask.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[viewToast addSubview:viewMask];
	}
	else
	{
		UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, rectToast.size.width, rectToast.size.height)];
		imageView.contentMode = viewToast.imageViewContentMode;
		imageView.image = viewToast.imageBackground;
		imageView.alpha = viewToast.alphaBackground;
		imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[viewToast addSubview:imageView];
	}
	rectLabel.origin.x = (rectToast.size.width - rectLabel.size.width) / 2.0f;
	rectLabel.origin.y = (rectToast.size.height - rectLabel.size.height) / 2.0f;
	label.frame = rectLabel;
	[viewToast addSubview:label];
	
	viewToast.backgroundColor = [UIColor clearColor];
	viewToast.layer.cornerRadius = viewToast.cornerRadius;
	viewToast.layer.masksToBounds = YES;
	
	UIWindow * window = [[UIApplication sharedApplication] keyWindow];
	[window addSubview:viewToast];
	
	if (viewToast.showTop != 0.0f || viewToast.showBottom != 0.0f)
	{
		CGFloat top = 0.0f;
		CGFloat topOffset = 0.0f;
		if (viewToast.showTop != 0.0f)
		{
			top = viewToast.showTop;
			top = MAX(20.0f, top);
			top = MIN(rectScreen.size.height - viewToast.frame.size.height, top);
			top = MAX(20.0f, top);
			topOffset = top + 20.0f;
			rectToast.origin.y = -rectToast.size.height;
		}
		else
		{
			top = rectScreen.size.height - viewToast.frame.size.height - viewToast.showBottom;
			top = MAX(20.0f, top);
			top = MIN(rectScreen.size.height - viewToast.frame.size.height, top);
			top = MAX(20.0f, top);
			topOffset = top - 20.0f;
			rectToast.origin.y = rectScreen.size.height;
		}
		viewToast.finishedAnimate = NO;
		viewToast.frame = rectToast;
		viewToast.alpha = 0.0f;
		viewToast.showTopDismiss = viewToast.showTop;
		viewToast.showBottomDismiss = viewToast.showBottom;
		viewToast.showCenterDismiss = viewToast.showCenter;
		viewToast.showTop = viewToast.showBottom = viewToast.showCenter = 0.0f;
		[UIView animateWithDuration:viewToast.animateDuration animations:^(void){
			CGRect rectAnimate = rectToast;
			rectAnimate.origin.y = topOffset;
			viewToast.frame = rectAnimate;
			viewToast.alpha = 1.0f;
		}completion:^(BOOL finished){
			CGRect rectAnimate = rectToast;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.05];
			rectAnimate.origin.y = top;
			viewToast.frame = rectAnimate;
			[UIView commitAnimations];
			viewToast.finishedAnimate = YES;
			[self performSelector:@selector(dismiss) withObject:nil afterDelay:viewToast.delayDismiss];
		}];
	}
	else
	{
		viewToast.center = window.center;
		if (viewToast.showCenter != 0.0f)
		{
			CGFloat top = viewToast.showCenter;
			top = MAX(20.0f, top);
			top = MIN(rectScreen.size.height - viewToast.frame.size.height, top);
			top = MAX(20.0f, top);
			rectToast.origin.y = top;
			viewToast.frame = rectToast;
		}
		viewToast.finishedAnimate = NO;
		viewToast.alpha = 0.0f;
		viewToast.transform = CGAffineTransformMakeScale(0.3f, 0.3f);
		viewToast.showTopDismiss = viewToast.showTop;
		viewToast.showBottomDismiss = viewToast.showBottom;
		viewToast.showCenterDismiss = viewToast.showCenter;
		viewToast.showTop = viewToast.showBottom = viewToast.showCenter = 0.0f;
		[UIView animateWithDuration:viewToast.animateDuration animations:^(void){
			viewToast.alpha = 1.0f;
			viewToast.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
		}completion:^(BOOL finished){
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.05];
			viewToast.alpha = 1.0f;
			viewToast.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
			[UIView commitAnimations];
			viewToast.finishedAnimate = YES;
			[self performSelector:@selector(dismiss) withObject:nil afterDelay:viewToast.delayDismiss];
		}];
	}
}

+ (void)showMessageModal:(NSString *)message
{
	CGRect rectScreen = [[UIScreen mainScreen] bounds];
	if ([FMViewToast sharedInstance] == nil)
	{
		return;
	}
	[FMViewToast sharedInstance].viewWindowMask = [[UIView alloc] initWithFrame:rectScreen];
	[FMViewToast sharedInstance].viewWindowMask.backgroundColor = [UIColor clearColor];
	UIWindow * window = [[UIApplication sharedApplication] keyWindow];
	[window addSubview:[FMViewToast sharedInstance].viewWindowMask];
	[self showMessage:message];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
		self.imageBackground = nil;
		self.imageViewContentMode = UIViewContentModeScaleToFill;
		self.colorBackground = [UIColor blackColor];
		self.colorMessage = [UIColor whiteColor];
		self.fontMessage = [UIFont systemFontOfSize:17.0f];
		self.textAlignmentMessage = NSTextAlignmentCenter;
		self.numberOfLines = 10;
		self.animateDuration = 0.2;
		self.delayDismiss = 2.0;
		self.alphaBackground = 0.7f;
		self.cornerRadius = 4.0f;
		self.showTop = 0.0f;
		self.showBottom = 0.0f;
		self.showCenter = 0.0f;
		self.touchToDismiss = YES;
    }
    return self;
}

@end









