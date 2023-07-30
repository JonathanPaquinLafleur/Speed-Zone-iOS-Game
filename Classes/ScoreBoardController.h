//
//  ScoreBoardController.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 06/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player,SpeedZoneAppDelegate,ScoreBoardView,GameController,MenuController,AudioPlayer,AudioQueueObject;

@interface ScoreBoardController : UIViewController {

	BOOL onGoingGame;
	BOOL onGoingPlay;
	BOOL winner;
	BOOL addPoint;
	BOOL inTransition;
	BOOL updateDone;
	BOOL activateDropDownMenuArea;
	
	IBOutlet UIWindow *window;
	
	SpeedZoneAppDelegate *appDel;
	
	CGRect applicationFrame;
	
	ScoreBoardView *scoreBoardView;
	GameController *gameController;
	MenuController *menuController;
	
	int i;
	int colorCodeNewTmp;	
	int colorCodeOldTmp;
	int activePlayerIterator;
	int readjustScoreBoardIterator;
	int tmpActivePlayerIterator;
	int nbPointsToWin;
	int nbPlayers;
	int totalNbOfGames;
	
	float playerXTmp;
	float playerYTmp;
	
	Player *players[12];
	Player *winningPlayer;
	Player *playerTmp;

	NSString *colorCode[12];
	
	NSTimer *bringPlayersSynch;
	NSTimer *readjustPlayersSynch;
	
	UIImageView *backgroundImg;
	
	UIImageView *whiteFade;
	
	AudioPlayer		*gameIntro;
	AudioPlayer		*menuBtn;
}
@property (nonatomic, assign) int nbPlayers;
@property (nonatomic, assign) Player *winningPlayer;
@property (nonatomic, assign) BOOL onGoingGame;
@property (nonatomic, assign) int nbPointsToWin;
@property (nonatomic, assign) BOOL addPoint;
@property (nonatomic, assign) int totalNbOfGames;
@property (nonatomic, assign) BOOL onGoingPlay;
@property (nonatomic, assign) BOOL updateDone;
@property (nonatomic, assign) BOOL activateDropDownMenuArea;
@property (nonatomic, assign) NSTimer *bringPlayersSynch;

- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window withGameController:(GameController *) _gameController withMenuController:(MenuController *) _menuController;
- (void) startGameWithNbPlayers:(int) _nbPlayers withNbPointsToWin:(int) _nbPointsToWin;
- (void) scrambleColorCode;
- (Player *) players:(int)index;
- (void) updateGameInfoWithTotalTime:(float)timeToAdd Point:(BOOL) point;
- (void) whiteFadeIn;
- (void) moveToRightView;
- (void) moveToLeftView;
- (void) whiteFadeOut;
- (void) switchPlayer1:(Player *)player1 withPlayer2:(Player *) player2;
- (void) readjustScoreBoardWithPoint;
- (void) readjustScoreBoardWithoutPoint;
- (void) updateGameState;
- (void) movePlayers;
- (void) backBtnDown;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selectorDown:(SEL)inSelectorDown selectorUp:(SEL)inSelectorUp frame:(CGRect)frame imageNormal:(UIImage*)imageNormal;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target downSelector:(SEL)downSelector dragExitReleaseSelector:(SEL)dragExitReleaseSelector frame:(CGRect)frame;

@end
