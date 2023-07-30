//
//  MenuController.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MenuController.h"
#import "MainMenuView.h"
#import "PracticeMenuView.h"
#import "PlayMenuView.h"
#import "SpeedZoneAppDelegate.h"
#import "ScoreBoardView.h"
#import "ScoreBoardController.h"
#import <QuartzCore/QuartzCore.h>
#import "AudioQueueObject.h"
#import "AudioPlayer.h"

@implementation MenuController

@synthesize nbPlayers;
@synthesize nbPoints;
@synthesize activeView;
@synthesize nextMenu;
@synthesize mainMenuView;

- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window {
	if (self = [super init]) {	
		
		window = _window;
		
		appDel = _appDel;
		
		CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
		
		backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
		backgroundImg.alpha = 0;
		
		scoreBoardController = [appDel scoreBoardController] ;
		
		mainMenuView = [[MainMenuView alloc] initWithFrame:applicationFrame viewController:self];

		practiceMenuView = [[PracticeMenuView alloc] initWithFrame:applicationFrame viewController:self];
		
		playMenuView = [[PlayMenuView alloc] initWithFrame:applicationFrame viewController:self];
		
		whiteFade = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteFade.png"]];
		whiteFade.alpha = 0;

	}
		
	return self;
}

- (BOOL) onGoingPlay {
   return [appDel onGoingPlay];	
}

- (void) showMenuWithName:(NSString *) menuName {
	[self.view addSubview:backgroundImg];
	[window addSubview:self.view];
	[window bringSubviewToFront:self.view];
	if(menuName == @"MainMenuView") {
		introAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector: @selector(initAnimation) userInfo: nil repeats:YES];
	}
	if(menuName == @"PracticeMenuView") {
		[self whiteFadeIn];
		[self.view addSubview:practiceMenuView];
		activeView = practiceMenuView;
	}

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
	[whiteFade release];
	[mainMenuView release];
	[practiceMenuView release];
	[playMenuView release];
	[introAnimationTimer release];
	[backgroundImg release];
    [super dealloc];
}

- (void) moveToLeftView:(NSString *) view {
	
	[UIView beginAnimations:@"disapearingMenuToLeft" context:NULL];
    [UIView setAnimationDuration:0.5];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationDelegate:self];
	activeView.center =  CGPointMake(activeView.center.x,activeView.center.y - 480);
	[UIView commitAnimations];

	nextMenu = view;
}

- (void) moveToRightView:(NSString *) view {	
	[UIView beginAnimations:@"disapearingMenuToRight" context:NULL];
    [UIView setAnimationDuration:0.5];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationDelegate:self];
	activeView.center =  CGPointMake(activeView.center.x,activeView.center.y + 480);
	[UIView commitAnimations];
	
	nextMenu = view;
}

- (void) moveInsideFromLeft {
	
	activeView.center =  CGPointMake(activeView.center.x,720);
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
	activeView.center =  CGPointMake(activeView.center.x,activeView.center.y - 480);
	[UIView commitAnimations];
		
}

- (void) moveInsideFromRight {	
	
	activeView.center =  CGPointMake(activeView.center.x,-480);
	
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
	activeView.center =  CGPointMake(activeView.center.x,activeView.center.y + 720);
	[UIView commitAnimations];

}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	if(theAnimation == @"whiteFadeOut") {
		[whiteFade removeFromSuperview];
		[self.view removeFromSuperview];
		[appDel startGameWithName:gameToStart];
	}
	if(theAnimation == @"whiteFadeIn") {
		[whiteFade removeFromSuperview];
	}
	
	if(theAnimation == @"disapearingMenuToLeft" || theAnimation == @"disapearingMenuToRight") {
		[activeView removeFromSuperview];

		if(nextMenu == @"MainMenuView") {
			[mainMenuView startTitleScaleAnimation];
            [self.view addSubview:mainMenuView];
			activeView = mainMenuView;
		}
		if(nextMenu == @"PracticeMenuView") {
			[self.view addSubview:practiceMenuView];
			[practiceMenuView initPracticeMenu];
			dropDownDelay = [NSTimer scheduledTimerWithTimeInterval:0.5 target:practiceMenuView selector: @selector(showDropDownMenu) userInfo: nil repeats:NO];
			[practiceMenuView hideDelay];
			activeView = practiceMenuView;
		}
		if(nextMenu == @"PlayMenuView") {
			[self.view addSubview:playMenuView];
			dropDownDelay = [NSTimer scheduledTimerWithTimeInterval:0.5 target:playMenuView selector: @selector(showDropDownMenu) userInfo: nil repeats:NO];
			[playMenuView hideDelay];
			activeView = playMenuView;
		}
		if(nextMenu == @"ScoreBoardViewStartGame") {
			[self.view removeFromSuperview];
			[appDel initScoreBoardWithNbPlayers:nbPlayers withNbPointsToWin:nbPoints];
		}
		if(nextMenu == @"ScoreBoardView") {
			[self.view removeFromSuperview];
			[appDel moveToLeftScoreBoard];
		}
		if(theAnimation == @"disapearingMenuToLeft") {
			[self moveInsideFromLeft];
		}
		if(theAnimation == @"disapearingMenuToRight") {
			[self moveInsideFromRight];
		}
	}
}

- (void) moveInsideFromRightPlayMenu{
	
	[window addSubview:self.view];
	[window bringSubviewToFront:self.view];
	[self.view addSubview:playMenuView];
	activeView = playMenuView;
	[self moveInsideFromRight];
}

- (void) initAnimation {
	
	if(introAnimationSequence == 0){
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1.5];
		backgroundImg.alpha = 1;
		[UIView commitAnimations];
	}
	if(introAnimationSequence == 1){
		[self.view addSubview:mainMenuView];		
		[mainMenuView initAnimation];
		activeView = mainMenuView;
	}
	if(introAnimationSequence == 2){
		[introAnimationTimer invalidate];
		introAnimationTimer = 0;
	}
	introAnimationSequence = ++introAnimationSequence;
	
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selectorDown:(SEL)inSelectorDown selectorUp:(SEL)inSelectorUp frame:(CGRect)frame imageNormal:(UIImage*)imageNormal{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	UIImage *newImageNormal = [imageNormal stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	[button setImage:newImageNormal forState:UIControlStateNormal];
	[button addTarget:target action:inSelectorDown forControlEvents:UIControlEventTouchDown];
	[button addTarget:target action:inSelectorUp forControlEvents:UIControlEventTouchUpOutside];
	[button addTarget:target action:inSelectorUp forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundColor:[UIColor clearColor]];	// in case the parent view draws with a custom color or gradient, use a transparent color
    [button setAdjustsImageWhenHighlighted:NO];
	[button autorelease];
    return button;
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame imageNormal:(UIImage*)imageNormal{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	UIImage *newImageNormal = [imageNormal stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	[button setImage:newImageNormal forState:UIControlStateNormal];
	[button addTarget:target action:inSelector forControlEvents:UIControlEventTouchDown];
	[button setBackgroundColor:[UIColor clearColor]];	// in case the parent view draws with a custom color or gradient, use a transparent color
    [button setAdjustsImageWhenHighlighted:NO];
	[button autorelease];
    return button;
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target downSelector:(SEL)downSelector dragExitReleaseSelector:(SEL)dragExitReleaseSelector  frame:(CGRect)frame {
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[button addTarget:target action:downSelector forControlEvents:UIControlEventTouchDown];
	[button addTarget:target action:dragExitReleaseSelector forControlEvents:UIControlEventTouchDragExit];
	[button addTarget:target action:dragExitReleaseSelector forControlEvents:UIControlEventTouchUpInside];
	[button setBackgroundColor:[UIColor clearColor]];	
    [button setAdjustsImageWhenHighlighted:NO];
	[button autorelease];
    return button;
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector  frame:(CGRect)frame {
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[button addTarget:target action:inSelector forControlEvents:UIControlEventTouchDown];
	[button setBackgroundColor:[UIColor clearColor]];	
    [button setAdjustsImageWhenHighlighted:NO];
	[button autorelease];
    return button;
}

- (void) startGameWithName:(NSString *) gameName {
	[self whiteFadeOut];
	gameToStart = gameName;
}

- (void) whiteFadeIn {
	
	[[mainMenuView backgroundLoop] setAudioVolume:0.0];
	[[mainMenuView backgroundLoop] playFadeInIsLooping:YES Delay:0.0 Duration:1.0 ToVolume:0.5];
	
	[self.view addSubview:whiteFade];
	[UIView beginAnimations:@"whiteFadeIn" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 0;
	[UIView commitAnimations];	
}

- (void) whiteFadeOut {
	
	[[mainMenuView backgroundLoop] pauseFadeOutWithDelay:0.0 Duration:1.6];
	
	[self.view addSubview:whiteFade];
	[UIView beginAnimations:@"whiteFadeOut" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 1;
	[UIView commitAnimations];	
}

@end
