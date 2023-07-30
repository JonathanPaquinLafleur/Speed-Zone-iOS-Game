//
//  Overlay.h
//  jeu
//
//  Created by Jonathan Lafleur on 26/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class jeuViewController;

@interface Overlay : UIImageView {

	jeuViewController *viewController;
	
	UIImageView *whiteFade;
	UIImageView *winnerImg;
}

@property (nonatomic, retain) jeuViewController *viewController;

- (id) initWithFrame:(CGRect)frame viewController:(jeuViewController *)aController alpha:(float)initialAlpha;
- (void)setupSubviewsWithAlpha:(float)initialAlpha; 
- (void)playWhiteFadeOut;
- (void)playWhiteFadeIn;

@end
