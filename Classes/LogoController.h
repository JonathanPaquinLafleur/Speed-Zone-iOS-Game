//
//  LogoController.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogoView,SpeedZoneAppDelegate,AudioPlayer,AudioQueueObject;

@interface LogoController :  UIViewController {

	IBOutlet UIWindow *window;
	
	BOOL firstTap;
	
	LogoView *logoView;
	SpeedZoneAppDelegate *appDel;
	
	UIImageView	*ripple;
	
	AudioPlayer		*logoClick;
}

- (void)logoToMainMenu;
- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window;
- (void) growRipple;

@end
