//
//  Valve.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Valve.h"
#import <QuartzCore/QuartzCore.h>
#import "GameController.h"

@implementation Valve

@synthesize viewController;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}
- (CGFloat) RadiansToDegrees:(CGFloat) radians {
	return radians * 180 / M_PI;
}

- (void)dealloc {
	[background release];
	[valve release];
	[steam1 release];
	[steam2 release];
	[pipe release];
	[super dealloc];
}

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"valveBackground.png"]];	
		steam1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"valveSteam.png"]];
		steam2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"valveSteam.png"]];
		pipe = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pipe.png"]];
		valve = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"valve.png"]];	
		
		valve.center = CGPointMake(160,240);
		steam1.center = CGPointMake(358,240);
		steam2.center = CGPointMake(270,240);
		pipe.center = CGPointMake(160,240);
		background.center = CGPointMake(160,240);
		
		[self addSubview:background];	
		[self addSubview:steam1];
		[self addSubview:steam2];
		[self addSubview:pipe];
		[self addSubview:valve];	
		
	}
    return self;
}

- (void)updateValveWithX:(float)x Y:(float)y {
	
	xyValue[0]=x;
	xyValue[1]=y;
	
	frameRadians=atan2(xyValue[0],xyValue[1]);
	[self setTransform:CGAffineTransformMakeRotation(frameRadians)];
	[valve setTransform:CGAffineTransformMakeRotation(3.1416-frameRadians)];

}

- (void)startGame {
	
	frameDegreesInit=0;
	steamScale1 = 0.5;
	steamScale2 = 1.5;
	nbTurns = 0;
	nbTurnsTotal = (int)(arc4random()%3)+1;
	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
}

- (void)startAnimation
{
	if([viewController timerActive]){

		frameDegreesTmp = frameDegrees;
		frameDegrees= [self RadiansToDegrees:frameRadians]+180;
		
		if(frameDegreesInit==0){
			frameDegreesInit=frameDegrees;
		}

		if((frameDegreesTmp>270&&frameDegreesTmp<=360)&&(frameDegrees>=0&&frameDegrees<90)){
			nbTurns--;
		}
		if((frameDegrees>270&&frameDegrees<=360)&&(frameDegreesTmp>=0&&frameDegreesTmp<90)){
			nbTurns++;
		}
		
		steamAlpha = 1/(((nbTurnsTotal*360)+frameDegreesInit)/(((nbTurnsTotal-nbTurns)*360)+frameDegrees));
		
		if(steamAlpha<=1){
			steam1.alpha = steamAlpha;
			steam2.alpha = steamAlpha;
		}
		
		if((nbTurns==nbTurnsTotal) && (frameDegrees<=frameDegreesInit)){
			steam1.alpha = 0;
			steam2.alpha = 0;
			[aniTimer invalidate];
			[viewController displayWon];
		}
		
		if(steamScale1<=(steam1.alpha/1.2)){
			steamAni=0.05;
		}
		if(steamScale1>=(steam1.alpha/0.8)){
			steamAni=-0.05;
		}
		
		steamScale1=steamScale1+steamAni;
		steamScale2=steamScale2+steamAni;
		[steam1 setTransform:CGAffineTransformMakeScale(steamScale1,steamScale1)];
		[steam2 setTransform:CGAffineTransformMakeScale(steamScale1,steamScale1)];
		
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[viewController displayFailed];
		}
	}
}

@end
