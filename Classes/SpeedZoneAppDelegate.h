//
//
//  Created by Jonathan Lafleur on 03/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogoController,MenuController,GameController,ScoreBoardController,AudioPlayer,AudioQueueObject;

@interface SpeedZoneAppDelegate : NSObject  {
    
	IBOutlet UIWindow *window;

	ScoreBoardController *scoreBoardController;
	LogoController *logoController;
	MenuController *menuController;
	GameController *gameController;
}

@property (nonatomic, assign) ScoreBoardController *scoreBoardController;

- (void) playWhiteFadeIn;
- (BOOL) onGoingPlay;
- (void) startGameWithName:(NSString *) gameName;
- (void) showMenuWithName:(NSString *) menuName;
- (void) initScoreBoardWithNbPlayers:(int) nbPlayers withNbPointsToWin:(int) nbPointsToWin;
- (void) moveToLeftScoreBoard;
- (void) backGroundLoopPlayPause:(NSString*) _state;

@end

