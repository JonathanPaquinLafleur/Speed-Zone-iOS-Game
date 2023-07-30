//
//  Player.m
//  jeu
//
//  Created by Jonathan Lafleur on 19/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "ScoreBoardController.h"
#import <QuartzCore/QuartzCore.h>

@implementation Player

@synthesize viewController;
@synthesize orderPos;
@synthesize totalPoints;
@synthesize totalTime;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame viewController:(ScoreBoardController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		games[0] = @"eggFall";
		games[1] = @"ballHole";	
		games[2] = @"driver";
		games[3] = @"crane";
		games[4] = @"cups";
		games[5] = @"calcul";
		games[6] = @"marathon";
		games[7] = @"etchASketch";
		games[8] = @"findMe";
		games[9] = @"valve";
		games[10] = @"colorMix";
		
		scoreBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scoreBackground.png"]];
		
		scoreBackgroundColor = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scoreBackgroundColor1.png"]];
		
		scoreColorBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scoreColorBar1.png"]];
		scoreColorBar.layer.anchorPoint = CGPointMake(0,0);
		
		scoreBackgroundHighlight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scoreBackgroundHighlight.png"]];
		
		totalPointsLbl = [[UILabel alloc] initWithFrame:CGRectMake(0,0,150,20)];
		
		totalPointsLbl.font = [UIFont fontWithName:@"Helvetica" size:16];
		totalPointsLbl.textColor = [UIColor whiteColor];
		totalPointsLbl.backgroundColor = [UIColor clearColor];
		totalPointsLbl.textAlignment = UITextAlignmentCenter;
		totalPointsLbl.text = [NSString stringWithFormat:@"Total time:%0.2f",totalTime];
		[totalPointsLbl setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90])];
		
    }
    return self;
}

- (void)dealloc {
    [scoreBackground release];
	[scoreBackgroundColor release];
	[scoreColorBar release];
	[scoreBackgroundHighlight release];
	[totalPointsLbl release];
	[super dealloc];
}

- (void) resetPlayer{

	gameIterator = 0;
	totalPoints = 0;
	totalTime = 0.00;	
	lastGame = @"null";
	totalPointsLbl.text = [NSString stringWithFormat:@"Total time:%0.2f",totalTime];
	self.center = CGPointMake(0,480);
	scoreBackground.center = CGPointMake(0,0);
	scoreBackgroundColor.center = CGPointMake(0,0);
	scoreColorBar.center = CGPointMake(-21,-63);
	[scoreColorBar setTransform:CGAffineTransformMakeScale(1,0.00001)];
	scoreBackgroundHighlight.center = CGPointMake(0,0);
	totalPointsLbl.center = CGPointMake(0,-145);
}

-(void)showPlayer{
	[self addSubview:scoreBackground];
	[self addSubview:scoreBackgroundColor];
	[self addSubview:scoreColorBar];
	[self addSubview:scoreBackgroundHighlight];
	[self addSubview:totalPointsLbl];
}

-(void) addOnePointDelay{
	addPointDelay = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(addOnePoint) userInfo: nil repeats:NO];
}

-(void) addOnePoint{

	totalPoints = totalPoints +1;
	[UIView beginAnimations:@"addPoint" context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1];
	[scoreColorBar setTransform:CGAffineTransformMakeScale(1,(1.0/[viewController nbPointsToWin]) * totalPoints)];
	[UIView commitAnimations];	
	
}

-(void) switchPositionWithX:(float)x Y:(float)y{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	scoreBackground.center = CGPointMake(x,y);
	scoreBackgroundColor.center = CGPointMake(x,y);
	scoreBackgroundHighlight.center = CGPointMake(x,y);
	totalPointsLbl.center = CGPointMake(x,y-150);
	scoreColorBar.center = CGPointMake(x,y +(((150/[viewController nbPointsToWin]) * totalPoints)- 65));
	[UIView commitAnimations];	
	
}

-(void) addToTotalTime:(float)time{
	timeToAdd = time;
	lastTotalTime = totalTime;
	addTimeSynch = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector: @selector(addMilliToToalTime) userInfo: nil repeats:YES];
}

- (void) addMilliToToalTime {
	
	totalTime = totalTime + 0.01;
	totalPointsLbl.text = [NSString stringWithFormat:@"Total time:%0.2f",totalTime];
	if((floor((totalTime)*100.0 + 0.5)/100.0) >= (floor((lastTotalTime + timeToAdd)*100.0 + 0.5)/100.0)) {
		[addTimeSynch invalidate];
		if(updateFinnished || ![viewController addPoint]){
			[viewController movePlayers];
			updateFinnished = NO;
		} else {
			updateFinnished = YES;	
		}
	}
}

-(void) setColor:(NSString *)colorCode{
	[scoreBackgroundColor setImage:[UIImage imageNamed:[NSString stringWithFormat:@"scoreBackgroundColor%@.png",colorCode]]];
	[scoreColorBar setImage:[UIImage imageNamed:[NSString stringWithFormat:@"scoreColorBar%@.png",colorCode]]];
}

-(void) initGameOrder{
	for(i = 0; i<[viewController totalNbOfGames];++i){
		
		gameCodeNewTmp = (int)(arc4random()%([viewController totalNbOfGames]));
		gameCodeOldTmp = (int) games[i];
		games[i] = games[gameCodeNewTmp];
		games[gameCodeNewTmp] = (NSString *) gameCodeOldTmp;
	
		if(i == ([viewController totalNbOfGames]-1)){
			if(lastGame != @"null" && games[0] == lastGame){
				while(games[0] == lastGame) {
					gameCodeNewTmp = (float)(arc4random()%([viewController totalNbOfGames]));
					gameCodeOldTmp = (int)games[0];
					games[0] = games[gameCodeNewTmp];
					games[gameCodeNewTmp] = (NSString *) gameCodeOldTmp;
				}
			}
			lastGame = games[i];
		}
	}

}

-(NSString *) nextGame{
	nextGame;
	
	nextGame = games[gameIterator];

	if(gameIterator != ([viewController totalNbOfGames]-1)){
	gameIterator = gameIterator + 1;
    } else {
	
		[self initGameOrder];
		gameIterator = 0;	
	
	}
	return nextGame;
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	if(theAnimation == @"addPoint") {
		if(updateFinnished){
			[viewController movePlayers];
			updateFinnished = NO;
		} else {
			updateFinnished = YES;	
		}
	}
}

@end
