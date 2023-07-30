//
//  GameController.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 02/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUpdateFrequency 30 
#define kFilteringFactor 0.1

@class StyleSheetView,EggFall,BallHole,Driver,Crane,Cups,Calcul,Marathon,EtchASketch,FindMe,Valve,ColorMix,SpeedZoneAppDelegate,AudioPlayer,AudioQueueObject;

@interface GameController : UIViewController <UIAccelerometerDelegate>{
	
	StyleSheetView *styleSheetView;
	EggFall *eggFall;
	BallHole *ballHole;
	Driver *driver;
	Crane *crane;
	Cups *cups;
	Calcul *calcul;
	Marathon *marathon;
	EtchASketch *etchASketch;
	FindMe *findMe;
	Valve *valve;
	ColorMix *colorMix;
	SpeedZoneAppDelegate *appDel;
	
	NSTimer *gameTimer;
	NSTimer *acceTestTimer;
	
	float gameTime;
	float initialX;
	float initialY;
	
	int totalNbOfLoops;
	int lastLoopNb;
	int loopNb;
	
	UIAccelerationValue accelerationValues[2];
	
	BOOL acceActive;
	BOOL gameActive;
	BOOL timerActive;
	BOOL accePreStart;
	BOOL gameWon;
	BOOL gameFailed;
	
	UIImageView *timerBar;
	UIImageView *timerStatic;
	UIImageView *wonView;
	UIImageView *failedView;
	UIImageView *whiteFade;
	
	NSString *gameToStart;
	NSString *loops[10];
	
	IBOutlet UIWindow *window;
	
	AudioPlayer		*gameLoop;
	AudioPlayer		*wonSound;
	AudioPlayer		*failedSound;
}

@property (nonatomic, assign) float gameTime;
@property (nonatomic, assign) BOOL gameWon;
@property (nonatomic, assign) float initialX;
@property (nonatomic, assign) float initialY;
@property (nonatomic, assign) BOOL gameActive;
@property (nonatomic, assign) BOOL timerActive;

- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window;
- (void) startGameWithName: (NSString *) gameName;
- (void) flipTransitionToGame;
- (void) startTimer;
- (void) handleTimer;
- (void) displayFailed;
- (void) displayWon;
- (void) whiteFadeIn;
- (void) whiteFadeOut;
- (UIView *) gameInstance;

@end
