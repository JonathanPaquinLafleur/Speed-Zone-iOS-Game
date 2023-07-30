//
//  Crane.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 15/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>

@class GameController;

@interface Crane : UIView {
    GameController *viewController;
	
	UIImageView *background;
	UIImageView *hook;
	UIImageView *redCrate;
	UIImageView *crate;
	UIImageView *craneControl;
	UIImageView *stick;
	
	float redCrateY;
	float dX;
	float dY;
	float distance;
	float crateXY[2];
	float hookXY[2];
	float stickXY[2];
	
	NSTimer *aniTimer;
	NSTimer *arrowTimer;
	
}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;

@end