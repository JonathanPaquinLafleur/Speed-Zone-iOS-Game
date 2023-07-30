//
//  PracticeMenuView.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 30/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PracticeMenuView.h"
#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "AudioQueueObject.h"
#import "AudioPlayer.h"

@implementation PracticeMenuView

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame viewController:(MenuController *)aController {
    self = [super initWithFrame:frame];
	if (self != nil) {
		self.viewController = aController;		
		
		self.backgroundColor = [UIColor clearColor];
		
		practiceBackground  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PracticeMenuBackground.png"]];
		[self addSubview:practiceBackground];
		
		CGRect playBtnFrame = CGRectMake(5,120,50,240);
		playBtnImage = [UIImage imageNamed:@"StartButton.png"];
		playBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(playBtnDown) selectorUp:@selector(startGame) frame:playBtnFrame  imageNormal:playBtnImage];
	    [self addSubview:playBtn];	
		
		//Games
		UIImage *holeGameBtnImage = [UIImage imageNamed:@"holeGameBtn.png"];
		CGRect holeGameBtnFrame = CGRectMake(firstLine,(480/5.5)-23,74,74);
		holeGameBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toBallHole) frame:holeGameBtnFrame  imageNormal:holeGameBtnImage];
		[self addSubview:holeGameBtn];
		
		UIImage *eggFallBtnImage = [UIImage imageNamed:@"eggFallBtn.png"];
		CGRect eggFallBtnFrame = CGRectMake(firstLine,((480/5.5)*2)-23,74,74);
		eggFallBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toEggFall) frame:eggFallBtnFrame  imageNormal:eggFallBtnImage];
		[self addSubview:eggFallBtn];
		
		UIImage *driverBtnImage = [UIImage imageNamed:@"driverBtn.png"];
		CGRect driverBtnFrame = CGRectMake(firstLine,((480/5.5)*3)-23,74,74);
		driverBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toDriver) frame:driverBtnFrame  imageNormal:driverBtnImage];
		[self addSubview:driverBtn];
		
		UIImage *craneBtnImage = [UIImage imageNamed:@"craneBtn.png"];
		CGRect craneBtnFrame = CGRectMake(firstLine,((480/5.5)*4)-23,74,74);
		craneBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toCrane) frame:craneBtnFrame  imageNormal:craneBtnImage];
		[self addSubview:craneBtn];
		
		UIImage *cupsBtnImage = [UIImage imageNamed:@"cupsBtn.png"];
		CGRect cupsBtnFrame = CGRectMake(firstLine,((480/5.5)*5)-23,74,74);
		cupsBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toCups) frame:cupsBtnFrame  imageNormal:cupsBtnImage];
		[self addSubview:cupsBtn];
		
		UIImage *calculBtnImage = [UIImage imageNamed:@"calculBtn.png"];
		CGRect calculBtnFrame = CGRectMake(secondLine,(480/5.5)-23,74,74);
		calculBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toCalcul) frame:calculBtnFrame  imageNormal:calculBtnImage];
		[self addSubview:calculBtn];
		
		UIImage *marathonBtnImage = [UIImage imageNamed:@"marathonBtn.png"];
		CGRect marathonBtnFrame = CGRectMake(secondLine,((480/5.5)*2)-23,74,74);
		marathonBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toMarathon) frame:marathonBtnFrame  imageNormal:marathonBtnImage];
		[self addSubview:marathonBtn];
		
		UIImage *etchASketchBtnImage = [UIImage imageNamed:@"etchasketchBtn.png"];
		CGRect etchASketchBtnFrame = CGRectMake(secondLine,((480/5.5)*3)-23,74,74);
		etchASketchBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toEtchASketch) frame:etchASketchBtnFrame  imageNormal:etchASketchBtnImage];
		[self addSubview:etchASketchBtn];
		
		UIImage *findMeBtnImage = [UIImage imageNamed:@"findMeBtn.png"];
		CGRect findMeBtnFrame = CGRectMake(secondLine,((480/5.5)*4)-23,74,74);
		findMeBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toFindMe) frame:findMeBtnFrame  imageNormal:findMeBtnImage];
		[self addSubview:findMeBtn];
		
		UIImage *valveBtnImage = [UIImage imageNamed:@"valveBtn.png"];
		CGRect valveBtnFrame = CGRectMake(secondLine,((480/5.5)*5)-23,74,74);
		valveBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toValve) frame:valveBtnFrame  imageNormal:valveBtnImage];
		[self addSubview:valveBtn];
		
		UIImage *colorMixBtnImage = [UIImage imageNamed:@"colorMixBtn.png"];
		CGRect colorMixBtnFrame = CGRectMake(secondLine,(480/5.5)-23,74,74);
		colorMixBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toColorMix) frame:colorMixBtnFrame  imageNormal:colorMixBtnImage];
		[self addSubview:colorMixBtn];
		
		CGRect dropDownAreaFrame = CGRectMake(255,0,65,480);
		dropDownAreaBtn = [viewController buttonWithTitle:nil target:self downSelector:@selector(showDropDownMenu) dragExitReleaseSelector:@selector(hideDelay) frame:dropDownAreaFrame];
		[self addSubview:dropDownAreaBtn];
		
		dropDownMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownMenu.png"]];
		dropDownMenu.alpha = 0.75;
		dropDownMenu.center = CGPointMake(353,240);
		[self addSubview:dropDownMenu];
		
		CGRect backBtnFrame = CGRectMake(320,16,45,120);
		backBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(backBtnDown) selectorUp:@selector(previousMenu) frame:backBtnFrame imageNormal:[UIImage imageNamed:@"backButton.png"]];
		[self addSubview:backBtn];
		
		CGRect nextBtnFrame = CGRectMake(320,340,45,120);
		nextBtn = [viewController buttonWithTitle:nil target:self selectorDown:@selector(nextBtnDown) selectorUp:@selector(nextMenu) frame:nextBtnFrame imageNormal:[UIImage imageNamed:@"nextBtn.png"]];		
		[self addSubview:nextBtn];
		
		corners = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corners.png"]];
		[self addSubview:corners];
		corners.alpha = 0;
		
		gameSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameSelected.png"]];
		[self addSubview:gameSelected];
		gameSelected.center = CGPointMake(500,500);
		
		buttonSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buttonSelected.png"]];
		buttonSelected.alpha = 0;
		[self addSubview:buttonSelected];
		
		dropDownBtnSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownBtnSelected.png"]];
		dropDownBtnSelected.alpha = 0;
		[self addSubview:dropDownBtnSelected];
		
		menuBtn = [[AudioPlayer alloc] initShortFXWithName:@"menu"];
		logo = [[AudioPlayer alloc] initShortFXWithName:@"Logo"];
			
		firstLine = 200;
		secondLine = 115;
		nextMenu = 1;
		nbMenu = 2;
		dropDownHidden = YES;
		
    }
    return self;
}

- (void)dealloc {
	[backBtn release];
	[nextBtn release];
	[colorMixBtn release];
	[valveBtn release];
	[findMeBtn release];
	[etchASketchBtn release];
	[holeGameBtn release];
	[eggFallBtn release];
	[marathonBtn release];
	[calculBtn release];
	[cupsBtn release];
	[craneBtn release];
	[driverBtn release];
	[dropDownMenu release];
	[dropDownAreaBtn release];
	[practiceBackground release];
	[gameSelected release];
    [super dealloc];
}

- (void) showDropDownMenu{
	if(dropDownHidden){
		corners.alpha = 1;
		dropDownHidden = NO;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.2];
			dropDownMenu.center = CGPointMake(287,240);
			backBtn.center = CGPointMake(backBtn.center.x-60,backBtn.center.y);
		    if(activePracticeMenu != nbMenu){
				nextBtn.center = CGPointMake(nextBtn.center.x-60,nextBtn.center.y);
	    	}
			[UIView commitAnimations];
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
			if(activePracticeMenu != nbMenu){
				nextBtn.center = CGPointMake(nextBtn.center.x+60,nextBtn.center.y);
			}
			[UIView commitAnimations];
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0];
	    	[UIView setAnimationDelay:0.2];
		    corners.alpha = 0;
			[UIView commitAnimations];
	}
	dropDownHidden = YES;
}

-(void)hideDelay{
	dropDownTimer = YES;
    timerDropDownMenu = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector: @selector(hideDropDownMenu) userInfo: nil repeats:NO];
}

- (void)previousMenu{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	dropDownBtnSelected.alpha = 0;
	[UIView commitAnimations];
	
    [self stopBtnAnimation];
	if(activePracticeMenu != 1){
		nextMenu = activePracticeMenu - 1;
		[viewController moveToRightView:@"PracticeMenuView"];
	}else{
		[viewController moveToRightView:@"MainMenuView"];
	}
	[self hideDropDownMenu];
}

- (void)nextMenu{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	dropDownBtnSelected.alpha = 0;
	[UIView commitAnimations];
	
    [self stopBtnAnimation];
	nextMenu = activePracticeMenu +1;
	[self hideDropDownMenu];
	[viewController moveToLeftView:@"PracticeMenuView"];
}

- (void) toColorMix{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(firstLine-1,(480/5.5)-23);
	[self startBtnAnimationLoop];
	gameName = @"colorMix";
}

- (void) toValve{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(secondLine-1,((480/5.5)*5)-23);
	[self startBtnAnimationLoop];
	gameName = @"valve";
}

- (void) toFindMe{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(secondLine-1,((480/5.5)*4)-23);
	[self startBtnAnimationLoop];
	gameName = @"findMe";
}

- (void) toEtchASketch{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(secondLine-1,((480/5.5)*3)-23);
	[self startBtnAnimationLoop];
	gameName = @"etchASketch";
}

- (void) toMarathon{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(secondLine-1,((480/5.5)*2)-23);
	[self startBtnAnimationLoop];
	gameName = @"marathon";
}

- (void) toCalcul{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(secondLine-1,(480/5.5)-23);
	[self startBtnAnimationLoop];
	gameName = @"calcul";
}

- (void) toCups{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(firstLine-1,((480/5.5)*5)-23);
	[self startBtnAnimationLoop];
	gameName = @"cups";
}

- (void) toCrane{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(firstLine-1,((480/5.5)*4)-23);
	[self startBtnAnimationLoop];
	gameName = @"crane";
}

- (void) toDriver{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(firstLine-1,((480/5.5)*3)-23);
	[self startBtnAnimationLoop];
	gameName = @"driver";
}

- (void)toEggFall{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(firstLine-1,((480/5.5)*2)-23);
	[self startBtnAnimationLoop];
	gameName = @"eggFall";
}

- (void)toBallHole{
	[menuBtn playShortFX];
	gameSelected.center = CGPointMake(firstLine-1,(480/5.5)-23);
	[self startBtnAnimationLoop];
	gameName = @"ballHole";
}

- (void)startGame{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	buttonSelected.alpha = 0;
	[UIView commitAnimations];
	
	[self hideDropDownMenu];
	if(gameName != @"none"){
		[logo playShortFX];
		[gameIntro setAudioVolume:0.5];
		[gameIntro play];
		[viewController startGameWithName:gameName];
	}
}

- (void) initPracticeMenu {
	
	activePracticeMenu = nextMenu;
    startBtnTimer = NO;
	gameName = @"none";
	
	holeGameBtn.center = CGPointMake(370,500);
	eggFallBtn.center = CGPointMake(370,500);
	driverBtn.center = CGPointMake(370,500);
	craneBtn.center = CGPointMake(370,500);
	cupsBtn.center = CGPointMake(370,500);
	calculBtn.center = CGPointMake(370,500);
	marathonBtn.center = CGPointMake(370,500);
	etchASketchBtn.center = CGPointMake(370,500);
	findMeBtn.center = CGPointMake(370,500);
	valveBtn.center = CGPointMake(370,500);
	colorMixBtn.center = CGPointMake(370,500);
	
	if(activePracticeMenu == 1){
		holeGameBtn.center = CGPointMake(firstLine,(480/5.5)-23);
		eggFallBtn.center = CGPointMake(firstLine,((480/5.5)*2)-23);
		driverBtn.center = CGPointMake(firstLine,((480/5.5)*3)-23);
		craneBtn.center = CGPointMake(firstLine,((480/5.5)*4)-23);
		cupsBtn.center = CGPointMake(firstLine,((480/5.5)*5)-23);
		calculBtn.center = CGPointMake(secondLine,(480/5.5)-23);
		marathonBtn.center = CGPointMake(secondLine,((480/5.5)*2)-23);
		etchASketchBtn.center = CGPointMake(secondLine,((480/5.5)*3)-23);
		findMeBtn.center = CGPointMake(secondLine,((480/5.5)*4)-23);
		valveBtn.center = CGPointMake(secondLine,((480/5.5)*5)-23);
	}
	if(activePracticeMenu == 2){
		colorMixBtn.center = CGPointMake(firstLine,(480/5.5)-23);
	}
}

- (void) startBtnAnimationLoop {
	gameSelected.alpha = 1;
	if(!startBtnTimer){
		startBtnTimer = YES;
		timerStartBtn = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(startBtnAnimation) userInfo:nil repeats:YES];
	}
}

- (void) startBtnAnimation {	
	CABasicAnimation *scaleXAnimation = [CABasicAnimation animation];
    scaleXAnimation.keyPath = @"transform.scale.x";
    scaleXAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleXAnimation.toValue = [NSNumber numberWithFloat:0.96];
    scaleXAnimation.duration = 0.5;
    scaleXAnimation.repeatCount = 0;
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleXAnimation.autoreverses = YES;
    [playBtn.layer addAnimation:scaleXAnimation forKey:@"scale.x"];
	[buttonSelected.layer addAnimation:scaleXAnimation forKey:@"scale.x"];
	CABasicAnimation *scaleYAnimation = [CABasicAnimation animation];
    scaleYAnimation.keyPath = @"transform.scale.y";
    scaleYAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleYAnimation.toValue = [NSNumber numberWithFloat:0.96];
    scaleYAnimation.duration = 0.5;
    scaleYAnimation.repeatCount = 0;
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleYAnimation.autoreverses = YES;
    [playBtn.layer addAnimation:scaleYAnimation forKey:@"scale.y"];
	[buttonSelected.layer addAnimation:scaleYAnimation forKey:@"scale.y"];
}

- (void) stopBtnAnimation {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	gameSelected.alpha = 0;
	[UIView commitAnimations];
	
	[playBtn setTransform:CGAffineTransformMakeScale(1,1)];
	if(startBtnTimer){
		startBtnTimer = NO;
		[timerStartBtn invalidate];
	}
}

- (void) playBtnDown {
	if(gameName != @"none"){
		[menuBtn playShortFX];
		buttonSelected.alpha = 1;
		buttonSelected.center = CGPointMake(28,242);
	}
}
- (void) backBtnDown {
	[menuBtn playShortFX];
	[self showDropDownMenu];
	dropDownBtnSelected.alpha = 1;
	dropDownBtnSelected.center = CGPointMake(285,80);
}
- (void) nextBtnDown {
	[menuBtn playShortFX];
	[self showDropDownMenu];
	dropDownBtnSelected.alpha = 1;
	dropDownBtnSelected.center = CGPointMake(285,403);
}

@end
