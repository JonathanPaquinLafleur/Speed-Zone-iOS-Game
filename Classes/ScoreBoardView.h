//
//  ScoreBoardMenuView.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 06/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScoreBoardController,Player;

@interface ScoreBoardView : UIView {

	int i;
	int bringPlayerAnimationIterator;
	int index;
	
	ScoreBoardController *viewController;
	
	Player *winningPlayer;
	
	NSTimer *timerDropDownMenu;
	NSTimer *timerTapWhenReadyAnimation;
	NSTimer *timerPlayerMotion;
	NSTimer *rippleAnimationDelay;
	
	BOOL dropDownHidden;
	BOOL dropDownTimer;
	BOOL tapWhenReadyAnimation;
	BOOL playerMotionActive;
	
	UIButton *backBtn;
	UIButton *dropDownAreaBtn;
	
	UIImageView *dropDownMenu;
	UIImageView *winnerBackground;
	UIImageView *tapWhenReadyImg;
	UIImageView *rippleImg;
	UIImageView *fingerImg;
	UIImageView *corners;
	UIImageView *dropDownBtnSelected;
	UIImageView *dropDownBtnSelectedNO;

}

@property (nonatomic, assign) ScoreBoardController *viewController;
@property (nonatomic, assign) int index;

- (void) hideDropDownMenu;
- (void) hideDelay;
- (void) showDropDownMenu;
- (void) showScoreBoard;
- (void) showPlayers;
- (void) bringPlayerAnimation;
- (void) hideNonWinningPlayers:(Player *) winner;
- (void) hideWinnerBackground;
- (void) startPlayerMotionWithIndex:(int) _index;
- (void) startTapWhenReadyAnimation;
- (void) startTapWhenReady;
- (void) stopTapWhenReady;
- (void) showWinnerWithPlayer:(Player *) _winningPlayer;
- (void) stopPlayerMotionWhiteFade:(BOOL) playWhiteFade;
- (void) moveWinner;
- (void) playerMotion;
- (void) rippleAnimation;
- (void) showBackBtnDown;
- (void) hideDropDownBtnSelected;
- (void) hideDropDownBtnSelectedNO;
- (void) showBackBtnDownNO;

@end
