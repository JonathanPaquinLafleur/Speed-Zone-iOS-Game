//
//  Calcul.h
//  SpeedZone
//
//  Created by Jonathan Lafleur on 21/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameController;

@interface Calcul : UIView {
    GameController *viewController;
	
	UIImageView *background;
	UIImageView *interogation;
	
	UIImage *zeroBtnImage;
	UIImage *oneBtnImage;
	UIImage *twoBtnImage;
	UIImage *threeBtnImage;
	UIImage *fourBtnImage;
	UIImage *fiveBtnImage;
	UIImage *sixBtnImage;
	UIImage *sevenBtnImage;
	UIImage *eightBtnImage;
	UIImage *nineBtnImage;
	
	NSString  *calculOperator;
	NSString  *operators[3];
	
	NSTimer *aniTimer;
	
	UILabel *calculLbl;
	UILabel *lcdLbl;
	
	UIButton *zeroBtn;
	UIButton *oneBtn;
	UIButton *twoBtn;
	UIButton *threeBtn;
	UIButton *fourBtn;
	UIButton *fiveBtn;
	UIButton *sixBtn;
	UIButton *sevenBtn;
	UIButton *eightBtn;
	UIButton *nineBtn;
	
	int number1;
	int number2;
	int resultInt;
	int equationLength;
	
}

@property (nonatomic, assign) GameController *viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController;
- (void)startGame;
- (void)startAnimationTimer;
- (void)startAnimation;
- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame imageNormal:(UIImage*)imageNormal;
- (void) zero;
- (void) one;
- (void) two;
- (void) three;
- (void) four;
- (void) five;
- (void) six;
- (void) seven;
- (void) eight;
- (void) nine;

@end