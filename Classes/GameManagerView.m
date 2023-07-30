//
//  GameManager.m
//  jeu
//
//  Created by Jonathan Lafleur on 08/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "GameManagerView.h"
#import "jeuViewController.h"

@implementation GameManagerView

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame viewController:(jeuViewController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
    }
    return self;
}

- (void)dealloc {
	[viewController release];
	[super dealloc];
}

- (void)displayWon {
	[self setOpaque:YES];
    UIImageView *levelBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goodhole.png"]];
    levelBackView.center = self.center;
    levelBackView.opaque = YES;
    [self addSubview:levelBackView];
    [levelBackView release];
	
}



@end
