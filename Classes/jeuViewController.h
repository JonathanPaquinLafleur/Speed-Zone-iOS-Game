//
//  jeuViewController.h
//  jeu
//
//  Created by Jonathan Lafleur on 03/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUpdateFrequency 60  // Hz
#define kFilteringFactor 0.1

@class BallHole,StyleSheetView,MenuView,EggFall,Player,Overlay;

@interface jeuViewController : UIViewController <UIAccelerometerDelegate>{
	
	int i;
	int nbPlayers;
	int nbPointsToWin;
	int totalNumberOfGames;
	int activePlayer;
	int activePlayerIterator;
	
	CGRect applicationFrame;
	
	UIAccelerationValue accelerationX;
    UIAccelerationValue accelerationY;
	
	BallHole *ballHole;
	StyleSheetView *styleSheetView;
    MenuView *menuView;
	EggFall *eggFall;
	Overlay *overlay;
	
	float firstCalibrationReading;
    float currentRawReading;
    float calibrationOffset;
	float time;
	
	BOOL _onGoingGame;
	
	NSTimer *timer;
	NSTimer *gameTransitionSynch;
	NSTimer *delayBeforeFlipToMenu;
	
	Player *players[12];
	Player *winner;
	Player *playerOrder[12];
	
	UIImageView *timerBar;
	UIImageView *wonView;
	UIImageView *failedView;
	UIImageView *activeGameView;
	
	NSString *selectedGameBtnString;
	NSString *colorCode[12];
}

@property (nonatomic, retain) MenuView *menuView;
@property (nonatomic, retain) NSString *selectedGameBtnString;
@property (nonatomic, assign) int nbPlayers;
@property (nonatomic, assign) BOOL _onGoingGame;
@property (nonatomic, assign) int nbPointsToWin;
@property (nonatomic, assign) int activePlayer;
@property (nonatomic, assign) CGRect applicationFrame;
@property (nonatomic, assign) Overlay *overlay;
@property (nonatomic, assign) int totalNumberOfGames;

- (void) updateGameInfoWithTotalTime:(float)timeToAdd Point:(BOOL) point;

@end

