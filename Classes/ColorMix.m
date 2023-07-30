//
//  ColorMix.m
//  SpeedZone
//
//  Created by Jonathan Lafleur on 03/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ColorMix.h"
#import <QuartzCore/QuartzCore.h>
#import "GameController.h"

@implementation ColorMix

@synthesize viewController;

- (void)dealloc {
    [super dealloc];
	[background release];
	[blue release];
	[green release];
	[yellow release];
	[red release];
	[mixedColors[0] release];
	[mixedColors[1] release];
	[mixedColors[2] release];
	[mixedColors[3] release];
}

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.viewController = aController;
		
		background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorMixBackground.png"]];	
		blue = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue.png"]];
		green = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"green.png"]];
		yellow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellow.png"]];
		red = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red.png"]];	
		mixedColors[0] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red-Yellow.png"]];	
		mixedColors[1] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellow-Green.png"]];
		mixedColors[2] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellow-Blue.png"]];
		mixedColors[3] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red-Blue.png"]];	
		
		red.userInteractionEnabled = YES;
		blue.userInteractionEnabled = YES;
		yellow.userInteractionEnabled = YES;
		green.userInteractionEnabled = YES;
		background.userInteractionEnabled = NO;
		mixedColors[0].userInteractionEnabled = NO;
		mixedColors[1].userInteractionEnabled = NO;
		mixedColors[2].userInteractionEnabled = NO;
		mixedColors[3].userInteractionEnabled = NO;
		
		mixedColors[0].center = CGPointMake(162,244);
		mixedColors[1].center = CGPointMake(162,244);
		mixedColors[2].center = CGPointMake(162,244);
		mixedColors[3].center = CGPointMake(162,244);
		background.center = CGPointMake(160,240);
		
		[self addSubview:background];	
		[self addSubview:mixedColors[0]];
		[self addSubview:mixedColors[1]];
		[self addSubview:mixedColors[2]];
		[self addSubview:mixedColors[3]];
		[self addSubview:green];
		[self addSubview:yellow];
		[self addSubview:blue];
		[self addSubview:red];	
		
	}
    return self;
}

- (void)startGame {
	
	centeredColors = 0;
	
	mixedColors[0].alpha = 0;
	mixedColors[1].alpha = 0;
	mixedColors[2].alpha = 0;
	mixedColors[3].alpha = 0;
	
	colorKey = (int)(arc4random()%4);

	mixedColors[colorKey].alpha = 1;
	
	red.center = CGPointMake(240,81);
	blue.center = CGPointMake(240,406);
	yellow.center = CGPointMake(81,406);
	green.center = CGPointMake(81,81);
	
	[self startAnimationTimer];
	[self hideMixedColor];
	
}

- (void)startAnimationTimer
{
	aniTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector: @selector(startAnimation) userInfo: nil repeats:YES];
}

- (void)startAnimation
{
	if([viewController timerActive]){
		
		if([self rightColorMix]){
			[aniTimer invalidate];
			[viewController displayWon];
		}
		
	}else{
		if(![viewController gameActive]){
			[aniTimer invalidate];
			[viewController displayFailed];
		}
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];

	if ([touch view] == red || [touch view] == blue || [touch view] == yellow || [touch view] == green) {
		if([touch view].center.x == 162 && [touch view].center.y == 244){
			centeredColors--;
		}
		CGPoint touchPoint = [touch locationInView:self];
		[self animateTouchAtPoint:touchPoint withView:[touch view]];
		return;
		
	}
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	if ([touch view] == red || [touch view] == blue || [touch view] == yellow || [touch view] == green) {
		CGPoint location = [touch locationInView:self];
		[touch view].center = location;		
		return;
	}
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	
	if ([touch view] == red || [touch view] == blue || [touch view] == yellow || [touch view] == green) {
		CGPoint touchPoint = [touch locationInView:self];
		
		dX = touchPoint.x - 162;
		dY = touchPoint.y - 244;
		distance = sqrtf(dX * dX + dY * dY);
		
		if(distance <= 40 && centeredColors <=1){
			centeredColors++;
			[self animateTouchEndedAtPoint:CGPointMake(162,244) withView:[touch view]];
		}else{
			if([touch view] == red){
				[self animateTouchEndedAtPoint:CGPointMake(240,81) withView:[touch view]];
			}
			if([touch view] == blue){
				[self animateTouchEndedAtPoint:CGPointMake(240,406) withView:[touch view]];
			}
			if([touch view] == yellow){
				[self animateTouchEndedAtPoint:CGPointMake(81,406) withView:[touch view]];
			}
			if([touch view] == green){
				[self animateTouchEndedAtPoint:CGPointMake(81,81) withView:[touch view]];
			}
			
		}
		return;
	}		
}

- (void)animateTouchAtPoint:(CGPoint)touchPoint withView:(UIView *)view {
	
	#define GROW_ANIMATION_DURATION_SECONDS 0.15
	
	NSValue *touchPointValue = [[NSValue valueWithCGPoint:touchPoint] retain];
	[UIView beginAnimations:nil context:touchPointValue];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.2, 1.2);
	view.transform = transform;
	view.center = [touchPointValue CGPointValue];
	[touchPointValue release];
	[UIView commitAnimations];
}

- (void)animateTouchEndedAtPoint:(CGPoint)touchPoint withView:(UIView *)view {
	
	#define GROW_ANIMATION_DURATION_SECONDS 0.15
	
	NSValue *touchPointValue = [[NSValue valueWithCGPoint:touchPoint] retain];
	[UIView beginAnimations:nil context:touchPointValue];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
	view.transform = transform;
	view.center = [touchPointValue CGPointValue];
	[touchPointValue release];
	[UIView commitAnimations];
}

- (void)hideMixedColor {
	
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationDuration:1.5];
	[UIView setAnimationDelay:1.5]; 
	mixedColors[colorKey].alpha = 0;
	[UIView commitAnimations];
}

- (BOOL)rightColorMix{
	
	if((colorKey == 0 && ((red.center.x == 162 && red.center.y == 244) && (yellow.center.x == 162 && yellow.center.y == 244)))){
		return YES;
	}else{
		if((colorKey == 1 && ((yellow.center.x == 162 && yellow.center.y == 244) && (green.center.x == 162 && green.center.y == 244)))){
			return YES;
		}else{
			if((colorKey == 2 && ((yellow.center.x == 162 && yellow.center.y == 244) && (blue.center.x == 162 && blue.center.y == 244)))){
				return YES;
			}else{
				if((colorKey == 3 && ((red.center.x == 162 && red.center.y == 244) && (blue.center.x == 162 && blue.center.y == 244)))){
					return YES;
				}else{
					return NO;
				}
			}
		}
	}
}

@end
