//
//  MenuController.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainMenuView,PracticeMenuView,PlayMenuView,SpeedZoneAppDelegate,ScoreBoardController,AudioPlayer,AudioQueueObject;

@interface MenuController : UIViewController {

	int introAnimationSequence;
	int nbPlayers;
	int nbPoints;
	
	UIView *activeView;
	
	NSString *nextMenu;
	NSString *gameToStart;
	
	UIImageView *backgroundImg;
	UIImageView *whiteFade;
	
	SpeedZoneAppDelegate *appDel;
	MainMenuView *mainMenuView;
	ScoreBoardController *scoreBoardController;
	PlayMenuView *playMenuView;
	PracticeMenuView *practiceMenuView;
	
	NSTimer *introAnimationTimer;
	NSTimer *dropDownDelay;
	
	IBOutlet UIWindow *window;
	
}

@property (nonatomic, assign) int         nbPlayers;
@property (nonatomic, assign) int         nbPoints;
@property (nonatomic, assign) UIView      *activeView;
@property (nonatomic, assign) NSString    *nextMenu;
@property (nonatomic, assign) MainMenuView *mainMenuView;

- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window ;
- (void) moveToLeftView:(NSString *) view;
- (void) moveToRightView:(NSString *) view;
- (void) moveInsideFromRight;
- (void) moveInsideFromLeft;
- (void) showMenuWithName:(NSString *) menuName;
- (void) startGameWithName:(NSString *) gameName;
- (void) whiteFadeIn;
- (void) whiteFadeOut;
- (void) moveInsideFromRightPlayMenu;
- (BOOL) onGoingPlay;
- (void) pauseBackgroundLoop;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selectorDown:(SEL)inSelectorDown selectorUp:(SEL)inSelectorUp frame:(CGRect)frame imageNormal:(UIImage*)imageNormal;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame imageNormal:(UIImage*)imageNormal;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target downSelector:(SEL)downSelector dragExitReleaseSelector:(SEL)dragExitReleaseSelector frame:(CGRect)frame;

@end
