//
//  AppController.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "LogoController.h"

@implementation AppController

@synthesize window;
@synthesize logoController;

- (id)init {
   	if (self = [super init]) {
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[logoController release];
    [window release];
    [super dealloc];
}

- (void)startGame {
	logoController = [[LogoController alloc] init];
    [window addSubview:logoController.view];
}


@end
