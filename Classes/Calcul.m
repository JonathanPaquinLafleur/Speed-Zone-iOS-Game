//
//  Calcul.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 21/03/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Calcul.h"
#import "GameController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation Calcul

@synthesize viewController;

- (CGFloat) DegreesToRadians:(CGFloat) degrees {
	return degrees * M_PI / 180;
}

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
	self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calculBackground.png"]];
		
		interogation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"calculInterogation.png"]];
		
		zeroBtnImage = [UIImage imageNamed:@"calculBtn0.png"];
		CGRect zeroBtnFrame = CGRectMake(170,180,71,71);
		zeroBtn = [self buttonWithTitle:nil target:self selector:@selector(zero) frame:zeroBtnFrame  imageNormal:zeroBtnImage];
		
		oneBtnImage = [UIImage imageNamed:@"calculBtn1.png"];
		CGRect oneBtnFrame = CGRectMake(170,180+(75*1),71,71);
		oneBtn = [self buttonWithTitle:nil target:self selector:@selector(one) frame:oneBtnFrame  imageNormal:oneBtnImage];
		
		twoBtnImage = [UIImage imageNamed:@"calculBtn2.png"];
		CGRect twoBtnFrame = CGRectMake(170,180+(75*2),71,71);
		twoBtn = [self buttonWithTitle:nil target:self selector:@selector(two) frame:twoBtnFrame  imageNormal:twoBtnImage];
		
		threeBtnImage = [UIImage imageNamed:@"calculBtn3.png"];
		CGRect threeBtnFrame = CGRectMake(170,180+(75*3),71,71);
		threeBtn = [self buttonWithTitle:nil target:self selector:@selector(three) frame:threeBtnFrame  imageNormal:threeBtnImage];
		
		fourBtnImage = [UIImage imageNamed:@"calculBtn4.png"];
		CGRect fourBtnFrame = CGRectMake(170-(75*1),180+(75*1),71,71);
		fourBtn = [self buttonWithTitle:nil target:self selector:@selector(four) frame:fourBtnFrame  imageNormal:fourBtnImage];
		
		fiveBtnImage = [UIImage imageNamed:@"calculBtn5.png"];
		CGRect fiveBtnFrame = CGRectMake(170-(75*1),180+(75*2),71,71);
		fiveBtn = [self buttonWithTitle:nil target:self selector:@selector(five) frame:fiveBtnFrame  imageNormal:fiveBtnImage];
		
		sixBtnImage = [UIImage imageNamed:@"calculBtn6.png"];
		CGRect sixBtnFrame = CGRectMake(170-(75*1),180+(75*3),71,71);
		sixBtn = [self buttonWithTitle:nil target:self selector:@selector(six) frame:sixBtnFrame  imageNormal:sixBtnImage];
		
		sevenBtnImage = [UIImage imageNamed:@"calculBtn7.png"];
		CGRect sevenBtnFrame = CGRectMake(170-(75*2),180+(75*1),71,71);
		sevenBtn = [self buttonWithTitle:nil target:self selector:@selector(seven) frame:sevenBtnFrame  imageNormal:sevenBtnImage];
		
		eightBtnImage = [UIImage imageNamed:@"calculBtn8.png"];
		CGRect eightBtnFrame = CGRectMake(170-(75*2),180+(75*2),71,71);
		eightBtn = [self buttonWithTitle:nil target:self selector:@selector(eight) frame:eightBtnFrame  imageNormal:eightBtnImage];
		
		nineBtnImage = [UIImage imageNamed:@"calculBtn9.png"];
		CGRect nineBtnFrame = CGRectMake(170-(75*2),180+(75*3),71,71);
		nineBtn = [self buttonWithTitle:nil target:self selector:@selector(nine) frame:nineBtnFrame  imageNormal:nineBtnImage];
		
		calculLbl = [[UILabel alloc] initWithFrame:CGRectMake(10,80,210,50)];
		calculLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:60];
		calculLbl.textColor = [UIColor blackColor];
		calculLbl.backgroundColor = [UIColor clearColor];
		calculLbl.textAlignment = UITextAlignmentLeft;
		[calculLbl setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90])];
		
		lcdLbl = [[UILabel alloc] initWithFrame:CGRectMake(178,330,190,40)];
		lcdLbl.font = [UIFont boldSystemFontOfSize:40];
		lcdLbl.textColor = [UIColor blackColor];
		lcdLbl.backgroundColor = [UIColor clearColor];
		lcdLbl.textAlignment = UITextAlignmentRight;
		[lcdLbl setTransform:CGAffineTransformMakeRotation([self DegreesToRadians:90])];
		
		operators[0] = @"+";
		operators[1] = @"*";
		operators[2] = @"/";
		
	}
    return self;
}

- (void)dealloc {
	[background release];
	[interogation release];
	[zeroBtn release];
	[oneBtn release];
	[twoBtn release];
	[threeBtn release];
	[fourBtn release];
	[fiveBtn release];
	[sixBtn release];
	[sevenBtn release];
	[eightBtn release];
	[nineBtn release];
    [super dealloc];
}

- (void)startGame
{
	calculOperator = operators[arc4random()%3];
	
	if([calculOperator isEqualToString:@"+"]){
		number1 = (arc4random()%11)+1;
		number2 = (arc4random()%11)+1;
		resultInt = number1+number2;
	}
	if([calculOperator isEqualToString:@"*"]){
		number1 = (arc4random()%6)+1;
		number2 = (arc4random()%6)+1;
		resultInt = number1*number2;
	}
	if([calculOperator isEqualToString:@"/"]){
		number1=3;
		number2=3;
		while(((fmod(number1,2)!=0)||(fmod(number2,2)!=0))||(number1 < number2)||(number1==6 && number2==4)){
			number1 = (arc4random()%6)+2;
			number2 = (arc4random()%6)+2;
		}
		resultInt = number1/number2;
	}

	equationLength = [[NSString stringWithFormat:@"%d",number1] length] + [[NSString stringWithFormat:@"%d",number2] length];
	interogation.center = CGPointMake(117,150+(40*(equationLength-2)));

	lcdLbl.text = NULL;
	calculLbl.text = [NSString stringWithFormat:@"%d%@%d=",number1,calculOperator,number2];
	
	[self addSubview:background];
    [self addSubview:interogation];
	[self addSubview:calculLbl];
	[self addSubview:lcdLbl];
	[self addSubview:zeroBtn];
	[self addSubview:oneBtn];
	[self addSubview:twoBtn];
	[self addSubview:threeBtn];
	[self addSubview:fourBtn];
	[self addSubview:fiveBtn];
	[self addSubview:sixBtn];
	[self addSubview:sevenBtn];
	[self addSubview:eightBtn];
	[self addSubview:nineBtn];

	[self startAnimationTimer];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
}

- (void)startAnimation
{
	if([viewController timerActive]){
		if([lcdLbl.text length] == [[NSString stringWithFormat:@"%d",resultInt] length]){
			if(resultInt == [lcdLbl.text intValue]){
				[aniTimer invalidate];
				[viewController displayWon];
			}else{
				[aniTimer invalidate];
				[viewController displayFailed];
			}
		}
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[viewController displayFailed];
		}
	}
}

- (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)inSelector frame:(CGRect)frame imageNormal:(UIImage*)imageNormal{
	UIButton *button = [[UIButton alloc] initWithFrame:frame];
	button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	UIImage *newImageNormal = [imageNormal stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	[button setImage:newImageNormal forState:UIControlStateNormal];
	[button addTarget:target action:inSelector forControlEvents:UIControlEventTouchDown];
	[button setBackgroundColor:[UIColor clearColor]];
    [button setAdjustsImageWhenHighlighted:YES];
    return button;
}

- (void) zero{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"0"];}else{lcdLbl.text = @"0";}}
- (void) one{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"1"];}else{lcdLbl.text = @"1";}}
- (void) two{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"2"];}else{lcdLbl.text = @"2";}}
- (void) three{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"3"];}else{lcdLbl.text = @"3";}}
- (void) four{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"4"];}else{lcdLbl.text = @"4";}}
- (void) five{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"5"];}else{lcdLbl.text = @"5";}}
- (void) six{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"6"];}else{lcdLbl.text = @"6";}}
- (void) seven{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"7"];}else{lcdLbl.text = @"7";}}
- (void) eight{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"8"];}else{lcdLbl.text = @"8";}}
- (void) nine{if(lcdLbl.text != NULL){lcdLbl.text = [NSString stringWithFormat:@"%@%@",lcdLbl.text, @"9"];}else{lcdLbl.text = @"9";}}

@end