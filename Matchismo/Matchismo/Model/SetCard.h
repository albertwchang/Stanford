//
//  SetCard.h
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSString *shape;
//@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *filling;
@property (nonatomic) NSUInteger itemQuantity;

+(NSArray *) validShapes;
+(NSArray *) validColors;
+(NSArray *) validFillings;
+(NSUInteger) maxItemQuantity;
-(NSString *) calculateShapes;
@end
