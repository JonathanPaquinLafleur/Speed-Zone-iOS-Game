//
//  EggFall.h
//  jeu
//
//  Created by Jonathan Lafleur on 17/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface EggFall : UIView {
	
	GameController *viewController;
	
	UIImageView *targetView;
	UIImageView *eggView;
	
	float scale;
	float eggxyValue[2];
	float initEggxyValue[2];
	
	UIAccelerationValue xyValue[2];
	
	NSTimer *aniTimer;
	NSTimer *fallTimer;
}

@property (nonatomic, assign) GameController *viewController;


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startFall;
- (void)startAnimation;
- (void)startAnimationTimer;
- (void)updateFallWithX:(float)x Y:(float)y;

@end
