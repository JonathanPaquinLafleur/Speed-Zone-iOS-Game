//
//  MenuView.h
//  jeu
//
//  Created by Jonathan Lafleur on 10/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class jeuViewController,BallHole,StyleSheetView,Player;

@interface MenuView : UIView {

	jeuViewController *viewController;
	
	NSTimer *timer;
	NSTimer *scoreBoardTimer;
	
	unsigned i;
	
	int iterator;
	
	BOOL _practiceBtnSelected;
	BOOL _playBtnSelected;
	BOOL _practiceBackBtnSelected;
	BOOL _practiceNextBtnSelected;
	BOOL _gameStarted;
	BOOL _gameBtnSelected;
	BOOL _startBtnSelected;
	BOOL _scoreBoardShowing;
	
	UIButton *practiceBtn;
	UIButton *playBtn;
	UIButton *startBtn;
	UIButton *holeGameBtn;
	UIButton *eggFallBtn;

	UIImageView *title;
	UIImageView *practiceTitle;
	UIImageView *practiceBackground;
	UIImageView *selectedGameBtn;
	UIImageView *neon;
	
	UISlider *nbPlayerSlider;
	
	NSString *activeMenu;

}

@property (nonatomic, assign) jeuViewController *viewController;
@property (nonatomic, assign) BOOL _gameStarted;
@property (nonatomic, assign) BOOL _scoreBoardShowing;

- (id) initWithFrame:(CGRect)frame viewController:(jeuViewController *)aController;
- (void) setupSubviews;
- (void) moveToPracticeMenu;
- (void) moveToPlayMenu;
- (void) moveBack;
- (void) moveNext;
- (void) displaySelectedGameWithGameName:(NSString*) gameName;
- (void) hideSelectedGame;
- (void) selectedGameBtnHoleGame;
- (void) selectedGameBtnEggFall;
- (void) startPlayerMotionWithIndex:(int)index;
- (void) stopPlayerMotionWithIndex:(int)index;
- (void) showWinnerWithPlayer:(Player *)winnerPlayer;

@end
