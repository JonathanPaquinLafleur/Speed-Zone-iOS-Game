//
//  practiceMenuController.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 30/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpeedZoneAppDelegate,PracticeMenuView;

@interface PracticeMenuController : UIViewController {

	SpeedZoneAppDelegate *appDelegate;
	PracticeMenuView *practiceMenuView;
	
}

@property (nonatomic, assign) SpeedZoneAppDelegate *appDelegate;

- init:(SpeedZoneAppDelegate *) appDel;

@end
