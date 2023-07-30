//
//  jeuViewController.m
//  jeu
//
//  Created by Jonathan Lafleur on 03/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "jeuViewController.h"
#import "BallHole.h"
#import "EggFall.h"
#import "MenuView.h"
#import "Player.h"

@implementation jeuViewController

@synthesize menuView;
@synthesize overlay;
@synthesize selectedGameBtnString;
@synthesize nbPlayers;
@synthesize nbPointsToWin;
@synthesize activePlayer;
@synthesize _onGoingGame;
@synthesize totalNumberOfGames;
@synthesize applicationFrame;

- init {
	return self;
}

- (void)viewDidLoad {
	
	applicationFrame = [[UIScreen mainScreen] applicationFrame];
	
	// add the top-most parent view
	UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
	contentView.backgroundColor = [UIColor blackColor];
	self.view = contentView;
	[contentView release];

	[self initColors];
	nbPlayers = 12;
	totalNumberOfGames = 2;
	activePlayer = 0;
	nbPointsToWin= 1;
	
	
	//eggFall = [[EggFall alloc] initWithFrame:applicationFrame viewController:self];	
	//[self.view addSubview:eggFall];
	//ballHole = [[BallHole alloc] initWithFrame:applicationFrame viewController:self];	
	//[self.view addSubview:ballHole];
	menuView = [[MenuView alloc] initWithFrame:applicationFrame viewController:self];	
	[self.view addSubview:menuView];
	}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[overlay release];
	[wonView release];
	[failedView release];
	[eggFall release];
	[ballHole release]; 
	for(i=0;i<nbPlayers;++i){
	[players[i] release];
	}
    [super dealloc];
}

- (void)initGame:(UIView*)gameView {
	
	activeGameView = gameView;	
	UIImageView *timerStatic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timerStatic.png"]];
	timerStatic.center =  CGPointMake(20,240);
    timerStatic.opaque = YES;
	[activeGameView addSubview:timerStatic];
	
	wonView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"won.png"]];
	wonView.center = self.view.center;
    wonView.alpha = 0;
	CGAffineTransform wonScale = CGAffineTransformMakeScale(0.5,0.5);
	wonView.transform = wonScale;
	[activeGameView addSubview:wonView];
	
	failedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"failed.png"]];
	failedView.center = self.view.center;
    failedView.alpha = 0;
	CGAffineTransform failedScale = CGAffineTransformMakeScale(0.5,0.5);
	failedView.transform = failedScale;
	[activeGameView addSubview:failedView];	
	
	timerBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timerBar.png"]];
	timerBar.center =  CGPointMake(20,27);
	CGAffineTransform scale = CGAffineTransformMakeScale(1,0.01);
	timerBar.transform = scale;
    timerBar.opaque = YES;
	[activeGameView addSubview:timerBar];	
}

- (void)startTimer
{
	time = 0;
	timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(handleTimer) userInfo: nil repeats:YES];	
}

- (void)flipBackToPracticeMenu
{
	BOOL gameWonTmp;
	gameWonTmp =[activeGameView gameWon];
	[delayBeforeFlipToMenu invalidate];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:(UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
	[activeGameView removeFromSuperview];
	activeGameView = nil;
	[self.view addSubview:menuView];
	for(i=0;i<nbPlayers;++i){
	[self.view addSubview:players[i]];
	}
	[UIView commitAnimations];
	players[i] = [[Player alloc] initWithFrame:applicationFrame viewController:self xPosition:((330-(330/(nbPlayers+1))-5)-(i*((330-(330/nbPlayers))/nbPlayers))) yPosition:1040];
	
	overlay = [[Overlay alloc] initWithFrame:applicationFrame viewController:self alpha:1];
	
	[self.view addSubview:overlay];
	[overlay release];
	[overlay playWhiteFadeIn];
	
	[menuView set_gameStarted:NO];
	[menuView hideSelectedGame];
	[menuView set_scoreBoardShowing:YES];
	[self updateGameInfoWithTotalTime:time Point:gameWonTmp];
}

- (void) handleTimer 
{
	
	time = time + 0.01;
	CGAffineTransform scale = CGAffineTransformMakeScale(1,time/4);
	timerBar.transform = scale;
	timerBar.center = CGPointMake(20,(time*60)+(27-(27*(time/4))));
	
	if(time > 3.99) {
	    [self displayFailed];	
		[timer invalidate];	
		[activeGameView setGameActive:NO];
	} 
	if([activeGameView gameWon] == YES){
		[self displayWon];	
		[timer invalidate];	
		[activeGameView setGameActive:NO];
	}
}

-(void)launchGameSynch{
	overlay = [[Overlay alloc] initWithFrame:applicationFrame viewController:self alpha:0];
	
	[self.view addSubview:overlay];
	[overlay release];
	[overlay playWhiteFadeOut];	
	i=0;
	gameTransitionSynch = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(launchGame) userInfo: nil repeats:YES];
}

- (void)launchGame{
	if(i==1){
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	styleSheetView = [[StyleSheetView alloc] initWithFrame:applicationFrame viewController:self];	
	[self.view addSubview:styleSheetView];
	}
	if(i==5){
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	if(selectedGameBtnString == @"holeGame"){ballHole = [[BallHole alloc] initWithFrame:applicationFrame viewController:self];}	
	if(selectedGameBtnString == @"eggFall"){eggFall = [[EggFall alloc] initWithFrame:applicationFrame viewController:self];}		
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:(UIViewAnimationTransitionCurlDown) forView:self.view cache:YES];
	[styleSheetView removeFromSuperview];
	[self.view addSubview:activeGameView];
	[UIView commitAnimations];
	[gameTransitionSynch invalidate];
	}
	++i;
}

- (void)removeMenu{
	[menuView removeFromSuperview];
}

- (void)displayWon {
	
	[UIView beginAnimations:@"won" context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	CGAffineTransform scale = CGAffineTransformMakeScale(1,1);
	wonView.alpha = 1;
	wonView.transform = scale;
	[UIView commitAnimations]; 
	delayBeforeFlipToMenu = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(flipBackToPracticeMenu) userInfo: nil repeats:NO];
	
}

- (void)displayFailed {
    
	[UIView beginAnimations:@"failed" context:NULL];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationDelegate:self];
	CGAffineTransform scale = CGAffineTransformMakeScale(1,1);
	failedView.alpha = 1;
	failedView.transform = scale;
	[UIView commitAnimations]; 
	delayBeforeFlipToMenu = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(flipBackToPracticeMenu) userInfo: nil repeats:NO];
	
}

-(void) initScoreBoardPlayers {
	int colorCodeNewTmp = 1;
	int colorCodeOldTmp = 1;
	winner = nil;
	activePlayerIterator = 0;
	
	for(i=0;i < nbPlayers;++i){
		colorCodeNewTmp = (float)(arc4random()%12);
		colorCodeOldTmp = colorCode[i];
		colorCode[i] = colorCode[colorCodeNewTmp];
		colorCode[colorCodeNewTmp] = colorCodeOldTmp;
	}		
	for(i=0;i < nbPlayers;++i){
	players[i] = [[Player alloc] initWithFrame:applicationFrame viewController:self xPosition:((330-(330/(nbPlayers+1))-5)-(i*((330-(330/nbPlayers))/nbPlayers))) yPosition:1040];
	[self.view addSubview:players[i]];	
		[players[i] setColor:[NSString stringWithFormat:@"%@",colorCode[i]]];
		[players[i] initGameOrder];
		[players[i] setOrderPos:i];
	}
}

-(UIView *) players:(int)index{
	return players[index];
}

-(void) initColors{
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
}

- (void) updateGameInfoWithTotalTime:(float)timeToAdd Point:(BOOL) point{
	Player *playerTmp;
	float xTmp;
	float yTmp;
	
	[menuView stopPlayerMotionWithIndex:activePlayer];
    [players[activePlayer] addToTotalTime:timeToAdd];
	if(point){
	[players[activePlayer] addOnePoint];
	for(i=(nbPlayers-1);i>=1;--i){
		
		if([players[i] totalPoints] >  [players[i-1] totalPoints] || ([players[i] totalPoints] ==  [players[i-1] totalPoints] && [players[i] totalTime] <  [players[i-1] totalTime])){

			xTmp = [players[i] xPosition];
			yTmp = [players[i] yPosition];
			
			[players[i] switchPositionWithX:[players[i-1] xPosition] Y:[players[i-1] yPosition]];
			[players[i-1] switchPositionWithX:xTmp Y:yTmp];
			
			playerTmp = players[i];
			players[i] = players[i-1];
			players[i-1] = playerTmp;
		}

	}
	} else {
	for(i=0;i<nbPlayers-1;++i){
  
			if([players[i] totalPoints] <  [players[i+1] totalPoints] || ([players[i] totalPoints] ==  [players[i+1] totalPoints] && [players[i] totalTime] >  [players[i+1] totalTime])){
				
				xTmp = [players[i] xPosition];
				yTmp = [players[i] yPosition];
				
				[players[i] switchPositionWithX:[players[i+1] xPosition] Y:[players[i+1] yPosition]];
				[players[i+1] switchPositionWithX:xTmp Y:yTmp];
				
				playerTmp = players[i];
				players[i] = players[i+1];
				players[i+1] = playerTmp;
			}
		
	}
	}
	
	if(activePlayerIterator < (nbPlayers-1)){
		activePlayerIterator = activePlayerIterator +1;
	} else{
		activePlayerIterator = 0;
	}
	for(i=0;i<nbPlayers;++i){
		if([players[i] orderPos] == activePlayerIterator){
			activePlayer = i;
			}
			if(activePlayerIterator == 0 && [players[i] totalPoints] ==  nbPointsToWin){
				NSLog(@"ici1");
				if(winner == nil){
					NSLog(@"ici2");
					winner = players[i];	
				} else {
					NSLog(@"ici3");
					if([players[i] totalTime] <=  [winner totalTime]){
						NSLog(@"ici4");
						winner = players[i];	
					}
				
			}
		}
	}
	
	NSLog(@"%@",winner);
	if(winner != nil){
		NSLog(@"ici5");
		[menuView startPlayerMotionWithIndex:activePlayer];
	} else {
		NSLog(@"ici6");
		_onGoingGame = NO;
		[winner switchPositionWithX:240 Y:240];
		[menuView startPlayerMotionWithIndex:0];
		[menuView showWinnerWithPlayer:winner];
	}
}

- (void)resetAccelerometer {
	
	//if(!acceActive){
	//	[[UIAccelerometer sharedAccelerometer] setDelegate:NULL];
	//	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	//	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
		// then switch it back on
	//	[[UIAccelerometer sharedAccelerometer] setDelegate:self]; 
	//} else {
	//	[acceTestTimer invalidate];	}
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {

	//acceActive = YES;
	
}

@end
