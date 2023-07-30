//
//
//  Created by Jonathan Lafleur on 03/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "BallHole.h"
#import <QuartzCore/QuartzCore.h>
#import "GameController.h"

@implementation BallHole


@synthesize viewController;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}

- (void)dealloc {
	[ball release];
	[hole[20] release];
	[winningHole release];
	[arrow release];
	[arrow2 release];
	[highlightView release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		int i;
		numberHole = 6;
		
		[self setBackgroundColor:[UIColor colorWithRed:(8.0/255.0) green:(141.0/255.0) blue:(2.0/255.0) alpha:1.0]];
		
		winningHole = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goodhole.png"]];
		winningHole.center = CGPointMake(160,450);
		
		for(i = 0; i <= numberHole; ++i){
			hole[i] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hole.png"]];
		}
		
		ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boule.png"]];	
		
		arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
		
		arrow2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
		
		highlightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundhighlight.png"]];
		
	}
    return self;
}

- (void)updateBallWithX:(float)x Y:(float)y {
	
	xyValue[0]=x;
	xyValue[1]=y;
	
}

- (void)startGame {
	
	int i;
	redHole = NO;
	
	for(i = 0; i <= numberHole; ++i){
		if(i==0){
			hole[i].center = CGPointMake(25,100);
		} else {
			if(i==numberHole){
				hole[i].center = CGPointMake(295,400);
			} else {
				hole[i].center = CGPointMake((float)(arc4random()%270)+25,(i * 50) + 100);
			}
		}
		[self addSubview:hole[i]];
	}
	
	[arrow setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90])];
	[arrow2 setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:-90])];
	
    [self addSubview:winningHole];	
    [self addSubview:arrow];
	[self addSubview:arrow2];
	[self addSubview:highlightView];
	[self addSubview:ball];
	
	arrow.center = CGPointMake(100,450);
	arrow2.center = CGPointMake(220,450);
	
	[ball setTransform:CGAffineTransformMakeScale(1,1)];
	ballxyValue[0] = 160.0;
	ballxyValue[1] = 30.0;
	ball.center = CGPointMake(ballxyValue[0],ballxyValue[1]);
	
	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
	arrowTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector: @selector(startArrow) userInfo: nil repeats:NO];
}

- (void)startAnimation
{
	if([viewController timerActive]){
		int i;
		ballxyValue[0] = ballxyValue[0] + (xyValue[0]-[viewController initialX]) * 40;
		ballxyValue[1] = ballxyValue[1] - xyValue[1] * 40;
		if(ballxyValue[0]<20) ballxyValue[0] = 20;
		if(ballxyValue[1]<20) ballxyValue[1] = 20;
		if(ballxyValue[0]>300) ballxyValue[0] = 300;
		if(ballxyValue[1]>460) ballxyValue[1] = 460;
		ball.center = CGPointMake(ballxyValue[0],ballxyValue[1]);
		for(i = 0; i <= numberHole + 1; ++i){
			if(i == numberHole + 1){
				dX = ball.center.x - winningHole.center.x;
				dY = ball.center.y - winningHole.center.y;
				redHole = YES;
			} else {
				dX = ball.center.x - hole[i].center.x;
				dY = ball.center.y - hole[i].center.y;
				redHole = NO;
			}
			distance = sqrtf(dX * dX + dY * dY);
			if(distance < 20) {
				[aniTimer invalidate];
				[self scaleWithFloatX:0.1 Y:0.1];
				if(redHole){
					[viewController displayWon];
					[self moveWithFloatX:winningHole.center.x Y:winningHole.center.y];
				} else {
					[viewController displayFailed];
					[self moveWithFloatX:hole[i].center.x Y:hole[i].center.y];
				}
			}
		}	
		
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[viewController displayFailed];
		}
	}
}

- (void)scaleWithFloatX:(float)x Y:(float)y {
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[ball setTransform:CGAffineTransformMakeScale(x,y)];
	[UIView commitAnimations]; 
	
}

- (void)moveWithFloatX:(float)x Y:(float)y{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	ball.center = CGPointMake(x,y);
	[UIView commitAnimations]; 
	
}

- (void) startArrow {
	
	CABasicAnimation *arrowImgMoveXAnimation = [CABasicAnimation animation];
    arrowImgMoveXAnimation.keyPath = @"position.x";
    arrowImgMoveXAnimation.fromValue = [NSNumber numberWithFloat:100];
    arrowImgMoveXAnimation.toValue = [NSNumber numberWithFloat:75];
    arrowImgMoveXAnimation.duration = 0.3;
    arrowImgMoveXAnimation.repeatCount = 11;
	arrowImgMoveXAnimation.autoreverses = YES;
    arrowImgMoveXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [arrow.layer addAnimation: arrowImgMoveXAnimation forKey:@"arrowImgMoveX"];
	
	CABasicAnimation *arrow2ImgMoveXAnimation = [CABasicAnimation animation];
    arrow2ImgMoveXAnimation.keyPath = @"position.x";
    arrow2ImgMoveXAnimation.fromValue = [NSNumber numberWithFloat:220];
    arrow2ImgMoveXAnimation.toValue = [NSNumber numberWithFloat:245];
    arrow2ImgMoveXAnimation.duration = 0.3;
    arrow2ImgMoveXAnimation.repeatCount = 11;
	arrow2ImgMoveXAnimation.autoreverses = YES;
    arrow2ImgMoveXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [arrow2.layer addAnimation: arrow2ImgMoveXAnimation forKey:@"arrow2ImgMoveX"];
	
}

@end
