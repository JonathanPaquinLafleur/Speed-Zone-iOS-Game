//
//  Game.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 04/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Game : UIView {

		BOOL gameActive;
	
}
@property (nonatomic, assign) BOOL gameActive;

- (void)startGame;

@end
