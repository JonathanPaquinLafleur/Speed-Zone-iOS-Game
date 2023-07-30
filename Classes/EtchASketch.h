//
//  Rotator.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 23/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GameController;

@interface EtchASketch : UIView {
	
    GameController *viewController;
	
	UIImageView *background;
	UIImageView *picture;
	
	NSTimer *aniTimer;
    
	float pictureAlpha;
	
	UIAccelerationValue xyValue[2];
	UIAccelerationValue xyValueTmp[2];
	
}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;
- (void)updatePictureWithX:(float)x Y:(float)y;

@end