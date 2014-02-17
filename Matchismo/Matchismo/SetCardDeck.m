//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if(self) {
        for (NSString *shape in [SetCard validShapes]) {
            for (UIColor *color in [SetCard validColors]) {
                for(NSString *filling in [SetCard validFillings]) {
                    for (int count = 1; count <= [SetCard maxItemQuantity]; count++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.color = color;
                        card.filling = filling;
                        card.itemQuantity = count;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
