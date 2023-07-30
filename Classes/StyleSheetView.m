//
//  StyleSheetView.m
//  jeu
//
//  Created by Jonathan Lafleur on 10/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"
#import "StyleSheetView.h"
#import <QuartzCore/QuartzCore.h>

@implementation StyleSheetView

@synthesize viewController;

- (id)initWithFrame:(CGRect)frame viewController:(GameController *)aController {
    if (self = [super initWithFrame:frame]) {
		
		self.viewController = aController;
		
		testStyleSheet = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stylesheet1.png"]];
		
		countDown[0] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.png"]];
		countDown[0].center = self.center;
		countDown[0].alpha = 1;
		[countDown[0] setTransform:CGAffineTransformMakeScale(0.2,0.2)];
		
		countDown[1] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.png"]];
		countDown[1].center = self.center;
		countDown[1].alpha = 1;
		[countDown[1] setTransform:CGAffineTransformMakeScale(0.2,0.2)];
		
		countDown[2] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
		countDown[2].center = self.center;
		countDown[2].alpha = 1;
		[countDown[2] setTransform:CGAffineTransformMakeScale(0.2,0.2)];
		
		countDown[3] = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GO.png"]];
		countDown[3].center = self.center;
		countDown[3].alpha = 1;
		[countDown[3] setTransform:CGAffineTransformMakeScale(0.2,0.2)];
		
    }
    return self;
}

- (void)dealloc {
	[testStyleSheet release];
	[countDown[0] release];
	[countDown[1] release];
	[countDown[2] release];
	[countDown[3] release];
	[super dealloc];
}



- (void) countDown {
	if(countDownIterator >= 1 && countDownIterator < 5 ){
		countDown[countDownIterator -1].alpha = 1;
		[countDown[countDownIterator -1] setTransform:CGAffineTransformMakeScale(0.2,0.2)];
		[self addSubview:countDown[countDownIterator -1]];	
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
	    [countDown[countDownIterator -1] setTransform:CGAffineTransformMakeScale(1.5,1.5)];

		countDown[countDownIterator -1].alpha = 0;
		[UIView commitAnimations];
    } 
	if(countDownIterator == 6) {
		[countDownAnimationTimer invalidate];
		[viewController flipTransitionToGame];
	}
	countDownIterator = countDownIterator + 1;
}

- (void)countDownAnimation {
	countDownIterator = 0;
	countDownAnimationTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector: @selector(countDown) userInfo: nil repeats:YES];	
}

- (void) generateStyleSheet:(NSString *) gameName {
	
	
	if(gameName == @"ballHole" ||  gameName == @"eggFall" || gameName == @"driver" || gameName == @"crane" || gameName == @"cups" || gameName == @"calcul" || gameName == @"marathon" || gameName == @"rotator" || gameName == @"etchASketch" || gameName == @"findMe" || gameName == @"valve" || gameName == @"colorMix"){
	[self addSubview:testStyleSheet];
	}
    
	self.backgroundColor = [UIColor colorWithRed:((float)(arc4random()%255)/255.0) green:((float)(arc4random()%255)/255.0) blue:((float)(arc4random()%255)/255.0) alpha:1.0];
	
	[viewController whiteFadeIn];

}

@end
