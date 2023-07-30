//
//  Valve.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 23/06/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface Valve : UIView {
	
	GameController *viewController;

	UIImageView *background;
	UIImageView *valve;
	UIImageView *pipe;
	UIImageView *steam1;
	UIImageView *steam2;
	
	float steamScale1;
	float steamScale2;
	float steamAni;
	float frameRadians;
	float frameDegrees;
	float frameDegreesTmp;
	float frameDegreesInit;
	float steamAlpha;
	
	int nbTurns;
	int nbTurnsTotal;
	
	UIAccelerationValue xyValue[2];
	
	NSTimer *aniTimer;
}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;
- (void)updateValveWithX:(float)x Y:(float)y;

@end
