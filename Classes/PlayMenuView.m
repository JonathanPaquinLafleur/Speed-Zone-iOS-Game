//
//  playMenuView.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 30/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PlayMenuView.h"
#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "AudioQueueObject.h"
#import "AudioPlayer.h"

@implementation PlayMenuView

@synthesize viewController;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame viewController:(MenuController *)aController {
    self = [super initWithFrame:frame];
	if (self != nil) {
		self.viewController = aController;		
		
		self.backgroundColor = [UIColor clearColor];
		
		[viewController setNbPlayers:3];
		[viewController setNbPoints:3];
		
		playBtnImage = [UIImage imageNamed:@"StartButton.png"];
		
		playMenuBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlayMenuBackground.png"]];
		
		dropDownMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownMenu.png"]];
		dropDownMenu.alpha = 0.75;
		dropDownMenu.center = CGPointMake(353,240);
		
		CGRect backBtnFrame = CGRectMake(320,16,45,120);
		backBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(backBtnDown) selectorUp:@selector(toMainMenuView) frame:backBtnFrame imageNormal:[UIImage imageNamed:@"backButton.png"]];

		CGRect continueBtnFrame = CGRectMake(320,340,45,120);
		continueBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(continueBtnDown) selectorUp:@selector(toScoreBoardView) frame:continueBtnFrame imageNormal:[UIImage imageNamed:@"continueBtn.png"]];		
		
		CGRect dropDownAreaFrame = CGRectMake(255,0,65,480);
		dropDownAreaBtn = [viewController buttonWithTitle:nil target:self downSelector:@selector(showDropDownMenu) dragExitReleaseSelector:@selector(hideDelay) frame:dropDownAreaFrame];
		
		CGRect framePlayerSlider = CGRectMake(-27,198,480,96);
		playerSlider = [[UISlider alloc] initWithFrame:framePlayerSlider];
		[playerSlider addTarget:self action:@selector(playerSliderAction) forControlEvents:UIControlEventValueChanged];
		
		playerSlider.backgroundColor = [UIColor clearColor];	
		
		UIImage *playerStetchLeftTrack = [[UIImage imageNamed:@"PlayerSlidderPlayer.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0.0];
		UIImage *playerStetchRightTrack = [[UIImage imageNamed:@"PlayerSlidder.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0.0];
		
		[playerSlider setThumbImage: [UIImage imageNamed:@"SlidderBoutton.png"] forState:UIControlStateNormal];
		[playerSlider setMinimumTrackImage:playerStetchLeftTrack forState:UIControlStateNormal];
		[playerSlider setMaximumTrackImage:playerStetchRightTrack forState:UIControlStateNormal];
		
		playerSlider.minimumValue = 1.0;
		playerSlider.maximumValue = 12.0;
		playerSlider.continuous = YES;
		playerSlider.value = 3.6;
		
		[playerSlider setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90])];
		
		CGRect framePointSlider = CGRectMake(-146,213,480,68);
		pointSlider = [[UISlider alloc] initWithFrame:framePointSlider];
		[pointSlider addTarget:self action:@selector(pointSliderAction) forControlEvents:UIControlEventValueChanged];
		
		pointSlider.backgroundColor = [UIColor clearColor];	
		
		UIImage *pointStetchLeftTrack = [[UIImage imageNamed:@"PointSlidderPoint.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0.0];
		UIImage *pointStetchRightTrack = [[UIImage imageNamed:@"PointSlidder.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0.0];
		
		[pointSlider setThumbImage: [UIImage imageNamed:@"SlidderBoutton2.png"] forState:UIControlStateNormal];
		[pointSlider setMinimumTrackImage:pointStetchLeftTrack forState:UIControlStateNormal];
		[pointSlider setMaximumTrackImage:pointStetchRightTrack forState:UIControlStateNormal];
		
		pointSlider.minimumValue = 1.0;
		pointSlider.maximumValue = 12.0;
		pointSlider.continuous = YES;
		pointSlider.value = 3.5;
		
		[pointSlider setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90])];
		
		CGRect playBtnFrame = CGRectMake(5,120,50,240);
		playBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(playBtnDown) selectorUp:@selector(toScoreBoardViewStartGame) frame:playBtnFrame  imageNormal:playBtnImage];
		
		buttonSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buttonSelected.png"]];
		buttonSelected.alpha = 0;
		
		dropDownBtnSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownBtnSelected.png"]];
		dropDownBtnSelected.alpha = 0;
		
		corners = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corners.png"]];
		corners.alpha = 0;
		
		menuBtn = [[AudioPlayer alloc] initShortFXWithName:@"menu"];
		
		dropDownHidden = YES;
		
		[self addSubview:playMenuBackgroundImage];
		[self addSubview:playBtn];
		[self addSubview:playerSlider];
		[self addSubview:pointSlider];
		[self addSubview:dropDownMenu];
		[self addSubview:dropDownAreaBtn];
		[self addSubview:backBtn];
		[self addSubview:continueBtn];	
		[self addSubview:buttonSelected];
		[self addSubview:dropDownBtnSelected];
		[self addSubview:corners];
	}
    return self;
}

- (void)dealloc {
	[playBtn release];
	[backBtn release];
	[continueBtn release];
	[playerSlider release];
	[pointSlider release];
	[playMenuBackgroundImage release];
    [super dealloc];
}



- (void) toScoreBoardViewStartGame{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	buttonSelected.alpha = 0;
	[UIView commitAnimations];
	
	[self hideDropDownMenu];
	[viewController moveToLeftView:@"ScoreBoardViewStartGame"];
}

- (void) toScoreBoardView{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	dropDownBtnSelected.alpha = 0;
	[UIView commitAnimations];
	
	[self hideDropDownMenu];
	[viewController moveToLeftView:@"ScoreBoardView"];
}

- (void) toMainMenuView{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	dropDownBtnSelected.alpha = 0;
	[UIView commitAnimations];
	
	[self hideDropDownMenu];
	[viewController moveToRightView:@"MainMenuView"];
}

- (void) playerSliderAction{
	
	if(playerSlider.value <= 2.1 && playerSlider.value >= 1){
		playerSlider.value = 1.6;
		[viewController setNbPlayers:1];
	}
	if(playerSlider.value <= 3.1 && playerSlider.value >= 2.1){
		playerSlider.value = 2.6;
		[viewController setNbPlayers:2];
	}
	if(playerSlider.value <= 4 && playerSlider.value >= 3.1){
		playerSlider.value = 3.6;
	    [viewController setNbPlayers:3];
	}
	if(playerSlider.value <= 5 && playerSlider.value >= 4){
		playerSlider.value = 4.5;
		[viewController setNbPlayers:4];
	}
	if(playerSlider.value <= 5.8 && playerSlider.value >= 5){
		playerSlider.value = 5.4;
		[viewController setNbPlayers:5];
	}
	if(playerSlider.value <= 6.8 && playerSlider.value >= 5.8){
		playerSlider.value = 6.4;
		[viewController setNbPlayers:6];
	}
	if(playerSlider.value <= 7.8 && playerSlider.value >= 6.8){
		playerSlider.value = 7.3;
		[viewController setNbPlayers:7];
	}
	if(playerSlider.value <= 8.7 && playerSlider.value >= 7.8){
		playerSlider.value = 8.3;
		[viewController setNbPlayers:8];
	}
	if(playerSlider.value <= 9.6 && playerSlider.value >= 8.7){
		playerSlider.value = 9.3;
		[viewController setNbPlayers:9];
	}
	if(playerSlider.value <= 10.5 && playerSlider.value >= 9.6){
		playerSlider.value = 10.2;
		[viewController setNbPlayers:10];
	}
	if(playerSlider.value <= 11.5 && playerSlider.value >= 10.5){
		playerSlider.value = 11.1;
		[viewController setNbPlayers:11];
	}
	if(playerSlider.value <= 12 && playerSlider.value >= 11.5){
		playerSlider.value = 12;
		[viewController setNbPlayers:12];
	}
}

- (void) pointSliderAction{
	if(pointSlider.value <= 2.1 && pointSlider.value >= 1){
		pointSlider.value = 1.6;
	    [viewController setNbPoints:1];
	}
	if(pointSlider.value <= 3.1 && pointSlider.value >= 2.1){
		pointSlider.value = 2.6;
		[viewController setNbPoints:2];
	}
	if(pointSlider.value <= 3.9 && pointSlider.value >= 3.1){
		pointSlider.value = 3.5;
	    [viewController setNbPoints:3];
	}
	if(pointSlider.value <= 4.9 && pointSlider.value >= 3.9){
		pointSlider.value = 4.4;
		[viewController setNbPoints:4];
	}
	if(pointSlider.value <= 5.8 && pointSlider.value >= 4.9){
		pointSlider.value = 5.4;
		[viewController setNbPoints:5];
	}
	if(pointSlider.value <= 6.7 && pointSlider.value >= 5.8){
		pointSlider.value = 6.3;
		[viewController setNbPoints:6];
	}
	if(pointSlider.value <= 7.6 && pointSlider.value >= 6.7){
		pointSlider.value = 7.2;
		[viewController setNbPoints:7];
	}
	if(pointSlider.value <= 8.6 && pointSlider.value >= 7.6){
		pointSlider.value = 8.2;
		[viewController setNbPoints:8];
	}
	if(pointSlider.value <= 9.5 && pointSlider.value >= 8.6){
		pointSlider.value = 9.1;
		[viewController setNbPoints:9];
	}
	if(pointSlider.value <= 10.5 && pointSlider.value >= 9.5){
		pointSlider.value = 10;
		[viewController setNbPoints:10];
	}
	if(pointSlider.value <= 11.5 && pointSlider.value >= 10.5){
		pointSlider.value = 11;
		[viewController setNbPoints:11];
	}
	if(pointSlider.value <= 12 && pointSlider.value >= 11.5){
		pointSlider.value = 12;
		[viewController setNbPoints:12];
	}
}

- (void) showDropDownMenu{
	if(dropDownHidden){
    	dropDownHidden = NO;
		corners.alpha = 1;
		if([viewController onGoingPlay]){
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.2];
			dropDownMenu.center = CGPointMake(287,240);
			backBtn.center = CGPointMake(backBtn.center.x-60,backBtn.center.y);
			continueBtn.center = CGPointMake(continueBtn.center.x-60,continueBtn.center.y);
			[UIView commitAnimations];
		}else{
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.2];
			dropDownMenu.center = CGPointMake(287,240);
			backBtn.center = CGPointMake(backBtn.center.x-60,backBtn.center.y);
			[UIView commitAnimations];
		}
	}else {
		if(dropDownTimer == YES){	
			[timerDropDownMenu invalidate];
		    dropDownTimer = NO;
	    }
	}
}

- (void) hideDropDownMenu{
	if(dropDownTimer){
		dropDownTimer = NO;	
	    [timerDropDownMenu invalidate];
	}
	if(!dropDownHidden){
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		dropDownMenu.center = CGPointMake(353,240);
		backBtn.center = CGPointMake(backBtn.center.x+60,backBtn.center.y);
		dropDownBtnSelected.center = CGPointMake(dropDownBtnSelected.center.x+60,dropDownBtnSelected.center.y);
		if([viewController onGoingPlay]){
			continueBtn.center = CGPointMake(continueBtn.center.x+60,continueBtn.center.y);
		}else{
			if(continueBtn.center.x == 288){
				continueBtn.center = CGPointMake(continueBtn.center.x+60,continueBtn.center.y);
			}
		}
		[UIView commitAnimations];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0];
		[UIView setAnimationDelay:0.2];
		corners.alpha = 0;
		[UIView commitAnimations];
	    dropDownHidden = YES;
	}
}

-(void)hideDelay{
	dropDownTimer = YES;
    timerDropDownMenu = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector: @selector(hideDropDownMenu) userInfo: nil repeats:NO];
}
- (void) playBtnDown {
	[menuBtn playShortFX];
	buttonSelected.alpha = 1;
	buttonSelected.center = CGPointMake(28,242);
}
- (void) backBtnDown {
	[menuBtn playShortFX];
	[self showDropDownMenu];
	dropDownBtnSelected.alpha = 1;
	dropDownBtnSelected.center = CGPointMake(285,80);
}
- (void) continueBtnDown {
	[menuBtn playShortFX];
	[self showDropDownMenu];
	dropDownBtnSelected.alpha = 1;
	dropDownBtnSelected.center = CGPointMake(285,403);
}

@end
