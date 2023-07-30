//
//  Marathon.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 22/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Marathon.h"
#import "GameController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>



@implementation Marathon

@synthesize viewController;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
	self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		self.center = CGPointMake(150,250);
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marathonBackground.png"]];
		background.center = CGPointMake(280,240);
		
		track = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marathonTrack.png"]];
		track.center = CGPointMake(111,240);
		
		clouds = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marathonClouds.png"]];
		
		gate[0] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marathonGate.png"]];
		gate[1] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marathonGate.png"]];
		gate[2] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marathonGate.png"]];
		
		jumpAlert = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jumpAlert.png"]];
		jumpAlert.center = CGPointMake(160,230);
		jumpAlert.alpha = 0;
		
	}
    return self;
}

- (void)dealloc {
	[background release];
	[clouds release];
	[jumpAlert release];
	[gate[3] release];
	[track release];
    [super dealloc];
}

- (void)updateJumpWithX:(float)x Y:(float)y {
	
	xyValue[0]=x;
	if(jump){
		if((xyValue[0]-preJump) > jumpHeight){
			jumpHeight = xyValue[0]-preJump;
		}
	}else{
		preJump = xyValue[0];
		jumpHeight = 0;
	}
	
}


- (void)startGame
{
	cloudsY = 240;
	clouds.center = CGPointMake(270,cloudsY);
	
	iterator = 0;
	
	cleared = NO;
	
	jumpAlertAni = NO;
	
	for(e=0;e<3;e++){
		[self insertSubview:gate[e] belowSubview:track];
		gateReady[e] = NO;
		gateY[e] = 200;
		gateScale[e] = 0;
		gate[e].center = CGPointMake(gateY[e],235);
		[gate[e] setTransform:CGAffineTransformMakeScale(gateScale[e],gateScale[e])];
	}
	
	[self addSubview:background];
    [self addSubview:clouds];
	[self addSubview:track];
	[self addSubview:jumpAlert];
	
	[self startAnimationTimer];
	
	[self generateGate];
	
}

- (void)startAnimationTimer
{
	interval = (float)((arc4random()%10)+10)/10;
	
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
	addGateTimer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector: @selector(generateGate) userInfo: nil repeats:YES];
	runTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector: @selector(runAnimation) userInfo: nil repeats:YES];
}

- (void)startAnimation
{
	
	if([viewController timerActive]){	
		for(i=0;i<3;i++){
			if(gateScale[i] != 0){
				if(gateScale[i] < 4){
					if(gateScale[i] > 0.5){
						[self showJumpAlert];
						jump = YES;
						if(jumpHeight >= 0.1){
							cleared = YES;
						}else{
							cleared = NO;
						}
					}
					gateScale[i] = gateScale[i] + ((241-gateY[i])/5500);
					
					if(gateReady[i]){
						gateY[i] = gateY[i] - ((241-gateY[i])/25);
					}else{
						gateY[i] = gateY[i] + ((241-gateY[i])/25);	
						if(gateY[i] <= 241 && gateY[i] >= 240){
							gateReady[i] = YES;
							[self bringSubviewToFront:gate[i]];
							[self bringSubviewToFront:jumpAlert];
						}
					}
					[gate[i] setTransform:CGAffineTransformMakeScale(gateScale[i],gateScale[i])];
					gate[i].center = CGPointMake(gateY[i],235); 
				}else{
					if(!cleared){
						[aniTimer invalidate];
						[runTimer invalidate];
						[addGateTimer invalidate];
						[viewController displayFailed];
					}
					jump = NO;
					gateScale[i] = 0;
				}
			}
		}
		
		cloudsY = cloudsY - 0.1;
		clouds.center = CGPointMake(270,cloudsY);
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[runTimer invalidate];
			[addGateTimer invalidate];
			[viewController displayWon];
		}
	}
}

- (void)generateGate
{
	[self insertSubview:gate[iterator] belowSubview:track];
	gateReady[iterator] = NO;
	gateY[iterator] = 200;
	gateScale[iterator] = 0.12;
	gate[iterator].center = CGPointMake(gateY[iterator],235);
	[gate[iterator] setTransform:CGAffineTransformMakeScale(gateScale[iterator],gateScale[iterator])];

	if(iterator <2){
		iterator = iterator +1;
	}else{
		iterator =0;
	}
}

- (void) runAnimation
{
	CABasicAnimation *runImgMoveXAnimation = [CABasicAnimation animation];
    runImgMoveXAnimation.keyPath = @"position.x";
    runImgMoveXAnimation.fromValue = [NSNumber numberWithFloat:150];
    runImgMoveXAnimation.toValue = [NSNumber numberWithFloat:160];
    runImgMoveXAnimation.duration = 0.2;
    runImgMoveXAnimation.repeatCount = 2;
	runImgMoveXAnimation.autoreverses = YES;
    runImgMoveXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation: runImgMoveXAnimation forKey:@"runImgMoveX"];
	
	CABasicAnimation *runImgMoveYAnimation = [CABasicAnimation animation];
    runImgMoveYAnimation.keyPath = @"position.y";
    runImgMoveYAnimation.fromValue = [NSNumber numberWithFloat:250];
    runImgMoveYAnimation.toValue = [NSNumber numberWithFloat:230];
    runImgMoveYAnimation.duration = 0.4;
	runImgMoveYAnimation.autoreverses = YES;
    runImgMoveYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation: runImgMoveYAnimation forKey:@"runImgMoveY"];
}

- (void) showJumpAlert
{
	if(!jumpAlertAni){
		jumpAlertAni = YES;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationCurve:1];
		[UIView setAnimationDuration:0.1];
		[UIView setAnimationRepeatCount:4];
		[UIView setAnimationRepeatAutoreverses:YES];
		jumpAlert.alpha = 0.75;
		[UIView commitAnimations]; 
	 }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	jumpAlertAni = NO;
	jumpAlert.alpha = 0;
}		 
		 
		 

@end
