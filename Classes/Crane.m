//
//  Crane.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 15/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Crane.h"
#import <QuartzCore/QuartzCore.h>
#import "GameController.h"

@implementation Crane

@synthesize viewController;

- (void)dealloc {
	[background release];
	[hook release];
	[redCrate release];
	[crate release];
	[craneControl release];
	[stick release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craneBackground.png"]];
			
		hook = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craneHook.png"]];
		
		redCrate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craneCrateRed.png"]];
		redCrate.alpha = 0.8;
		
		crate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craneCrate.png"]];
		
		craneControl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craneControl.png"]];
		craneControl.center = CGPointMake(261,416);
		
		stick = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"craneStick.png"]];
		
	}
    return self;
}

- (void)startGame {
	
	[self addSubview:background];
	[self addSubview:redCrate];
	[self addSubview:crate];
	[self addSubview:hook];
	[self addSubview:craneControl];
	[self addSubview:stick];
	
	crateXY[0] = 180;
	crateXY[1] = 240;
	
	redCrateY = (float)(arc4random()%(int)(360))+60;
	
	hookXY[0]=400;
	hookXY[1]=240;
	
	hook.center = CGPointMake(hookXY[0],hookXY[1]);
	
	crate.center = CGPointMake(crateXY[0],crateXY[1]);
	
	redCrate.center = CGPointMake(38,redCrateY);
	
	stick.center = CGPointMake(263,422);
	
	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
}

- (void)startAnimation
{
	if([viewController timerActive]){
		
		if(!((crateXY[1] < redCrateY + 20)&&(crateXY[1] > redCrateY - 20) && crateXY[0] == 50)){
			
			hookXY[0] = hookXY[0]+stickXY[0];
			hookXY[1] = hookXY[1]+stickXY[1];
			
			if(hookXY[0]<270) hookXY[0] = 270;
			if(hookXY[1]<20) hookXY[1] = 20;
			if(hookXY[0]>470) hookXY[0] = 470;
			if(hookXY[1]>460) hookXY[1] = 460;
		
			crateXY[0] = hookXY[0]-220;
			crateXY[1] = hookXY[1];
			
			crate.center = CGPointMake(crateXY[0],crateXY[1]);
			hook.center = CGPointMake(hookXY[0],hookXY[1]);
		}else{
			[aniTimer invalidate];
			[viewController displayWon];
		}
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[viewController displayFailed];
		}
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	
	dX = location.x - 263;
	dY = location.y - 422;
	
	distance = sqrtf(dX * dX + dY * dY);
	if(distance <= 32){
		stickXY[0] = (location.x-263)/16;
		stickXY[1] = (location.y-422)/16;
		stick.center = location;		
	}else{
		stickXY[0] = ((location.x-263)*(32/distance))/16;
		stickXY[1] = ((location.y-422)*(32/distance))/16;
		stick.center = CGPointMake(263+((location.x-263)*(32/distance)),422+((location.y-422)*(32/distance)));
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	
	dX = location.x - 263;
	dY = location.y - 422;
	
	distance = sqrtf(dX * dX + dY * dY);
	if(distance <= 32){
		stickXY[0] = (location.x-263)/16;
		stickXY[1] = (location.y-422)/16;
		stick.center = location;		
	}else{
		stickXY[0] = ((location.x-263)*(32/distance))/16;
		stickXY[1] = ((location.y-422)*(32/distance))/16;
		stick.center = CGPointMake(263+((location.x-263)*(32/distance)),422+((location.y-422)*(32/distance)));
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	stickXY[0] = 0;
	stickXY[1] = 0;
	stick.center = CGPointMake(263,422);
}

@end
