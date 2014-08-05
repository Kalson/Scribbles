//
//  SCRDrawView.h
//  Scribbles
//
//  Created by KaL on 8/4/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCRDrawView : UIView

//@property (nonatomic) NSMutableArray *scribblePoints;
@property (nonatomic) NSMutableArray *scribbles;
@property (nonatomic) NSMutableDictionary *currentscribble;

@property (nonatomic) UIColor *lineColor;
@property (nonatomic) int lineWidth;

@property (nonatomic) BOOL isScribbleMode;
@end
