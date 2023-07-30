//
//  AppController.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogoController;

@interface AppController :  UIViewController {
	
	LogoController *logoController;
	
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) LogoController *logoController;

- (void)startGame;

@end
