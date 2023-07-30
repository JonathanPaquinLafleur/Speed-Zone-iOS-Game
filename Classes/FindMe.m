//
//  findMe.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 05/04/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "findMe.h"
#import <QuartzCore/QuartzCore.h>
#import "GameController.h"

@implementation FindMe


@synthesize viewController;

- (void)dealloc {
	[background release];
	[ETSky release];
	[ETSpace release];
	[ETGround release];
	[clouds release];
	[binoculars release];
	[aim release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findMeBackground.png"]];	
		ETSky = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findMeInSky.png"]];	
		ETSpace = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findMeInSpace.png"]];	
		ETGround = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findMeOnGround.png"]];	
		aim = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findMeAim.png"]];	
		binoculars = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findMeBinoculars.png"]];	
		clouds = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"findMeClouds.png"]];	
		
		clouds.center = CGPointMake(360,240);
		
		background.center = CGPointMake(-270,240);
		
		[self addSubview:background];	
		[self addSubview:clouds];
		[self addSubview:ETSky];	
		[self addSubview:ETSpace];
		[self addSubview:ETGround];	
		[self addSubview:aim];
		[self addSubview:binoculars];	
		
	}
    return self;
}

- (void)updatePictureWithX:(float)x Y:(float)y {

	xyValue[0]=x;
}

- (void)startGame {
	
	minus = YES;
	
	clouds.center =  CGPointMake(background.center.x+360,240);
	
	self.center = CGPointMake(590,240);
	
	ETSky.alpha = 0;
	ETSpace.alpha = 0;
	ETGround.alpha = 0;
	
	
	
	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
}

- (void)startAnimation
{
	if([viewController timerActive]){
		if(((xyValue[0]-[viewController initialX])!=0)&&((1180*(1-(-(xyValue[0]+0.5)*2)))<=1180 && (1180*(1-(-(xyValue[0]+0.5)*2)))>=-0)){
			self.center = CGPointMake(1180*(1-(-(xyValue[0]+0.5)*2)),240);
		}
		clouds.center =  CGPointMake(background.center.x+360,clouds.center.y+0.1);
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[viewController displayFailed];
		}
	}
}

@end