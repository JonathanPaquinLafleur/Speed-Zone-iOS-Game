//
//  LogoView.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 29/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogoController;

@interface LogoView : UIView {

	UIImageView *logo;
	
	LogoController *viewController;
	
}

@property (nonatomic, assign) LogoController *viewController;

- (void) fadeOut;
- (id)initWithFrame:(CGRect)frame viewController:(LogoController *)aController;
	
@end
