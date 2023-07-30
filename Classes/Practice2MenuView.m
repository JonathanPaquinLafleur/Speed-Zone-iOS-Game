//
//  Practice2MenuView.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 31/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Practice2MenuView.h"
#import "MenuController.h"
#import <QuartzCore/QuartzCore.h>

@implementation Practice2MenuView

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame viewController:(MenuController *)aController {
    self = [super initWithFrame:frame];
	if (self != nil) {
		self.viewController = aController;		
		
		self.backgroundColor = [UIColor clearColor];
		
		practiceTitle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"practiceTitle.png"]];
		practiceTitle.center = CGPointMake(275,240);
		[self addSubview:practiceTitle];
		
		CGRect practiceBackBtnFrame = CGRectMake(244,25,63,70);
		practiceBackBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toPracticeMenu) frame:practiceBackBtnFrame];
		[self addSubview:practiceBackBtn];
		
		CGRect practiceNextBtnFrame = CGRectMake(244,385,63,70);
		practiceNextBtn = [viewController buttonWithTitle:nil target:self selector:@selector(toPractice3Menu) frame:practiceNextBtnFrame];
		[self addSubview:practiceNextBtn];
		
		practiceBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"practiceBackground.png"]];
		practiceBackground.center = CGPointMake(115,240);
		practiceBackground.alpha = 0.85;
		[self addSubview:practiceBackground];
		
		selectedGameBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedGameBtn.png"]];
		selectedGameBtn.alpha = 0;
		[self addSubview:selectedGameBtn];
		
		//Games

		
    }
    return self;
}

- (void)dealloc {
	[practiceBackBtn release];
	[practiceNextBtn release];
	[practiceTitle release];
	[practiceBackground release];
	[selectedGameBtn release];
    [super dealloc];
}

- (void) initAnimation {

}

- (void)toPracticeMenu{
	[viewController moveToRightView:@"PracticeMenuView"];
}

- (void)toPractice3Menu{
	[viewController moveToLeftView:@"Practice3MenuView"];
}

@end
