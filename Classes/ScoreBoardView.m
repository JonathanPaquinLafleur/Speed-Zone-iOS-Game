//
//  ScoreBoardMenuView.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 06/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ScoreBoardView.h"
#import "ScoreBoardController.h"
#import <QuartzCore/QuartzCore.h>
#import "Player.h"

@implementation ScoreBoardView

@synthesize viewController;
@synthesize index;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame viewController:(ScoreBoardController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		tapWhenReadyImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tapwhenready.png"]];
		tapWhenReadyImg.alpha = 0;
		tapWhenReadyImg.center = CGPointMake(140,240); 
		
		fingerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"finger.png"]];
		fingerImg.alpha = 0;
		fingerImg.center = CGPointMake(174,393); 
		
		rippleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ripple.png"]];
		rippleImg.alpha = 0.75;
		rippleImg.center = CGPointMake(128,370); 
		[rippleImg setTransform:CGAffineTransformMakeScale(0.0001,0.0001)];
		
		bringPlayerAnimationIterator = 0;
		winnerBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"winner.png"]];
		
		dropDownMenu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownMenu.png"]];
		dropDownMenu.alpha = 0.75;
		dropDownMenu.center = CGPointMake(353,240);
		
		CGRect dropDownAreaFrame = CGRectMake(255,0,65,480);
		dropDownAreaBtn = [viewController buttonWithTitle:nil target:self downSelector:@selector(showDropDownMenu) dragExitReleaseSelector:@selector(hideDelay) frame:dropDownAreaFrame];

		CGRect backBtnFrame = CGRectMake(320,16,45,120);
		backBtn = [viewController buttonWithTitle:nil target:viewController selectorDown:@selector(backBtnDown) selectorUp:@selector(toPlayMenuView) frame:backBtnFrame imageNormal:[UIImage imageNamed:@"backButton.png"]];
		
		dropDownBtnSelected = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownBtnSelected.png"]];
		dropDownBtnSelected.alpha = 0;
		
		dropDownBtnSelectedNO = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropDownBtnSelectedNO.png"]];
		dropDownBtnSelectedNO.alpha = 0;
		
		corners = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"corners.png"]];
		corners.alpha = 0;
		
		dropDownHidden = YES;
		tapWhenReadyAnimation =  NO;
		playerMotionActive = NO;
    }
    return self;
}

- (void) showScoreBoard {
	[self addSubview:winnerBackground];
	[self addSubview:tapWhenReadyImg];
	[self addSubview:fingerImg];
	[self addSubview:rippleImg];
	[self addSubview:dropDownAreaBtn];
	[self addSubview:dropDownMenu];
	[self addSubview:backBtn];
	[self addSubview:dropDownBtnSelected];
	[self addSubview:dropDownBtnSelectedNO];
	[self addSubview:corners];
}

- (void) showPlayers {
	winnerBackground.alpha = 0;
	for(i=0;i < 12;++i){
		[[viewController players:i] removeFromSuperview];
	}	
	for(i=0;i < [self.viewController nbPlayers];++i){
		[viewController players:i].alpha = 1;
		[[viewController players:i] showPlayer];
		[self addSubview:[viewController players:i]];
	}	
}

- (void) bringPlayerAnimation{
	
	[self bringSubviewToFront:dropDownMenu];
	[self bringSubviewToFront:dropDownAreaBtn];
	[self bringSubviewToFront:backBtn];
	[self bringSubviewToFront:dropDownBtnSelectedNO];
	[self bringSubviewToFront:dropDownBtnSelected];
	[self bringSubviewToFront:corners];
	[viewController players:bringPlayerAnimationIterator].center = CGPointMake((490-(330/([viewController nbPlayers]+1))-5)-(bringPlayerAnimationIterator*((330-(330/[viewController nbPlayers]))/[viewController nbPlayers])),1040);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[viewController players:bringPlayerAnimationIterator].center = CGPointMake((490-(330/([viewController nbPlayers]+1))-5)-(bringPlayerAnimationIterator*((330-(330/[viewController nbPlayers]))/[viewController nbPlayers])),480);
	[UIView commitAnimations];	
	if(bringPlayerAnimationIterator == [viewController nbPlayers] -1) {
		bringPlayerAnimationIterator = 0;
		[[viewController bringPlayersSynch] invalidate];
		[viewController setUpdateDone:YES];
		[self startPlayerMotionWithIndex:0];
		[self showDropDownMenu];
		[self hideDelay];
		if(![viewController onGoingGame]){
		[self startTapWhenReady];
		}
		[viewController setActivateDropDownMenuArea:YES];
	}else {
		bringPlayerAnimationIterator = bringPlayerAnimationIterator + 1;
	}
}

- (void) startPlayerMotionWithIndex:(int) _index {
	if(![viewController onGoingGame] && !playerMotionActive){
	[self bringSubviewToFront:[viewController players:_index]];
	[self bringSubviewToFront:dropDownMenu];
	[self bringSubviewToFront:dropDownAreaBtn];
	[self bringSubviewToFront:backBtn];	
	[self bringSubviewToFront:dropDownBtnSelectedNO];
	[self bringSubviewToFront:dropDownBtnSelected];
	[self bringSubviewToFront:corners];
	index = _index;
	playerMotionActive = YES;
	timerPlayerMotion = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(playerMotion) userInfo: nil repeats:YES];
	}
}

- (void) stopPlayerMotionWhiteFade:(BOOL) playWhiteFade {
	if(playerMotionActive){
		playerMotionActive = NO;
		[timerPlayerMotion invalidate];
		[self stopTapWhenReady];
		[[viewController players:index] setTransform:CGAffineTransformMakeScale(1.0,1.0)];
	}
	if(playWhiteFade){
		[viewController whiteFadeOut];
	}
}

- (void) startTapWhenReady {
	if(!tapWhenReadyAnimation) {
	[self bringSubviewToFront:tapWhenReadyImg];
	[self bringSubviewToFront:rippleImg];
	[self bringSubviewToFront:fingerImg];
	
	timerTapWhenReadyAnimation = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(startTapWhenReadyAnimation) userInfo: nil repeats:YES];
	
	tapWhenReadyAnimation =  YES;
	}
}

- (void) stopTapWhenReady {
    if(tapWhenReadyAnimation){ 
		tapWhenReadyAnimation = NO;
		[timerTapWhenReadyAnimation invalidate];
		rippleImg.alpha = 0;
		fingerImg.alpha = 0;
		tapWhenReadyImg.alpha = 0;
	}
}

- (void) startTapWhenReadyAnimation {
	fingerImg.alpha = 1;
	
	rippleAnimationDelay = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector: @selector(rippleAnimation) userInfo: nil repeats:NO];
	
	CABasicAnimation *fingerImgMoveXAnimation = [CABasicAnimation animation];
    fingerImgMoveXAnimation.keyPath = @"position.x";
    fingerImgMoveXAnimation.fromValue = [NSNumber numberWithFloat:174];
    fingerImgMoveXAnimation.toValue = [NSNumber numberWithFloat:154];
    fingerImgMoveXAnimation.duration = 0.5;
    fingerImgMoveXAnimation.repeatCount = 0;
	fingerImgMoveXAnimation.autoreverses = YES;
    fingerImgMoveXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [fingerImg.layer addAnimation: fingerImgMoveXAnimation forKey:@"fingerImgMoveX"];
	
	CABasicAnimation *tapWhenReadyAlphaAnimation = [CABasicAnimation animation];
    tapWhenReadyAlphaAnimation.keyPath = @"opacity";
    tapWhenReadyAlphaAnimation.fromValue = [NSNumber numberWithFloat:0];
    tapWhenReadyAlphaAnimation.toValue = [NSNumber numberWithFloat:0.75];
    tapWhenReadyAlphaAnimation.duration = 0.5;
    tapWhenReadyAlphaAnimation.repeatCount = 0;
	tapWhenReadyAlphaAnimation.autoreverses = YES;
    tapWhenReadyAlphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [tapWhenReadyImg.layer addAnimation: tapWhenReadyAlphaAnimation forKey:@"tapWhenReadyAlpha"];
}

- (void) hideNonWinningPlayers:(Player*) winner {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	winnerBackground.alpha = 1;
	[UIView commitAnimations];	
	if([viewController nbPlayers] != 1) {
	for(i=0;i<[viewController nbPlayers];++i){
		if([viewController players:i] != winner) {
		[UIView beginAnimations:@"hideNonWinningPlayers" context:NULL];
			if(i == ([viewController nbPlayers]-1)) {	
				[UIView setAnimationDelegate:self];
			}
		[UIView setAnimationDuration:1];
		[viewController players:i].alpha = 0;
		[UIView commitAnimations];
		}
	}
	} else {
		[self moveWinner];	
	}
	
}

- (void) animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	if(theAnimation == @"hideNonWinningPlayers") {
		[self moveWinner];
	}
}

- (void) showWinnerWithPlayer:(Player *) _winningPlayer {
	winningPlayer = _winningPlayer;
	[self hideNonWinningPlayers:[viewController winningPlayer]];
	}

- (void)dealloc {
	[fingerImg release];
	[tapWhenReadyImg release];
	[rippleImg release];
	[winnerBackground release];
	[dropDownMenu release];
	[dropDownAreaBtn release];
	[backBtn release];
    [super dealloc];
}

- (void) moveWinner {
	[self bringSubviewToFront:winningPlayer];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	winningPlayer.center = CGPointMake(250,480);
	[UIView commitAnimations];
	[self startPlayerMotionWithIndex:0];	
}

- (void) showDropDownMenu {
	if(dropDownHidden){
		dropDownHidden = NO;
		corners.alpha = 1;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		dropDownMenu.center = CGPointMake(287,240);
		backBtn.center = CGPointMake(backBtn.center.x-60,backBtn.center.y);
		[UIView commitAnimations];
	}else {
		if(dropDownTimer == YES){	
			[timerDropDownMenu invalidate];
		    dropDownTimer = NO;
	    }
	}
}

- (void) hideDropDownMenu {
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
        dropDownBtnSelectedNO.center = CGPointMake(dropDownBtnSelectedNO.center.x+60,dropDownBtnSelectedNO.center.y); 
		[UIView commitAnimations];
		dropDownHidden = YES;
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0];
		[UIView setAnimationDelay:0.2];
		corners.alpha = 0;
		[UIView commitAnimations];		
	}
}

- (void) hideDelay{
	dropDownTimer = YES;
    timerDropDownMenu = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector: @selector(hideDropDownMenu) userInfo: nil repeats:NO];
}

- (void) hideWinnerBackground {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
    winnerBackground.alpha = 0;
	[UIView commitAnimations];
}

- (void) playerMotion {
	CABasicAnimation *playerScaleXAnimation = [CABasicAnimation animation];
    playerScaleXAnimation.keyPath = @"transform.scale.x";
    playerScaleXAnimation.fromValue = [NSNumber numberWithFloat:1];
    playerScaleXAnimation.toValue = [NSNumber numberWithFloat:0.98];
    playerScaleXAnimation.duration = 0.5;
    playerScaleXAnimation.repeatCount = 0;
	playerScaleXAnimation.autoreverses = YES;
    playerScaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [[viewController players:index].layer addAnimation:playerScaleXAnimation forKey:@"playerScaleX"];
	CABasicAnimation *playerScaleYAnimation = [CABasicAnimation animation];
    playerScaleYAnimation.keyPath = @"transform.scale.y";
    playerScaleYAnimation.fromValue = [NSNumber numberWithFloat:1];
    playerScaleYAnimation.toValue = [NSNumber numberWithFloat:0.98];
    playerScaleYAnimation.duration = 0.5;
    playerScaleYAnimation.repeatCount = 0;
	playerScaleYAnimation.autoreverses = YES;
    playerScaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [[viewController players:index].layer addAnimation:playerScaleYAnimation forKey:@"playerScaleY"];

}

- (void) rippleAnimation {
	
	CABasicAnimation *rippleAlphaAnimation = [CABasicAnimation animation];
    rippleAlphaAnimation.keyPath = @"opacity";
    rippleAlphaAnimation.fromValue = [NSNumber numberWithFloat:1];
    rippleAlphaAnimation.toValue = [NSNumber numberWithFloat:0];
    rippleAlphaAnimation.duration = 0.5;
    rippleAlphaAnimation.repeatCount = 0;
    rippleAlphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [rippleImg.layer addAnimation:rippleAlphaAnimation forKey:@"rippleAlpha"];
	CABasicAnimation *rippleScaleXAnimation = [CABasicAnimation animation];
    rippleScaleXAnimation.keyPath = @"transform.scale.x";
    rippleScaleXAnimation.fromValue = [NSNumber numberWithFloat:0.0001];
    rippleScaleXAnimation.toValue = [NSNumber numberWithFloat:0.3];
    rippleScaleXAnimation.duration = 0.5;
    rippleScaleXAnimation.repeatCount = 0;
    rippleScaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [rippleImg.layer addAnimation:rippleScaleXAnimation forKey:@"rippleScaleX"];
	CABasicAnimation *rippleScaleYAnimation = [CABasicAnimation animation];
    rippleScaleYAnimation.keyPath = @"transform.scale.y";
    rippleScaleYAnimation.fromValue = [NSNumber numberWithFloat:0.0001];
    rippleScaleYAnimation.toValue = [NSNumber numberWithFloat:1];
    rippleScaleYAnimation.duration = 0.5;
    rippleScaleYAnimation.repeatCount = 0;
    rippleScaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [rippleImg.layer addAnimation:rippleScaleYAnimation forKey:@"rippleScaleY"];
	
}

- (void) showBackBtnDown {
	[self showDropDownMenu];
	dropDownBtnSelected.alpha = 1;
	dropDownBtnSelected.center = CGPointMake(285,80);
}

- (void) hideDropDownBtnSelected {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	dropDownBtnSelected.alpha = 0;
	[UIView commitAnimations];
}

- (void) showBackBtnDownNO {
	[self showDropDownMenu];
	dropDownBtnSelectedNO.alpha = 1;
	dropDownBtnSelectedNO.center = CGPointMake(285,80);
}

- (void) hideDropDownBtnSelectedNO {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1];
	dropDownBtnSelectedNO.alpha = 0;
	[UIView commitAnimations];
}

@end
