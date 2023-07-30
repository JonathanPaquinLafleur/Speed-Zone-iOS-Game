//
//  Driver.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 02/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface Driver : UIView {

	GameController *viewController;
	
	UIImageView *track[50];
	UIImageView *background;
	UIImageView *car;
	UIImageView *steering;
	
	UIAccelerationValue xyValue[2];
	
	BOOL animationInit;
	BOOL turnLeft;
	BOOL turnRight;
	
	int nbTracks;
	
	NSTimer *aniTimer;
	NSTimer *curveTimer;
	
	float  picScale[50];
	float  pos[50];
	float  incline;
	float  curve;	
	float  initIncline;
	float  speed;
}

@property (nonatomic, assign) GameController *viewController;


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)updateSteeringWithX:(float)x Y:(float)y;
- (void) updateValue;
- (void) startAnimation;
- (void) randomCurve;

@end