//
//  GameManager.h
//  jeu
//
//  Created by Jonathan Lafleur on 08/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class jeuViewController;

@interface GameManagerView : UIView {
	jeuViewController *viewController;
}

@property (nonatomic, assign) jeuViewController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(jeuViewController *)aController;
- (id)displayWon;

@end
