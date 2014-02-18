//
//  GameView.h
//  Matchismo
//
//  Created by albertwchang on 2/17/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grid.h"
#import "Card.h"

@interface GameView : UIView
@property (nonatomic, strong) NSMutableArray *cards;

//superclass method
- (UIView *)buildCardView:(Card *)currentCard;

//add swipe gesture in both subclasses of the view CONTROLLERS - set and flip
@end