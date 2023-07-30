//
//  LogoController.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LogoController.h"
#import "LogoView.h"
#import "SpeedZoneAppDelegate.h"
#import "AudioQueueObject.h"
#import "AudioPlayer.h"

@implementation LogoController

- init:(SpeedZoneAppDelegate *) _appDel withWindow:(UIWindow *) _window {
	if (self = [super init]) {
		
		firstTap = YES;
		
		appDel = _appDel;
		window = _window;
		
		logoClick = [[AudioPlayer alloc] initWithName:@"logoClick"];
		
		[window addSubview:self.view];
	}
	return self;
}

- (void)viewDidLoad {

	[window bringSubviewToFront:self.view];
	
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	logoView = [[LogoView alloc] initWithFrame:applicationFrame viewController:self];
	[self.view addSubview:logoView];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[LogoView release];
	[ripple release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if(firstTap) {
		firstTap = NO;
		[logoClick setAudioVolume:1.0];
		[logoClick play];
		[logoView fadeOut];
	}
	for (UITouch *touch in touches) {
	CGPoint touchPoint = (CGPoint)[touch locationInView:self.view];
	ripple = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ripple.png"]];
	[ripple setTransform:CGAffineTransformMakeScale(0.1,0.1)];
	ripple.center = touchPoint;
	[self.view addSubview:ripple];
	[self growRipple];
	}
	
}

- (void) growRipple {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5];
	[ripple setTransform:CGAffineTransformMakeScale(1,1)];;
	ripple.alpha = 0;
	[UIView commitAnimations];
}

- (void)logoToMainMenu {
	[self.view removeFromSuperview];
	[appDel showMenuWithName:@"MainMenuView"];
}

@end
