//
//  playMenuView.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 30/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuController,AudioPlayer,AudioQueueObject;

@interface PlayMenuView : UIView {
	
	UIImage *playBtnImage;
	UIImageView *playMenuBackgroundImage;
	UIImageView *dropDownMenu;
	UIImageView *corners;
	UIImageView *buttonSelected;
	UIImageView *dropDownBtnSelected;
	
	UISlider *playerSlider;
    UISlider *pointSlider;
	
	UIButton *playBtn;
	UIButton *continueBtn;
	UIButton *backBtn;
	UIButton *dropDownAreaBtn;
	
	MenuController *viewController;
	
	NSTimer *timerDropDownMenu;
	
	BOOL dropDownHidden;
	BOOL dropDownTimer;
	
	AudioPlayer		*menuBtn;
}

@property (nonatomic, assign) MenuController *viewController;

- (void) hideDropDownMenu;
- (void) hideDelay;
- (void) showDropDownMenu;
- (id)initWithFrame:(CGRect)frame viewController:(MenuController *)aController;
- (void) toScoreBoardView;
- (void) toMainMenuView;
- (void) toScoreBoardViewStartGame;
- (void) playerSliderAction;
- (void) pointSliderAction;
- (void) playBtnDown;
- (void) backBtnDown;
- (void) continueBtnDown;

@end
