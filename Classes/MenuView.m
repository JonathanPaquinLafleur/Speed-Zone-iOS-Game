//
//  MenuView.m
//  jeu
//
//  Created by Jonathan Lafleur on 10/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "MenuView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MenuView

@synthesize viewController;
@synthesize _gameStarted;
@synthesize _scoreBoardShowing;

- (id)initWithFrame:(CGRect)frame viewController:(jeuViewController *)aController {
    self = [super initWithFrame:frame];
	if (self != nil) {
		self.viewController = aController;
		[self loadLogo];
		_gameBtnSelected = NO;
		_gameStarted = NO;
		_scoreBoardShowing = NO;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)setupSubviews {    

	if(i == 3){
		
		

		
		//Play Menu
		CGRect frame = CGRectMake(100,100,100,100);
		nbPlayerSlider = [[UISlider alloc] initWithFrame:frame];
		[nbPlayerSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
		UIImage *stetchLeftTrack = [[UIImage imageNamed:@"mainTitle.png"]
									stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
		UIImage *stetchRightTrack = [[UIImage imageNamed:@"mainTitle.png"]
									 stretchableImageWithLeftCapWidth:0.0 topCapHeight:0.0];
		[nbPlayerSlider setThumbImage: [UIImage imageNamed:@"boule.png"] forState:UIControlStateNormal];
		[nbPlayerSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
		[nbPlayerSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
		nbPlayerSlider.minimumValue = 1.0;
		nbPlayerSlider.maximumValue = 12.0;
		nbPlayerSlider.continuous = YES;
		nbPlayerSlider.value = 1.0;
		nbPlayerSlider.transform = CGAffineTransformMakeRotation (M_PI/2);
		//[self addSubview:nbPlayerSlider];
		
		UIImage *startBtnImage = [UIImage imageNamed:@"playButton.png"];
		CGRect startBtnFrame = CGRectMake(130,920,50,240);
		startBtn = [self buttonWithTitle:nil target:self selector:@selector(moveToScoreBoard) frame:startBtnFrame  imageNormal:startBtnImage];
		[self addSubview:startBtn];
		
		//Other
		_practiceBtnSelected = NO;
		_playBtnSelected = NO;
		_startBtnSelected = NO;
		_practiceBackBtnSelected = NO;
        _practiceNextBtnSelected = NO;
			
		[UIView beginAnimations:@"interface" context:NULL];
		[UIView setAnimationDuration:0.9];
		practiceBtn.alpha = 1;
		playBtn.alpha = 1;
		title.center = CGPointMake(275,240);
		[UIView commitAnimations];
	
	}

	
	++i;
}


- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	if(_scoreBoardShowing && [viewController _onGoingGame]){
		[viewController setSelectedGameBtnString:[[viewController players:[viewController activePlayer]] nextGame]];
		[viewController launchGameSynch];
		_scoreBoardShowing = NO;
	}
	
}

- (void)moveToPracticeMenu {
	if(_practiceBtnSelected){
		[UIView beginAnimations:@"goToPratice1" context:NULL];
		[UIView setAnimationDuration:1];
		practiceTitle.center = CGPointMake(practiceTitle.center.x,practiceTitle.center.y - 800);
		practiceBtn.center = CGPointMake(practiceBtn.center.x + 3,practiceBtn.center.y - 800);
		playBtn.center = CGPointMake(playBtn.center.x,playBtn.center.y - 800);
		title.center = CGPointMake(title.center.x,title.center.y - 800);
		holeGameBtn.center = CGPointMake(holeGameBtn.center.x,holeGameBtn.center.y - 800);
		eggFallBtn.center = CGPointMake(eggFallBtn.center.x,eggFallBtn.center.y - 800);
		practiceBackground.center = CGPointMake(practiceBackground.center.x,practiceBackground.center.y - 800);
		[UIView commitAnimations];	
		activeMenu = @"practice1";
        _practiceBtnSelected = NO;
		[practiceBtn setImage:[UIImage imageNamed:@"practiceButton.png"] forState:UIControlStateNormal];
	} else {
		_practiceBtnSelected = YES;
		[UIView beginAnimations:@"scalePracticeBtn" context:NULL];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationRepeatCount:1e100f];
		[UIView setAnimationRepeatAutoreverses:YES];
		practiceBtn.center = CGPointMake(practiceBtn.center.x - 3,practiceBtn.center.y);
		[UIView commitAnimations];
		[practiceBtn setImage:[UIImage imageNamed:@"practiceButtonSelected.png"] forState:UIControlStateNormal];
		
		if(_playBtnSelected){
		playBtn.center = CGPointMake(playBtn.center.x + 3,playBtn.center.y);
		[playBtn setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
		_playBtnSelected = NO;
		}
    }
}

- (void)moveToPlayMenu {
	if(_playBtnSelected){
		[UIView beginAnimations:@"goToPlay" context:NULL];
		[UIView setAnimationDuration:1];
		practiceBtn.center = CGPointMake(practiceBtn.center.x,practiceBtn.center.y - 800);
		title.center = CGPointMake(title.center.x,title.center.y - 800);
		playBtn.center = CGPointMake(playBtn.center.x + 3,playBtn.center.y - 800);
		startBtn.center = CGPointMake(startBtn.center.x,startBtn.center.y - 800);
		[UIView commitAnimations];	
		activeMenu = @"play";
        _playBtnSelected = NO;
		[playBtn setImage:[UIImage imageNamed:@"playButton.png"] forState:UIControlStateNormal];
	} else {
		_playBtnSelected = YES;
		[UIView beginAnimations:@"scalePplayBtn" context:NULL];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationRepeatCount:1e100f];
		[UIView setAnimationRepeatAutoreverses:YES];
		playBtn.center = CGPointMake(playBtn.center.x - 3,playBtn.center.y);
		[UIView commitAnimations];	
		[playBtn setImage:[UIImage imageNamed:@"playButtonSelected.png"] forState:UIControlStateNormal];
		
		if(_practiceBtnSelected){
		practiceBtn.center = CGPointMake(practiceBtn.center.x + 3,practiceBtn.center.y);
		[practiceBtn setImage:[UIImage imageNamed:@"practiceButton.png"] forState:UIControlStateNormal];
		_practiceBtnSelected = NO;
		}    
	}
}

- (void)moveBack {
	if(_practiceBackBtnSelected){
		if(activeMenu == @"practice1"){
			[UIView beginAnimations:@"goToMain" context:NULL];
			[UIView setAnimationDuration:1];
			practiceTitle.center = CGPointMake(practiceTitle.center.x,practiceTitle.center.y + 800);
						practiceBtn.center = CGPointMake(practiceBtn.center.x,practiceBtn.center.y + 800);
			playBtn.center = CGPointMake(playBtn.center.x,playBtn.center.y + 800);
			title.center = CGPointMake(title.center.x,title.center.y + 800);
			holeGameBtn.center = CGPointMake(holeGameBtn.center.x,holeGameBtn.center.y + 800);
			eggFallBtn.center = CGPointMake(eggFallBtn.center.x,eggFallBtn.center.y + 800);
			practiceBackground.center = CGPointMake(practiceBackground.center.x,practiceBackground.center.y + 800);
			[UIView commitAnimations];	
			activeMenu = @"main";
		}
		if(activeMenu == @"practice2"){
			[UIView beginAnimations:@"goToMain" context:NULL];
			[UIView setAnimationDuration:1];
			holeGameBtn.center = CGPointMake(holeGameBtn.center.x,holeGameBtn.center.y + 800);
			eggFallBtn.center = CGPointMake(eggFallBtn.center.x,eggFallBtn.center.y + 800);
			[UIView commitAnimations];	
			activeMenu = @"practice1";
		}
		selectedGameBtn.alpha = 0;
		_practiceBackBtnSelected = NO;
		_gameBtnSelected = NO;
		[practiceTitle setImage:[UIImage imageNamed:@"practiceTitle.png"]];

	} else {
		_practiceBackBtnSelected = YES;
		_practiceNextBtnSelected = NO;
		[practiceTitle setImage:[UIImage imageNamed:@"practiceTitleBack.png"]];
	}
	
}

- (void)moveToScoreBoard {
	if(_startBtnSelected){
		[UIView beginAnimations:@"hideNeons" context:NULL];
		[UIView setAnimationDuration:0.5];
		neon.alpha = 0;
		[UIView commitAnimations];	
		startBtn.center = CGPointMake(startBtn.center.x,startBtn.center.y - 800);
		[viewController initScoreBoardPlayers];
		iterator = 0;
		scoreBoardTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector: @selector(initShowPlayerScore) userInfo: nil repeats:YES];	
		
	} else {
		_startBtnSelected = YES;
		[startBtn setImage:[UIImage imageNamed:@"playButtonSelected.png"] forState:UIControlStateNormal];
	}
	
}

- (void)moveNext {
	if(_practiceNextBtnSelected){
		if(activeMenu == @"practice1"){
			[UIView beginAnimations:@"goToPractice2" context:NULL];
			[UIView setAnimationDuration:1];
			holeGameBtn.center = CGPointMake(holeGameBtn.center.x,holeGameBtn.center.y - 800);
			eggFallBtn.center = CGPointMake(eggFallBtn.center.x,eggFallBtn.center.y - 800);
			[UIView commitAnimations];	
			activeMenu = @"practice2";
		}
		_practiceNextBtnSelected = NO;
		_gameBtnSelected = NO;
		selectedGameBtn.alpha = 0;
		[practiceTitle setImage:[UIImage imageNamed:@"practiceTitle.png"]];
	} else {
		_practiceNextBtnSelected = YES;
		_practiceBackBtnSelected = NO;
		[practiceTitle setImage:[UIImage imageNamed:@"practiceTitleNext.png"]];
	}
	
}

- (void)displaySelectedGameWithGameName:(NSString*) gameName{
	if(gameName == @"holeGame"){
		selectedGameBtn.alpha = 1;
		selectedGameBtn.center = CGPointMake(holeGameBtn.center.x+1,holeGameBtn.center.y+2);
	}
	if(gameName == @"eggFall"){
		selectedGameBtn.alpha = 1;
		selectedGameBtn.center = CGPointMake(eggFallBtn.center.x+1,eggFallBtn.center.y+2);
	}
}

- (void)hideSelectedGame{
		selectedGameBtn.alpha = 0;
}

- (void)sliderAction:(id)sender
{

}

- (void) selectedGameBtnHoleGame {
	
	NSString *tmpSelectedGameBtnString;
	
    tmpSelectedGameBtnString = [viewController selectedGameBtnString];
	[viewController setSelectedGameBtnString:@"holeGame"];
	if(tmpSelectedGameBtnString != [viewController selectedGameBtnString]){
		_gameBtnSelected = NO;
	}
	if(_gameBtnSelected && !_gameStarted){
		[viewController launchGameSynch];
		_gameBtnSelected = NO;
		_gameStarted =YES;
	} else {
		_gameBtnSelected = YES;
		[self displaySelectedGameWithGameName:[viewController selectedGameBtnString]];
	}
}


- (void) selectedGameBtnEggFall {
	
	NSString *tmpSelectedGameBtnString;
    tmpSelectedGameBtnString = [viewController selectedGameBtnString];
	[viewController setSelectedGameBtnString:@"eggFall"];
	if(tmpSelectedGameBtnString != [viewController selectedGameBtnString]){
		_gameBtnSelected = NO;
	}
	if(_gameBtnSelected && !_gameStarted){
		[viewController launchGameSynch];
		_gameBtnSelected = NO;
		_gameStarted =YES;
	} else {
		_gameBtnSelected = YES;
		[self displaySelectedGameWithGameName:[viewController selectedGameBtnString]];
	}
}

- (void) initShowPlayerScore {
	
	[viewController set_onGoingGame:YES];
	if(iterator < [viewController nbPlayers]){
		[[viewController players:iterator] showPlayer];
	} else {
		[scoreBoardTimer invalidate];
		[self startPlayerMotionWithIndex:0];
		_scoreBoardShowing = YES;
	}
	++iterator;
}

-(void) startPlayerMotionWithIndex:(int)index{
	UIImageView *playerForStartMotion; 
	[UIView beginAnimations:@"scalePlayBtn" context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationRepeatCount:1e100f];
	[UIView setAnimationRepeatAutoreverses:YES];
	CGAffineTransform scale = CGAffineTransformMakeScale(0.95,0.95); 
	playerForStartMotion = [viewController players:index];
	playerForStartMotion.transform = scale;
	[[viewController view] bringSubviewToFront:playerForStartMotion]; 
	[UIView commitAnimations];	
}

-(void) stopPlayerMotionWithIndex:(int)index{
	UIImageView *playerForStopMotion; 
	[UIView beginAnimations:@"dynamicmotion" context:NULL];
	[UIView setAnimationDuration:0.5];
	CGAffineTransform scale = CGAffineTransformMakeScale(1,1);
	playerForStopMotion = [viewController players:index];
	playerForStopMotion.transform = scale;
	[[viewController view] bringSubviewToFront:playerForStopMotion]; 
	[UIView commitAnimations];	
}

-(void) showWinnerWithPlayer:(UIImageView *)winnerView{
	UIImageView *nonWinnerPlayer; 
	[UIView beginAnimations:@"displaysWinner" context:NULL];
	[UIView setAnimationDuration:2];
	for(int f=0;f<[viewController nbPlayers];++f){
		nonWinnerPlayer = [viewController players:f];
		if(nonWinnerPlayer != winnerView){
		nonWinnerPlayer.alpha = 0;
		}
	//winnerImg.alpha = 1;
	}
	
	[UIView commitAnimations];	
}

@end
