//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Albert Chang on 1/21/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController
//-(void)setDisplay:(NSString *)imageName withTitle:(NSString *)title withUIButton:(UIButton *)button;

// PROTECTED FOR SUBCLASSES.  // ABSTRACT CLASS
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeButton;

- (Deck *) createDeck;
- (void) updateUI;
- (NSString *)titleForCard:(Card *)selectedCard;
- (UIImage *)imageForCard:(Card *)selectedCard;
@end
