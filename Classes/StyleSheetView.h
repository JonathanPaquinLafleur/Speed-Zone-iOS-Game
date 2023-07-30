//
//  StyleSheetView.h
//  jeu
//
//  Created by Jonathan Lafleur on 10/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface StyleSheetView : UIView {
	
	GameController *viewController;

	NSTimer *countDownAnimationTimer;
	
	int countDownIterator;
	
	UIImageView *countDown[4];
		
	UIImageView *testStyleSheet;
	
}

@property (nonatomic, assign) GameController *viewController;


- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)countDownAnimation;
- (void)countDown;
- (void) generateStyleSheet:(NSString *) gameName;

@end
