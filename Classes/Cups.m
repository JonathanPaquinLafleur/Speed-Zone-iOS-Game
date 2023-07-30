//
//  Cups.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 18/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Cups.h"
#import <QuartzCore/QuartzCore.h>
#import "GameController.h"

@implementation Cups

@synthesize viewController;

- (void)dealloc {
	[background release];
	[cups[3] release];
	[ball release];
	[sadBall release];
	[hand release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cupsBackground.png"]];
		
		cups[0] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cup.png"]];
		cups[1] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cup.png"]];
		cups[2] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cup.png"]];
		
		ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cupsBall.png"]];
		sadBall = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cupsBallFailed.png"]];
		
		hand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cupHand.png"]];

		cupsY[0] = 120;
		cupsY[1] = 240;
		cupsY[2] = 360;

	}
    return self;
}

- (void)startGame {
	
	[self addSubview:background];
	[self addSubview:ball];
	[self addSubview:sadBall];
	[self addSubview:cups[0]];
	[self addSubview:cups[1]];
	[self addSubview:cups[2]];
	[self addSubview:hand];

	nbSwitch = 0;
	scrambled = NO;
	winningCup = (int)(arc4random()%3);
	
	hand.alpha = 0;
	ball.alpha = 1;
	sadBall.alpha = 0;
	
	int i;
	
	for(i=0;i<3;i++){
		cups[i].center = CGPointMake(80,cupsY[i]);
		if(i==winningCup){
			ball.center = CGPointMake(50,cupsY[i]);
			cups[i].center = CGPointMake(130,cupsY[i]);
		}
	}
	
	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
	hideBallTimer = [NSTimer scheduledTimerWithTimeInterval:0.7 target:self selector: @selector(hideBall) userInfo: nil repeats:NO];
}

- (void) hideBall
{
	[UIView beginAnimations:@"hiden" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.1];
	cups[winningCup].center = CGPointMake(80,cupsY[winningCup]);
	[UIView commitAnimations];
}

- (void) showHandOverCup:(int)cup
{
	hand.center = CGPointMake(300,cupsY[selectedCup]);
	hand.alpha = 1;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationRepeatCount:5];
	[UIView setAnimationRepeatAutoreverses:YES];
	hand.center = CGPointMake(240,cupsY[selectedCup]);
	[UIView commitAnimations];
}

- (void) liftCup:(int)cup
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.1];
	cups[cup].center = CGPointMake(130,cupsY[cup]);
	[UIView commitAnimations];
}

- (void) switchCups
{
	cups1 = (int)(arc4random()%3);
	cups2 = cups1;
	
	while(cups2 == cups1){
		cups2 = (int)(arc4random()%3);
	}
	
	cupsYTmp =  cupsY[cups1];
	
	[UIView beginAnimations:@"switched" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.3];
	cups[cups1].center = CGPointMake(80,cupsY[cups2]);
	cups[cups2].center = CGPointMake(80,cupsY[cups1]);
	if(cups1 == winningCup){
		ball.center = CGPointMake(50,cupsY[cups2]);
	}
	if(cups2 == winningCup){
		ball.center = CGPointMake(50,cupsY[cups1]);
	}
	[UIView commitAnimations];
	
	cupsY[cups1] = cupsY[cups2];
	cupsY[cups2] = cupsYTmp;
	
}

- (void)startAnimation
{
	if([viewController timerActive]){
		
		
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[viewController displayFailed];
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	if(scrambled){
		UITouch *touch = [touches anyObject];
		CGPoint location = [touch locationInView:self];

		if((location.x < 135 && location.x > 22)&&(location.y > cupsY[0]-44 && location.y < cupsY[0]+44)){
			selectedCup = 0;
		}
		if((location.x < 135 && location.x > 22)&&(location.y > cupsY[1]-44 && location.y < cupsY[1]+44)){
			selectedCup = 1;
		}
		if((location.x < 135 && location.x > 22)&&(location.y > cupsY[2]-44 && location.y < cupsY[2]+44)){
			selectedCup = 2;
		}
		[self liftCup:selectedCup];
		[self showHandOverCup:selectedCup];
		if(selectedCup != winningCup){
			sadBall.center = CGPointMake(50,cupsY[winningCup]);
			sadBall.alpha = 1;
			ball.alpha = 0;
			[self liftCup:winningCup];
			[aniTimer invalidate];
			[viewController displayFailed];
		}else{
			[aniTimer invalidate];
			[viewController displayWon];
		}
	}
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	if(theAnimation == @"hiden"){
		switchTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector: @selector(switchCups) userInfo: nil repeats:YES];
	}
	if(theAnimation  == @"switched"){
		nbSwitch = nbSwitch + 1;
		if(nbSwitch == 3){
			[switchTimer invalidate];
		}
		if(nbSwitch == 4){
			scrambled = YES;
		}
	}
}

@end