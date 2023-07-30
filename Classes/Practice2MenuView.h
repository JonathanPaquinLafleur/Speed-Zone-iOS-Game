//
//  Practice2MenuView.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 31/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuController;

@interface Practice2MenuView : UIView {
	
	UIButton *practiceBackBtn;
	UIButton *practiceNextBtn;
	
	UIImageView *practiceTitle;
	UIImageView *practiceBackground;
	UIImageView *selectedGameBtn;
	
	MenuController *viewController;
	
}

@property (nonatomic, assign) MenuController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(MenuController *)aController;
- (void)toPracticeMenu;
- (void)toPractice3Menu;
- (void) initAnimation;

@end
