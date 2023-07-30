//
//
//  Created by Jonathan Lafleur on 03/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "SpeedZoneAppDelegate.h"
#import "LogoController.h"
#import "MenuController.h"
#import "GameController.h"
#import "ScoreBoardController.h"
#import "PracticeMenuController.h"
#import "AudioQueueObject.h"
#import "AudioPlayer.h"

@implementation SpeedZoneAppDelegate

@synthesize scoreBoardController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  
	gameController = [[GameController alloc] init:self withWindow:window];
	menuController = [[MenuController alloc] init:self withWindow:window];
	logoController = [[LogoController alloc] init:self withWindow:window];
	scoreBoardController = [[ScoreBoardController alloc] init:self withWindow:window withGameController:gameController withMenuController:menuController];
	
	UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
	AudioSessionSetProperty (
							 kAudioSessionProperty_AudioCategory,
							 sizeof (sessionCategory),
							 &sessionCategory
							 );
	
	AudioSessionSetActive (true);
	//[gameController startGameWithName:@"valve"];
}


- (void)dealloc {
    [logoController release];
	[scoreBoardController release];
	[menuController release];
	[gameController release];
    [window release];
    [super dealloc];
}

- (void) startGameWithName:(NSString *) gameName {
	[gameController startGameWithName:gameName];
}

- (void) playWhiteFadeIn {
	if([scoreBoardController onGoingPlay] && ([menuController nextMenu] != @"PracticeMenuView")) {
		[window addSubview:scoreBoardController.view];
	    [scoreBoardController whiteFadeIn];
	} else {
		[window addSubview:menuController.view];
		[menuController whiteFadeIn];
	}
}

- (void) showMenuWithName:(NSString *) menuName {
	[menuController showMenuWithName:menuName];
}

- (void) initScoreBoardWithNbPlayers:(int) nbPlayers withNbPointsToWin:(int) nbPointsToWin {
	[scoreBoardController startGameWithNbPlayers:nbPlayers withNbPointsToWin:nbPointsToWin];
}

- (void) moveToLeftScoreBoard {
	[scoreBoardController moveToLeftView];
}

- (BOOL) onGoingPlay {
	return [scoreBoardController onGoingPlay];
}

- (void) backGroundLoopPlayPause:(NSString*) _state{
	if(_state == @"play"){
		[[[menuController mainMenuView] backgroundLoop] setAudioVolume:0.0];
		[[[menuController mainMenuView] backgroundLoop] playFadeInIsLooping:YES Delay:0.0 Duration:1.0 ToVolume:0.5];
	}
	if(_state == @"pause"){
		[[[menuController mainMenuView] backgroundLoop] pauseFadeOutWithDelay:0.0 Duration:1.6];
	}
}

@end
