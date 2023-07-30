//
//  Cups.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 18/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface Cups : UIView {
    GameController *viewController;
	
	UIImageView *background;
	UIImageView *cups[3];
	UIImageView *ball;
	UIImageView *sadBall;
	UIImageView *hand;
	
	int winningCup;
	int cupsY[3];
	int cupsYTmp;
	int cups1;
	int cups2;
	int nbSwitch;
	int selectedCup;
	
	NSTimer *aniTimer;
	NSTimer *hideBallTimer;
	NSTimer *switchTimer;
	
	BOOL scrambled;
	
}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;
- (void) hideBall;
- (void) switchCups;
- (void) liftCup:(int)cup;
- (void) showHandOverCup:(int)cup;

@end