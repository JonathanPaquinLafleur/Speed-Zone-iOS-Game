//
//  Marathon.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 22/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface Marathon : UIView {
	
	GameController *viewController;
	
	UIImageView *background;
	UIImageView *clouds;
	UIImageView *gate[3];
	UIImageView *track;
	UIImageView *jumpAlert;
	
	UIAccelerationValue xyValue[2];
	
	NSTimer *aniTimer;
	NSTimer *addGateTimer;
	NSTimer *runTimer;
	
	BOOL gateReady[3];
	BOOL jump;
	BOOL cleared;
	BOOL jumpAlertAni;
	
	float cloudsY;
	float gateY[3];
	float gateScale[3];
	float jumpHeight;
	float preJump;
	float interval;
	float gateYTmp;
	
	int i;
	int e;
	int iterator;

}

@property (nonatomic, assign) GameController *viewController;


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimation;
- (void)startAnimationTimer;
- (void)updateJumpWithX:(float)x Y:(float)y;
- (void) generateGate;
- (void) runAnimation;
- (void) showJumpAlert;

@end
