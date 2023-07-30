//
//  MainMenuView.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MainMenuView.h"
#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "AudioQueueObject.h"
#import "AudioPlayer.h"
#import <AudioToolbox/AudioServices.h>


@implementation MainMenuView

@synthesize viewController;
@synthesize backgroundLoop;

- (id)initWithFrame:(CGRect)frame viewController:(MenuController *)aController {
    self = [super initWithFrame:frame];
	if (self != nil) {
        self.viewController = aController;		
		
		self.backgroundColor = [UIColor clearColor];
		
		title = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"speedZoneTitle.png"]];
		title.center = CGPointMake(275,240);
		[self addSubview:title ];
		
		practiceBtnImage = [UIImage imageNamed:@"practiceButton.png"];
		CGRect practiceBtnFrame = CGRectMake(30,120,50,240);
		practiceBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(practiceBtnDown) selectorUp:@selector(toPracticeMenu) frame:practiceBtnFrame  imageNormal:practiceBtnImage];
		[self addSubview:practiceBtn];
		
		playBtnImage = [UIImage imageNamed:@"playButton.png"];
		CGRect playBtnFrame = CGRectMake(130,120,50,240);
		playBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(playBtnDown) selectorUp:@selector(toPlayMenu) frame:playBtnFrame  imageNormal:playBtnImage];
		[self addSubview:playBtn];
		
		buttonSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buttonSelected.png"]];
		buttonSelected.alpha = 0;
		[self addSubview:buttonSelected];
		
		backgroundLoop = [[AudioPlayer alloc] initWithName:@"Intro"];
		
		menuBtn = [[AudioPlayer alloc] initShortFXWithName:@"menu"];
		
    }
    return self;
}

- (void)dealloc {
	[title release];
	[practiceBtnImage release];
	[practiceBtn release];
    [playBtnImage  release];
	[playBtn  release];
    [super dealloc];
}

- (void)initAnimation {
		
	[backgroundLoop setAudioVolume:0.0];
	[backgroundLoop playFadeInIsLooping:YES Delay:0.0 Duration:1.0 ToVolume:0.5];

	practiceBtn.alpha = 0;
	playBtn.alpha = 0;
	title.center = CGPointMake(400,240);
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.9];
	practiceBtn.alpha = 1;
	playBtn.alpha = 1;
	title.center = CGPointMake(250,240);
	[UIView commitAnimations];
	
	[self startTitleScaleAnimation];
		
}

- (void) toPracticeMenu{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	buttonSelected.alpha = 0;
	[UIView commitAnimations];
	
	[self stopTitleScaleAnimation];
	
	[viewController moveToLeftView:@"PracticeMenuView"];
}
- (void) toPlayMenu{
		
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	buttonSelected.alpha = 0;
	[UIView commitAnimations];

	[self stopTitleScaleAnimation];
	[viewController moveToLeftView:@"PlayMenuView"];
}

- (void)titleScaleAnimation {
	CABasicAnimation *scaleXAnimation = [CABasicAnimation animation];
    scaleXAnimation.keyPath = @"transform.scale.x";
    scaleXAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleXAnimation.toValue = [NSNumber numberWithFloat:0.9];
    scaleXAnimation.duration = 0.5;
    scaleXAnimation.repeatCount = 0;
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleXAnimation.autoreverses = YES;
    [title.layer addAnimation:scaleXAnimation forKey:@"scale.x"];
	CABasicAnimation *scaleYAnimation = [CABasicAnimation animation];
    scaleYAnimation.keyPath = @"transform.scale.y";
    scaleYAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleYAnimation.toValue = [NSNumber numberWithFloat:0.9];
    scaleYAnimation.duration = 0.5;
    scaleYAnimation.repeatCount = 0;
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleYAnimation.autoreverses = YES;
    [title.layer addAnimation:scaleYAnimation forKey:@"scale.y"];
}

- (void) startTitleScaleAnimation {

	titleScaleTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(titleScaleAnimation) userInfo: nil repeats:YES];
}

- (void) stopTitleScaleAnimation {
	[titleScaleTimer invalidate];
}
- (void) practiceBtnDown {
	
	[menuBtn playShortFX];
	
	buttonSelected.alpha = 1;
	buttonSelected.center = CGPointMake(53,242);
}
- (void) playBtnDown {
	
	[menuBtn playShortFX];
	
	buttonSelected.alpha = 1;
	buttonSelected.center = CGPointMake(153,242);
}

@end
