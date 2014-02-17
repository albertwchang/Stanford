//
//  Deck.h
//  Matchismo
//
//  Created by Albert Chang on 1/22/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(bool)atTop;
-(void)addCard:(Card *)card;
-(Card *) drawRandomCard;

@end
