//
//  ColorMix.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 03/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface ColorMix : UIView {

	GameController *viewController;
	
	UIImageView *background;
	UIImageView *yellow;
	UIImageView *blue;
	UIImageView *green;
	UIImageView *red;
	UIImageView *mixedColors[4];
	
	int centeredColors,colorKey;
	
	float dX;
	float dY;
	float distance;
	
	NSTimer *aniTimer;
}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;
- (void)animateTouchAtPoint:(CGPoint)touchPoint withView:(UIView *)view;
- (void)animateTouchEndedAtPoint:(CGPoint)touchPoint withView:(UIView *)view;
- (void)hideMixedColor;
- (BOOL)rightColorMix;


@end
