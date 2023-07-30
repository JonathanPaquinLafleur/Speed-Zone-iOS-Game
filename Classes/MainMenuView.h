//
//  MainMenuView.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuController,AudioPlayer,AudioQueueObject;

@interface MainMenuView : UIView {
	
	UIImage *practiceBtnImage;
	UIImage *playBtnImage;
	
	UIImageView *title;
	UIImageView *buttonSelected;
	
	UIButton *practiceBtn;
	UIButton *playBtn;
	
	MenuController *viewController;
	
	NSTimer *titleScaleTimer;
	
	AudioPlayer		*backgroundLoop;
	AudioPlayer		*menuBtn;

}

@property (nonatomic, assign) MenuController *viewController;
@property (nonatomic, assign) AudioPlayer *backgroundLoop;

- (id) initWithFrame:(CGRect)frame viewController:(MenuController *)aController;
- (void) initAnimation;
- (void) toPracticeMenu;
- (void) titleScaleAnimation;
- (void) toPlayMenu;
- (void) startTitleScaleAnimation;
- (void) stopTitleScaleAnimation;
- (void) playBtnDown;
- (void) practiceBtnDown;

@end
