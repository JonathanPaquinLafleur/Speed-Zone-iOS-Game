//
//  GameController.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 02/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"
#import "SpeedZoneAppDelegate.h"
#import "StyleSheetView.h"
#import <QuartzCore/QuartzCore.h>
#import "EggFall.h"
#import "BallHole.h"
#import "Cups.h"
#import "Crane.h"
#import "Calcul.h"
#import "Driver.h"
#import "Marathon.h"
#import "EtchASketch.h"
#import "FindMe.h"
#import "Valve.h"
#import "colorMix.h"
#import "AudioQueueObject.h"
#import "AudioPlayer.h"

@implementation GameController

@synthesize gameTime;
@synthesize gameWon;
@synthesize gameActive;
@synthesize timerActive;
@synthesize initialX;
@synthesize initialY;

- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window {
	if (self = [super init]) {	
	   	
		window = _window;
		appDel = _appDel;
		
		CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
		
		eggFall = [[EggFall alloc] initWithFrame:applicationFrame viewController:self];		
		ballHole = [[BallHole alloc] initWithFrame:applicationFrame viewController:self];		
		calcul = [[Calcul alloc] initWithFrame:applicationFrame viewController:self];		
		crane = [[Crane alloc] initWithFrame:applicationFrame viewController:self];		
		cups = [[Cups alloc] initWithFrame:applicationFrame viewController:self];		
		driver = [[Driver alloc] initWithFrame:applicationFrame viewController:self];		
		marathon = [[Marathon alloc] initWithFrame:applicationFrame viewController:self];		
		etchASketch = [[EtchASketch alloc] initWithFrame:applicationFrame viewController:self];		
		findMe = [[FindMe alloc] initWithFrame:applicationFrame viewController:self];
		valve = [[Valve alloc] initWithFrame:applicationFrame viewController:self];
		colorMix = [[ColorMix alloc] initWithFrame:applicationFrame viewController:self];
		
		styleSheetView = [[StyleSheetView alloc] initWithFrame:applicationFrame viewController:self];
		
		timerStatic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timerStatic.png"]];
		timerStatic.center =  CGPointMake(20,240);
		
		timerBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timerBar.png"]];
		timerBar.layer.anchorPoint = CGPointMake(0,0.0565);
		timerBar.center =  CGPointMake(-1,27);
		[timerBar setTransform:CGAffineTransformMakeScale(1,0.01)];
		
		wonView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"won.png"]];
		wonView.alpha = 0;
		[wonView setTransform:CGAffineTransformMakeScale(0.5,0.5)];
		
		failedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"failed.png"]];
		failedView.alpha = 0;
		[failedView setTransform:CGAffineTransformMakeScale(0.5,0.5)];
		
		whiteFade = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteFade.png"]];
		whiteFade.alpha = 1;
		
		[[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kUpdateFrequency)];
		[[UIAccelerometer sharedAccelerometer] setDelegate:self];
		
		loops[0] = @"Techno1";
		loops[1] = @"Techno2";
		
		wonSound = [[AudioPlayer alloc] initShortFXWithName:@"win"];
		failedSound = [[AudioPlayer alloc] initShortFXWithName:@"lost"];
		[failedSound setAudioVolume:0.4];
		
		totalNbOfLoops = 2;
		loopNb = 0;
		lastLoopNb = 0;

		acceTestTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector: @selector(resetAccelerometer) userInfo: nil repeats:YES];	
	}
	return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[failedView release];
	[wonView release];
	[timerBar release];
	[timerStatic release];
	[styleSheetView release];
	[ballHole release];
	[eggFall release];
	[cups release];
	[crane release];
	[calcul release];
	[marathon release];
	[etchASketch release];
	[findMe release];
	[valve release];
	[colorMix release];
	[whiteFade release];
    [super dealloc];
}

- (void)startTimer {
	gameTime = 0;
	[self.view addSubview:timerStatic];
	[self.view addSubview:timerBar];
	
	timerBar.alpha = 0;
	timerStatic.alpha = 0;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	timerBar.alpha = 1;
	timerStatic.alpha = 1;
	[UIView commitAnimations]; 
	
	gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(handleTimer) userInfo: nil repeats:YES];	
}

- (void) handleTimer 
{
	if(timerActive){
		gameTime = gameTime + 0.01;
		[timerBar setTransform:CGAffineTransformMakeScale(1,gameTime/4)];
		if(gameTime > 3.99) {
			timerActive = NO;
			gameActive = NO;
			[gameTimer invalidate];	
			gameTime = 4.0;
		}
	}else{
		[gameTimer invalidate];	
	}
}

- (void)displayWon {
	if(!gameFailed){
		
		timerActive = NO;
		gameActive = NO;
		
		[wonSound playShortFX];
		
		gameWon = YES;
		wonView.alpha = 0;
		[wonView setTransform:CGAffineTransformMakeScale(0.5,0.5)];
		[self.view addSubview:wonView];
		[UIView beginAnimations:@"displayWon" context:NULL];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDelegate:self];
		wonView.alpha = 1;
		[wonView setTransform:CGAffineTransformMakeScale(1,1)];
		[UIView commitAnimations]; 
	}
}

- (void)displayFailed {
	if(!gameWon){
		
		timerActive = NO;
		gameActive = NO;
		
		[failedSound playShortFX];
		
        gameFailed = YES;	
		failedView.alpha = 0;
		[failedView setTransform:CGAffineTransformMakeScale(0.5,0.5)];
		[self.view addSubview:failedView];
		[UIView beginAnimations:@"displayFailed" context:NULL];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDelegate:self];
		failedView.alpha = 1;
		[failedView setTransform:CGAffineTransformMakeScale(1,1)];
		[UIView commitAnimations]; 
	}
}

- (void) startGameWithName: (NSString *) gameName {
	
	//while(loopNb == lastLoopNb){
	//loopNb = (int)(arc4random()%(totalNbOfLoops));
	//}
	//lastLoopNb = loopNb;
	//gameLoop = [[AudioPlayer alloc] initWithName:loops[loopNb]];
	//[gameLoop setAudioVolume:0.0];
	//[gameLoop playFadeInIsLooping:YES Delay:0.5 Duration:1.8 ToVolume:0.5];
	
	accePreStart = YES;
	gameWon = NO;
	gameFailed = NO;
	gameToStart = gameName;
	
	[self.view addSubview:styleSheetView];
	[window addSubview:self.view];
	[window bringSubviewToFront:self.view];
	[styleSheetView generateStyleSheet:gameName];
}

-(void)flipTransitionToGame {
	gameActive = YES;
	initialX = 100;
	initialY = 100;
	
	[[self gameInstance] startGame];
	[UIView beginAnimations:@"stylesheetToGame" context:NULL];
	[UIView setAnimationTransition:(UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	[styleSheetView removeFromSuperview];
	[self.view addSubview:[self gameInstance]];
	[UIView commitAnimations]; 
}

- (void)resetAccelerometer {
	if(!acceActive){
		[[UIAccelerometer sharedAccelerometer] setDelegate:NULL];
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
		[[UIAccelerometer sharedAccelerometer] setDelegate:self]; 
	} else {
	[acceTestTimer invalidate];	}
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	acceActive = YES;
	if(accePreStart){
		accelerationValues[0] = acceleration.x * kFilteringFactor + accelerationValues[0] * (1.0 - kFilteringFactor);
		accelerationValues[1] = acceleration.y * kFilteringFactor + accelerationValues[1] * (1.0 - kFilteringFactor);
		if(gameActive){
			if(initialX == 100){
				initialX = accelerationValues[0];
			}
			if(initialY == 100){
				initialY = accelerationValues[1];
			}
			if(gameToStart == @"ballHole"){[ballHole updateBallWithX:(float)accelerationValues[0] Y:(float)accelerationValues[1]];}
			if(gameToStart == @"eggFall"){[eggFall updateFallWithX:(float)accelerationValues[0] Y:(float)accelerationValues[1]];}
			if(gameToStart == @"driver"){[driver updateSteeringWithX:(float)accelerationValues[0] Y:(float)accelerationValues[1]];}
			if(gameToStart == @"marathon"){[marathon updateJumpWithX:(float)accelerationValues[0] Y:(float)accelerationValues[1]];}
			if(gameToStart == @"etchASketch"){[etchASketch updatePictureWithX:(float)accelerationValues[0] Y:(float)accelerationValues[1]];}
			if(gameToStart == @"findMe"){[findMe updatePictureWithX:(float)accelerationValues[0] Y:(float)accelerationValues[1]];}
			if(gameToStart == @"valve"){[valve updateValveWithX:(float)accelerationValues[0] Y:(float)accelerationValues[1]];}
		}
	}
}

- (void) whiteFadeIn {
	whiteFade.alpha = 1;
	[self.view addSubview:whiteFade];
	[UIView beginAnimations:@"whiteFadeIn" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 0;
	[UIView commitAnimations];	
}

- (void) whiteFadeOut {
	
	gameToStart = NULL;
	accePreStart = NO;

	whiteFade.alpha = 0;
	[self.view addSubview:whiteFade];
	[UIView beginAnimations:@"whiteFadeOut" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 1;
	[UIView commitAnimations];	
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	if(theAnimation == @"displayWon" || theAnimation == @"displayFailed") {
		
		[gameLoop stopFadeOutWithDelay:0.0 Duration:1.6];
		
		[self whiteFadeOut];
	}
	if(theAnimation == @"stylesheetToGame") {
		timerActive = YES;
		[self startTimer];
	}
	if(theAnimation == @"whiteFadeIn") {
		[whiteFade removeFromSuperview];
		[styleSheetView countDownAnimation];
	}
	if(theAnimation == @"whiteFadeOut") {
		[whiteFade removeFromSuperview];
		[self.view removeFromSuperview];
		[appDel playWhiteFadeIn];
	}
}

- (UIView *) gameInstance {
	if(gameToStart == @"eggFall"){return eggFall;}
	if(gameToStart == @"ballHole"){return ballHole;}
	if(gameToStart == @"driver"){return driver;}
	if(gameToStart == @"crane"){return crane;}
	if(gameToStart == @"cups"){return cups;}
	if(gameToStart == @"calcul"){return calcul;}
	if(gameToStart == @"marathon"){return marathon;}
	if(gameToStart == @"etchASketch"){return etchASketch;}
	if(gameToStart == @"findMe"){return findMe;}
	if(gameToStart == @"valve"){return valve;}
	if(gameToStart == @"colorMix"){return colorMix;}
}

@end
