//
//  practiceMenuController.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 30/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PracticeMenuController.h"
#import "PracticeMenuView.h"
#import "SpeedZoneAppDelegate.h"

@implementation PracticeMenuController

@synthesize appDelegate;

- init:(SpeedZoneAppDelegate *) appDel {
	if (self = [super init]) {
		self.appDelegate = appDel;		
	}
	return self;
}

- (void)viewDidLoad {
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	practiceMenuView = [[PracticeMenuView alloc] initWithFrame:applicationFrame viewController:self];
	[self.view addSubview:practiceMenuView];
	
	[practiceMenuView showFromLeft];
}


/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
