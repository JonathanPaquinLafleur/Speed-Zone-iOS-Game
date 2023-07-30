//
//  ScoreBoardController.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 06/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ScoreBoardController.h"
#import "SpeedZoneAppDelegate.h"
#import "ScoreBoardView.h"
#import "GameController.h"
#import "MenuController.h"
#import "Player.h"
#import <QuartzCore/QuartzCore.h>
#import "AudioQueueObject.h"
#import "AudioPlayer.h"

@implementation ScoreBoardController

@synthesize nbPlayers;
@synthesize nbPointsToWin;
@synthesize totalNbOfGames;
@synthesize onGoingPlay;
@synthesize addPoint;
@synthesize bringPlayersSynch;
@synthesize onGoingGame;
@synthesize activateDropDownMenuArea;
@synthesize winningPlayer;
@synthesize updateDone;

- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window withGameController:(GameController *) _gameController withMenuController:(MenuController *)_menuController{
	if (self = [super init]) {	
		
		applicationFrame = [[UIScreen mainScreen] applicationFrame];
		
		gameController = _gameController;
		menuController = _menuController;
		

		colorCode[0]=@"1";
		colorCode[1]=@"2";
		colorCode[2]=@"3";
		colorCode[3]=@"4";
		colorCode[4]=@"5";
		colorCode[5]=@"6";
		colorCode[6]=@"7";
		colorCode[7]=@"8";
		colorCode[8]=@"9";
		colorCode[9]=@"10";
		colorCode[10]=@"11";
		colorCode[11]=@"12";		
		
		window = _window;
		appDel = _appDel;
		
		onGoingGame = NO;
		onGoingPlay = NO;
		totalNbOfGames = 8;
		
		menuBtn = [[AudioPlayer alloc] initShortFXWithName:@"menu"];
		
		backgroundImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
		[self.view addSubview:backgroundImg];
		
		scoreBoardView = [[ScoreBoardView alloc] initWithFrame:applicationFrame viewController:self];
		
		for(i=0;i < 12;++i){
			players[i] = [[Player alloc] initWithFrame:applicationFrame viewController:self];
		}
		
		whiteFade = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteFade.png"]];
		whiteFade.alpha = 0;
		
		gameIntro = [[AudioPlayer alloc] initShortFXWithName:@"Logo"];
		
		[self.view addSubview:scoreBoardView];
		[scoreBoardView showScoreBoard];
		[self.view addSubview:whiteFade];
		
		onGoingPlay = NO;
	}
	return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

-(void) startGameWithNbPlayers:(int) _nbPlayers withNbPointsToWin:(int) _nbPointsToWin{

	activateDropDownMenuArea = NO;
	scoreBoardView.center = CGPointMake(160,240);
	
	onGoingPlay = YES;
	nbPlayers = _nbPlayers;
	nbPointsToWin = _nbPointsToWin;
	winner = NO;
	winningPlayer = nil;
	activePlayerIterator = 0;
	playerTmp = nil;
	inTransition = NO;
	updateDone = NO;
	
	[window addSubview:self.view];
	[window bringSubviewToFront:self.view];
	
    [self scrambleColorCode];
	for(i=0;i < nbPlayers;++i){
		[players[i] resetPlayer];
		[players[i] setColor:[NSString stringWithFormat:@"%@",colorCode[i]]];
		[players[i] initGameOrder];
		[players[i] setOrderPos:i];
	}
	[scoreBoardView showPlayers];

	bringPlayersSynch = [NSTimer scheduledTimerWithTimeInterval:0.5 target:scoreBoardView selector: @selector(bringPlayerAnimation) userInfo: nil repeats:YES];	
}

- (void) scrambleColorCode {
	
	colorCodeNewTmp = 1;	
	colorCodeOldTmp = 1;
	
	for(i=0;i < 12;++i){
		colorCodeNewTmp = (float)(arc4random()%12);
		colorCodeOldTmp = (int) colorCode[i];
		colorCode[i] = colorCode[colorCodeNewTmp];
		colorCode[colorCodeNewTmp] = (NSString *)colorCodeOldTmp;
	}
}

-(Player *) players:(int)index{
	return players[index];
}

- (void)dealloc {
	[whiteFade release];
    [super dealloc];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	if(!winner) {
		if(!onGoingGame && onGoingPlay && !inTransition && updateDone){
			
			[appDel backGroundLoopPlayPause:@"pause"];
			[gameIntro playShortFX];
			
			onGoingGame = YES;
			updateDone = NO;
			[scoreBoardView stopPlayerMotionWhiteFade:YES];
		}
	}else{
		[scoreBoardView stopPlayerMotionWhiteFade:NO];
		[scoreBoardView hideWinnerBackground];
		[scoreBoardView hideDropDownMenu];
		[self moveToRightView];
	}
}

- (void) updateGameInfoWithTotalTime:(float)timeToAdd Point:(BOOL) point{
	addPoint = NO;
    [players[activePlayerIterator] addToTotalTime:timeToAdd];
	
	if(point) {
		addPoint =YES;
		[players[activePlayerIterator] addOnePointDelay];
	}
	
}

- (void) movePlayers {
	if(addPoint) {
		readjustScoreBoardIterator = nbPlayers-1;
		readjustPlayersSynch = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector: @selector(readjustScoreBoardWithPoint) userInfo: nil repeats:YES];
		
	} else {
		readjustScoreBoardIterator = 0;
		readjustPlayersSynch = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector: @selector(readjustScoreBoardWithoutPoint) userInfo: nil repeats:YES];
	}
}

- (void) whiteFadeIn {
	
	[appDel backGroundLoopPlayPause:@"play"];
	
	whiteFade.alpha = 1;
	[self.view addSubview:whiteFade];
	[UIView beginAnimations:@"whiteFadeIn" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 0;
	[UIView commitAnimations];	
}

- (void) whiteFadeOut {
	whiteFade.alpha = 0;
	[self.view addSubview:whiteFade];
	[UIView beginAnimations:@"whiteFadeOut" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 1;
	[UIView commitAnimations];	
}

- (void) switchPlayer1:(Player *)player1 withPlayer2:(Player *) player2 {
	playerXTmp = player1.center.x;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	player1.center = CGPointMake(player2.center.x,480);
	player2.center = CGPointMake(playerXTmp,480);
	[UIView commitAnimations];	
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	if(theAnimation == @"whiteFadeOut") {
		[whiteFade removeFromSuperview];
		[self.view removeFromSuperview];
		[appDel startGameWithName:[players[activePlayerIterator] nextGame]];
	}
	if(theAnimation == @"whiteFadeIn") {
		onGoingGame = NO;
		[self updateGameInfoWithTotalTime:[gameController gameTime] Point:[gameController gameWon]];
	}
	if(theAnimation == @"disapearingMenuToRight") {
		[self.view removeFromSuperview];
		[menuController moveInsideFromRightPlayMenu];
	}
}

- (void) readjustScoreBoardWithPoint {
	if(readjustScoreBoardIterator >= 1) {
	if([players[readjustScoreBoardIterator] totalPoints] >  [players[readjustScoreBoardIterator - 1] totalPoints] || ([players[readjustScoreBoardIterator] totalPoints] ==  [players[readjustScoreBoardIterator - 1] totalPoints] && [players[readjustScoreBoardIterator] totalTime] <  [players[readjustScoreBoardIterator - 1] totalTime])){
		
		[self switchPlayer1:players[readjustScoreBoardIterator] withPlayer2:players[readjustScoreBoardIterator  - 1]];
		
		playerTmp = players[readjustScoreBoardIterator];
		players[readjustScoreBoardIterator ] = players[readjustScoreBoardIterator - 1];
		players[readjustScoreBoardIterator -1] = playerTmp;
		activePlayerIterator = activePlayerIterator - 1;
	}
	readjustScoreBoardIterator = readjustScoreBoardIterator - 1;
	} else {
		[self updateGameState];	
		[readjustPlayersSynch invalidate];
	}
}

- (void) readjustScoreBoardWithoutPoint {
	if(readjustScoreBoardIterator != nbPlayers - 1) {
	if([players[readjustScoreBoardIterator ] totalPoints] <  [players[readjustScoreBoardIterator +1] totalPoints] || ([players[readjustScoreBoardIterator ] totalPoints] ==  [players[readjustScoreBoardIterator +1] totalPoints] && [players[readjustScoreBoardIterator ] totalTime] >  [players[readjustScoreBoardIterator +1] totalTime])){
		
		[self switchPlayer1:players[readjustScoreBoardIterator ] withPlayer2:players[readjustScoreBoardIterator +1]];
		
		playerTmp = players[readjustScoreBoardIterator];
		players[readjustScoreBoardIterator] = players[readjustScoreBoardIterator +1];
		players[readjustScoreBoardIterator +1] = playerTmp;
		activePlayerIterator = activePlayerIterator + 1;
	}
	readjustScoreBoardIterator = readjustScoreBoardIterator +1;
	} else {
		[self updateGameState];
		[readjustPlayersSynch invalidate];
	}
}

- (void) updateGameState {
tmpActivePlayerIterator = activePlayerIterator;
	
for(i=0;i<nbPlayers;++i){
	if([players[tmpActivePlayerIterator] orderPos] != (nbPlayers -1)){
		if([players[tmpActivePlayerIterator] orderPos] == ([players[i] orderPos]-1)) {
			activePlayerIterator = i;
		}
	} else {
		if([players[i] orderPos] == 0) {
			activePlayerIterator = i;
		}
		if([players[i] totalPoints] ==  nbPointsToWin) {
			if(winner == NO){
				winningPlayer = players[i];	
				winner = YES;
			} else {
				if([players[i] totalTime] <  [winningPlayer totalTime]){
					winningPlayer = players[i];	
				}
			}
		}
	}
}

if(winner == NO){
	if(!onGoingGame && !inTransition){
		[scoreBoardView startPlayerMotionWithIndex:activePlayerIterator];
	    [scoreBoardView startTapWhenReady];
	}
} else {
	onGoingPlay = NO;
	[scoreBoardView showWinnerWithPlayer:winningPlayer];
}
updateDone = YES;
}

- (void) toPlayMenuView{
	if(!onGoingGame && activateDropDownMenuArea && updateDone){
		[scoreBoardView hideDropDownBtnSelected];
		if(winner == YES){
			[scoreBoardView hideWinnerBackground];
		}
		inTransition = YES;
	    [scoreBoardView hideDropDownMenu];
	    [self moveToRightView];
	}else{
		[scoreBoardView hideDropDownBtnSelectedNO];
		[scoreBoardView hideDelay];
	}
}

- (void) moveToRightView{	
	
	[scoreBoardView stopTapWhenReady];
	[scoreBoardView stopPlayerMotionWhiteFade:NO];
	[UIView beginAnimations:@"disapearingMenuToRight" context:NULL];
    [UIView setAnimationDuration:0.5];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationDelegate:self];
	scoreBoardView.center =  CGPointMake(scoreBoardView.center.x,scoreBoardView.center.y + 480);
	[UIView commitAnimations];
}

- (void) moveToLeftView{
	
	
	inTransition = NO;
	if(updateDone){
	[scoreBoardView startPlayerMotionWithIndex:[scoreBoardView index]];
	[scoreBoardView startTapWhenReady];
	}
	[window addSubview:self.view];
	[window bringSubviewToFront:self.view];
	[UIView beginAnimations:@"disapearingMenuToLeft" context:NULL];
    [UIView setAnimationDuration:0.5];
	[UIView setAnimationDelay:0.2];
	[UIView setAnimationDelegate:self];
	scoreBoardView.center =  CGPointMake(scoreBoardView.center.x,scoreBoardView.center.y - 480);
	[UIView commitAnimations];
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selectorDown:(SEL)inSelectorDown selectorUp:(SEL)inSelectorUp frame:(CGRect)frame imageNormal:(UIImage*)imageNormal {
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

- (void) backBtnDown {
	if(!onGoingGame && activateDropDownMenuArea && updateDone){
		[menuBtn playShortFX];
		[scoreBoardView showBackBtnDown];
	}else{
		[scoreBoardView showBackBtnDownNO];
	}
}

@end
