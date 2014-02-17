//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self updateUI];
}

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        SEL contentsSelector = @selector(contents);
        
        if ( [card respondsToSelector:contentsSelector] ) {
            if ([card.contents isMemberOfClass:[SetCard class]]) {
                SetCard *currentCard = (SetCard *)card.contents;
                NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:currentCard.calculateShapes];
                NSDictionary *contentAttributes = @{
                                                    NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                                    NSForegroundColorAttributeName : [UIColor blackColor],
                                                    NSStrokeWidthAttributeName : @0,
                                                    NSStrokeColorAttributeName : [UIColor blackColor],
                                                };

                //...1 = SOLID
                if ( [currentCard.filling isEqualToString:SetCard.validFillings[1]] )
                    contentAttributes = @{
                                          NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                          NSForegroundColorAttributeName : currentCard.color,
                                          NSStrokeWidthAttributeName : @-5,
                                          NSStrokeColorAttributeName : currentCard.color,
                                        };
                
                //...2 = HALLOW
                //NSStrokeWidthValue (for hallow symbols)
                //NSForegroundAttributeName (color + alpha)
                else if ( [currentCard.filling isEqualToString:SetCard.validFillings[2]] )
                    contentAttributes = @{
                                          NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                          NSForegroundColorAttributeName : currentCard.color,
                                          NSStrokeWidthAttributeName : @0,
                                          NSStrokeColorAttributeName : currentCard.color,
                                          };
                
                //...3 = SHADED
                else if ( [currentCard.filling isEqualToString:SetCard.validFillings[0]] )
                    contentAttributes = @{
                                          NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                          NSForegroundColorAttributeName : [currentCard.color colorWithAlphaComponent:0.3],
                                          NSStrokeWidthAttributeName : @-5,
                                          NSStrokeColorAttributeName : currentCard.color,
                                          };

                [content setAttributes:contentAttributes
                                 range:NSMakeRange( 0, currentCard.calculateShapes.length )];
                
                [cardButton setAttributedTitle:content
                                      forState:UIControlStateNormal];
                [cardButton setBackgroundImage:[self imageForCard:card]
                                      forState:UIControlStateNormal];
                cardButton.enabled = !card.isMatched;
            }
        }
    } //END FOR LOOP
 
    self.gameModeButton.enabled = !self.game.gameStarted;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)selectedCard {
    return selectedCard.contents;
}

- (UIImage *)imageForCard:(Card *)selectedCard {
    return [UIImage imageNamed:@"cardfront"];
}

@end
