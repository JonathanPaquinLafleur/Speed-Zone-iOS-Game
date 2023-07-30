//
//  Driver.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 02/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Driver.h"
#import "GameController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation Driver

@synthesize viewController;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
	self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		[self setBackgroundColor:[UIColor clearColor]];
		
		int i;
		nbTracks = 11;
		NSString *trackNb;
		for(i = 0; i <= nbTracks; ++i){
			if(fmod(i,2)!=1){
				trackNb=@"track1.png";	
			}else{trackNb=@"track2.png";}
			track[i] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:trackNb]];
		}
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"driverBackground.png"]];
		background.center = CGPointMake(152,240);
		car = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"carDriver.png"]];
		car.center = CGPointMake(160,240);
	}
    return self;
}

- (void)dealloc {
	[track[60] release];
	[background release];
	[car release];
    [super dealloc];
}

- (void)updateSteeringWithX:(float)x Y:(float)y {
	
	xyValue[1]=y;
	
}


- (void)startGame
{
	int i;
	int e;
	
	speed = 4.1;
	
	incline = 0;
	curve = 0;
	
	turnLeft = NO;
	turnRight = NO;
	
	for(i = nbTracks; i >= 0; --i){
		if(i == nbTracks){
			picScale[i] = 0.10;
		}else{
			picScale[i] = picScale[i+1]+(picScale[i+1]/speed);
		}
		pos[i] = 240.0;
	}
	
	[self addSubview:background];
	
	for(e = nbTracks; e >= 0; --e){
		track[e].center = CGPointMake((162-(picScale[e]*162)),pos[e]);
		[track[e] setTransform:CGAffineTransformMakeScale(picScale[e],picScale[e])];
		[self addSubview:track[e]];
	}
	[self startAnimationTimer];
}

- (void)startAnimationTimer {
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
	[self randomCurve];
	curveTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector: @selector(randomCurve) userInfo: nil repeats:YES];
}

- (void) startAnimation {
	int i;
	float tmp;
	
	if([viewController timerActive]){
		tmp = xyValue[1]*40.0;
		for(i = 0; i <= nbTracks; ++i){
			if(picScale[i] > 1.1){
				if((pos[i]+tmp) >= 460 || (pos[i]+tmp) <= 20){
					[aniTimer invalidate];	
					[curveTimer invalidate];
					AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
					[viewController displayFailed];
				}
				
				[self sendSubviewToBack:track[i]]; 
				[self sendSubviewToBack:background];
				
				if(turnRight){
					if(incline < 0){
						incline = incline-(incline/20.0);
					}else{
						incline = incline+(incline/20.0);
					}
					if(i != 0){
						pos[i] = (pos[i-1]-tmp) + incline;
					}else{
						pos[i] = pos[nbTracks] + incline;	
					}
				}
				if(turnLeft){
					if(incline < 0){
						incline = incline+(incline/20.0);
					}else{
						incline = incline-(incline/20.0);
					}
					if(i != 0){
						pos[i] = (pos[i-1]-tmp) + incline;
					}else{
						pos[i] = pos[nbTracks] + incline;	
					}
				}
				if(!(incline >-1 && incline < 1)){
					if(incline > 0){
						if(incline > curve || turnLeft){
							turnRight = NO;
							turnLeft = YES;
						}else{
							turnRight = YES;
							turnLeft = NO;	
						}
					}else{
						if(incline < curve || turnRight){
							turnRight = YES;
							turnLeft = NO;
						}else{
							turnRight = NO;
							turnLeft = YES;	
						}
					}
				}else{
					incline = 0.0;
				}
				picScale[i] = 0.10;
			}else{
				picScale[i] = picScale[i]+(picScale[i]/speed);
			}
			pos[i] = pos[i]+tmp;
			//[self setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90*tmp])];
			//[steering setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90*(-tmp)])];

			track[i].center = CGPointMake((162-(picScale[i]*162)),pos[i]);

			[track[i] setTransform:CGAffineTransformMakeScale(picScale[i],picScale[i])];
		}
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[curveTimer invalidate];
			[viewController displayWon];
		}
	}
	
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	
}

- (void) randomCurve {
	while(incline < 5 && incline > -5){
		incline = (float)(arc4random()%20)-10;
	}
	if(incline < 0){
		while(curve > -5){
			curve = (float)(arc4random()%25)-25;
		}
	}else{
		while(curve < 5){
			curve = (float)(arc4random()%25);
		}
	}
	initIncline = incline;
}

@end