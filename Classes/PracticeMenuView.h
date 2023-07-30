//
//  practiceMenuView.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 30/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuController,AudioPlayer,AudioQueueObject;

@interface PracticeMenuView : UIView {
	
	UIButton *holeGameBtn;
	UIButton *driverBtn;
	UIButton *eggFallBtn;
	UIButton *craneBtn;
	UIButton *cupsBtn;
	UIButton *calculBtn;
	UIButton *marathonBtn;
	UIButton *etchASketchBtn;
	UIButton *findMeBtn;
	UIButton *valveBtn;
	UIButton *colorMixBtn;
	UIButton *playBtn;
	UIButton *nextBtn;
	UIButton *backBtn;
	UIButton *dropDownAreaBtn;
	
	UIImageView *dropDownMenu;
	UIImageView *practiceBackground;
	UIImageView *corners;
	UIImageView *gameSelected;
	UIImageView *buttonSelected;
	UIImageView *dropDownBtnSelected;
	UIImage *playBtnImage;
	
	MenuController *viewController;
	
	NSTimer *timerDropDownMenu;
	NSTimer *timerStartBtn;
	
	NSString *gameName;
	
	BOOL dropDownHidden;
	BOOL dropDownTimer;
	BOOL startBtnTimer;
	
	int activePracticeMenu;
	int nextMenu;
	int firstLine;
	int secondLine;
	int nbMenu;
		
	AudioPlayer		*gameIntro;
	AudioPlayer		*menuBtn;
	AudioPlayer		*logo;

}

@property (nonatomic, assign) MenuController *viewController;

- (id) initWithFrame:(CGRect)frame viewController:(MenuController *)aController;
- (void) previousMenu;
- (void) nextMenu;
- (void) toBallHole;
- (void) toEggFall;
- (void) toDriver;
- (void) toCups;
- (void) toCrane;
- (void) toCalcul;
- (void) toMarathon;
- (void) toEtchASketch;
- (void) toFindMe;
- (void) toValve;
- (void) toColorMix;
- (void) showDropDownMenu;
- (void) hideDropDownMenu;
- (void) hideDelay;
- (void) startGame;
- (void) initPracticeMenu;
- (void) startBtnAnimationLoop;
- (void) startBtnAnimation;
- (void) stopBtnAnimation;
- (void) playBtnDown;
- (void) backBtnDown;
- (void) nextBtnDown;

@end
