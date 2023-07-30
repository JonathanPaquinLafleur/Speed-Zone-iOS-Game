//
//  Rotator.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 23/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EtchASketch.h"
#import <QuartzCore/QuartzCore.h>
#import "GameController.h"

@implementation EtchASketch


@synthesize viewController;

- (void)dealloc {
	[background release];
	[picture release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"etchasketchBackground.png"]];	
		picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"etchasketchPicture.png"]];	
		
		[self addSubview:background];	
		[self addSubview:picture];
		
		picture.center = CGPointMake(160,240);
		
	}
    return self;
}

- (void)updatePictureWithX:(float)x Y:(float)y {
	
	xyValue[0]=x;
	xyValue[1]=y;
	
	if((((xyValue[0] - xyValueTmp[0]) > 0.1)||((xyValue[1] - xyValueTmp[1]) > 0.1))||(((xyValue[0] - xyValueTmp[0]) < -0.1)||((xyValue[1] - xyValueTmp[1]) < -0.1))){
		pictureAlpha = pictureAlpha - 0.1;
	}
	
	xyValueTmp[0] = xyValue[0];
	xyValueTmp[1] = xyValue[1];
	
}

- (void)startGame {
	
	pictureAlpha = 1;

	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
}

- (void)startAnimation
{
	if([viewController timerActive]){
		
		picture.alpha = pictureAlpha;
		if(pictureAlpha < 0){
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

@end