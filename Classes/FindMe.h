//
//  findMe.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 05/04/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface FindMe : UIView {
	
    GameController *viewController;
	
	UIImageView *background;
	UIImageView *aim;
	UIImageView *binoculars;
	UIImageView *ETSky;
	UIImageView *ETSpace;
	UIImageView *ETGround;
	UIImageView *clouds;
	
	
	NSTimer *aniTimer;
    
	BOOL minus;
	
	UIAccelerationValue xyValue[2];
	
}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;
- (void)updatePictureWithX:(float)x Y:(float)y;

@end