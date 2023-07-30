//
//  Player.h
//  jeu
//
//  Created by Jonathan Lafleur on 19/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScoreBoardController;

@interface Player : UIImageView {
	
	ScoreBoardController *viewController;

	int totalPoints;
	int gameIterator;
	int orderPos;
	int gameCodeNewTmp;
	int gameCodeOldTmp;
	int i;
	
	NSString *games[50];
	
	NSTimer *addTimeSynch;
	NSTimer *addPointDelay;
	
	float totalTime;
	float timeToAdd;
	float lastTotalTime;
	
	BOOL updateFinnished;
	
	NSString *color;
	NSString *lastGame;
    NSString *nextGame;
	
	UILabel *totalTimeLbl;
	UILabel *totalPointsLbl;
	
	UIImageView *scoreBackground;
	UIImageView *scoreBackgroundColor;
	UIImageView *scoreColorBar;
	UIImageView *scoreBackgroundHighlight;
}

@property (nonatomic, assign) ScoreBoardController *viewController;
@property (nonatomic, assign) int orderPos;
@property (nonatomic, assign) int totalPoints;
@property (nonatomic, assign) float totalTime;

- (id)initWithFrame:(CGRect)frame viewController:(ScoreBoardController *)aController;
- (void) resetPlayer;
- (void) addToTotalTime:(float)time;
- (void) addOnePoint;
- (void) addOnePointDelay;
- (void) switchPositionWithX:(float)x Y:(float)y;
- (void) setColor:(NSString *)colorCode;
- (void) initGameOrder;
- (void) showPlayer;
- (NSString *) nextGame;

@end
