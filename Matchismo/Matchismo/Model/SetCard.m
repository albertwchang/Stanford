//
//  SetCard.m
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize shape = _shape;
@synthesize color = _color;
@synthesize filling = _filling;
@synthesize itemQuantity = _itemQuantity;
@synthesize matches = _matches;

static const int MAX_ITEM_QUANTITY = 3;

//...CLASS-LEVEL METHODS
+(NSArray *) validShapes {
    return @[@"◼︎", @"✹", @"▲"];
}

+(NSArray *) validColors {
    //return @[[UIColor greenColor], [UIColor purpleColor], [UIColor redColor]];
    return @[[UIColor greenColor], [UIColor purpleColor], [UIColor redColor]];
}

+(NSArray *) validFillings {
    return @[@"shaded", @"solid", @"hallow"];
}

+(NSUInteger) maxItemQuantity {
    return MAX_ITEM_QUANTITY;
}

//...SETTERS
- (void) setShape:(NSString *)shape {
    if ([[SetCard validShapes] containsObject:shape])
        _shape = shape;
}

//- (void) setColor:(UIColor *)color {
- (void) setColor:(UIColor *)color {
    if ([[SetCard validColors] containsObject:color])
        _color = color;
}

- (void) setFill:(NSString *)filling {
    if ([[SetCard validFillings] containsObject:filling])
        _filling = filling;
}

- (void) setItemQuantity:(NSUInteger)itemQuantity {
    if ( (itemQuantity > 0) && (itemQuantity < MAX_ITEM_QUANTITY + 1) )
        _itemQuantity = itemQuantity;
}

//...GETTERS
- (NSString *)shape {
    return _shape ? _shape : @"?";
}

//- (UIColor *)color {
- (UIColor *)color {
    return _color ? _color : nil;
}

- (NSString *)filling {
    return _filling ? _filling : @"?";
}

- (NSUInteger)quantity {
    return _itemQuantity ? _itemQuantity : MAX_ITEM_QUANTITY;
}

//...PUT THIS IN THE SUPER CLASS AFTER EVERYTHING ELSE WORKS
- (NSUInteger) matches {
    return _matches;
}

- (NSString *)calculateShapes {
    NSString *cardTitle = @"";
    
    for (int i = 1; i <= self.itemQuantity; i++) {
        cardTitle = [cardTitle stringByAppendingString:self.shape];
    }
    
    return cardTitle;
}

- (SetCard *) contents {
    return self;
}

- (int)match:(NSMutableArray *)chosenCards { //...METHOD OVERRIDING
    
    int score = 0;
    self.matches = 0;
    BOOL shapeStatus;
    BOOL colorStatus;
    BOOL fillingStatus;
    BOOL itemQuantityStatus;
    
    for (int baseIndex = 0; baseIndex < chosenCards.count; baseIndex++) {
        SetCard *baseCard = [chosenCards objectAtIndex:baseIndex];
        int shapeScore = 0;
        int colorScore = 0;
        int fillingScore = 0;
        int itemQuantityScore = 0;
        
        for (int compareIndex = (baseIndex + 1); compareIndex < chosenCards.count; compareIndex++) {
            SetCard *compareCard = [chosenCards objectAtIndex:compareIndex];
 
            //...COMPARISON LOGIC
            if ([baseCard.shape isEqualToString:compareCard.shape]) {
                shapeScore += 1;
            } else if ([baseCard.color isEqual:compareCard.color]) {
                colorScore += 1;
            } else if ([baseCard.filling isEqualToString:compareCard.filling]) {
                fillingScore += 1;
            } else if (baseCard.itemQuantity == compareCard.itemQuantity) {
                itemQuantityScore += 1;
            }
            
            if ( (shapeScore == chosenCards.count) || (shapeScore == 0) )
                shapeStatus = YES;
            else shapeStatus = NO;
            if ( (colorScore == chosenCards.count) || (colorScore == 0) )
                colorStatus = YES;
            else colorStatus = NO;
            if ( (fillingScore == chosenCards.count) || (fillingScore == 0) )
                fillingStatus = YES;
            else fillingStatus = NO;
            if ( (itemQuantityScore == chosenCards.count) || (itemQuantityScore == 0) )
                itemQuantityStatus = YES;
            else itemQuantityStatus = NO;
        }
    }
    
    if (shapeStatus && colorStatus && fillingStatus && itemQuantityStatus) {
        score++;
        self.matches = chosenCards.count;
    }
    
    return score;
}

@end