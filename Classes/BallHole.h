//
//
//  Created by Jonathan Lafleur on 03/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface BallHole : UIView {

    GameController *viewController;

	UIImageView *ball;
	UIImageView *hole[20];
	UIImageView *winningHole;
	UIImageView *arrow;
	UIImageView *arrow2;
	UIImageView *highlightView;
	
	BOOL redHole;
	
	int numberHole;
	
	float distance;
	float dX;
	float dY;
	float ballxyValue[2];
	
	NSTimer *aniTimer;
	NSTimer *arrowTimer;
    
	UIAccelerationValue xyValue[2];

}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;
- (void)startArrow;
- (void)updateBallWithX:(float)x Y:(float)y;
- (void)scaleWithFloatX:(float)x Y:(float)y;
- (void)moveWithFloatX:(float)x Y:(float)y;

@end
