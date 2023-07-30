//
//  LogoView.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LogoView.h"
#import "LogoController.h"
#import <QuartzCore/QuartzCore.h>

@implementation LogoView

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame viewController:(LogoController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;	
		self.backgroundColor = [UIColor blackColor];
		logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
		logo.center = self.center;	
		[self addSubview:logo ];
        }
    return self;
}


- (void)dealloc {
	[logo release];
    [super dealloc];
}

- (void)fadeOut {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:2];
	logo.alpha = 0;
	[UIView commitAnimations];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	[viewController logoToMainMenu];
}

@end
