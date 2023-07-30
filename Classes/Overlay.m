//
//  Overlay.m
//  jeu
//
//  Created by Jonathan Lafleur on 26/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Overlay.h"
#import "jeuViewController.h"

@implementation Overlay

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame viewController:(jeuViewController *)aController alpha:(float)initialAlpha {
    self = [super initWithFrame:frame];
	if (self != nil) {
		self.viewController = aController;
		[self setupSubviewsWithAlpha:initialAlpha ];  
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}

- (void)setupSubviewsWithAlpha:(float)initialAlpha {  
	
	whiteFade = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteFade.png"]];
	whiteFade.alpha = initialAlpha;
	[self addSubview:whiteFade];
	
	winnerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainTitle.png"]];
	winnerImg.alpha = 0;
	winnerImg.center = CGPointMake(160,240);
	[self addSubview:winnerImg];
}

- (void)playWhiteFadeOut{
	[UIView beginAnimations:@"whiteFadeOut" context:NULL];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 1;
	[UIView commitAnimations];	
}

- (void)playWhiteFadeIn{
	[UIView beginAnimations:@"whiteFadeIn" context:NULL];
	[UIView setAnimationDuration:1];
	whiteFade.alpha = 0;
	[UIView commitAnimations];	
}

@end
