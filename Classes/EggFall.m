//
//  EggFall.m
//  jeu
//
//  Created by Jonathan Lafleur on 17/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EggFall.h"
#import "GameController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>



@implementation EggFall

@synthesize viewController;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
	self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		[self setBackgroundColor:[UIColor colorWithRed:(8.0/255.0) green:(141.0/255.0) blue:(2.0/255.0) alpha:1.0]];
		
		targetView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"target.png"]];
		
		eggView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"egg.png"]];
	}
    return self;
}

- (void)dealloc {
	[targetView release];
	[eggView release];
    [super dealloc];
}

- (void)updateFallWithX:(float)x Y:(float)y {
	
	xyValue[0]=x;
	xyValue[1]=y;
	
}


- (void)startGame
{
	scale = 0.2;
	
	targetView.center = CGPointMake((float)(arc4random()%220),(float)(arc4random()%400));
	//targetView.center = CGPointMake(160,480);
	[targetView setTransform:CGAffineTransformMakeScale(scale,scale)];
	
	eggView.alpha = 1;
	eggView.center = CGPointMake(self.center.x,self.center.y);
	[eggView setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:10])];
	
	[self addSubview:targetView];
    [self addSubview:eggView];	
	
	eggxyValue[0] = targetView.center.x;
	eggxyValue[1] = targetView.center.y;
	initEggxyValue[0] = targetView.center.x;
	initEggxyValue[1] = targetView.center.y;
	
	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
	fallTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector: @selector(startFall) userInfo: nil repeats:NO];
}

- (void)startAnimation
{
	if([viewController timerActive]){
		scale = scale+0.005;
		eggxyValue[0] = ((eggxyValue[0] - (xyValue[0]-[viewController initialX])*40)+((initEggxyValue[0]*3)/200));
		eggxyValue[1] = ((eggxyValue[1] + xyValue[1]*40)+((initEggxyValue[1]*3)/200));
		targetView.center = CGPointMake(eggxyValue[0],eggxyValue[1]);
		//[targetView setTransform:CGAffineTransformMakeScale(scale,scale)];
	}else{
		if(![viewController gameActive]){
			AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
			[aniTimer invalidate];
			float dX = eggView.center.x - targetView.center.x;
			float dY = eggView.center.y - targetView.center.y;
			float distance = sqrtf(dX * dX + dY * dY);
			if(distance < 115){
				[viewController displayWon];
			} else {
				[viewController displayFailed];
			}
		}
	}
}

- (void) startFall
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:4.0];
	[UIView setAnimationCurve:1];
	[targetView setTransform:CGAffineTransformMakeScale(2,2)];
	//targetView.center = CGPointMake(targetView.center.x * 3,targetView.center.y * 3);
	[UIView commitAnimations];
}

@end
