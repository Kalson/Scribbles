//
//  SCRScrollView.h
//  Scribbles
//
//  Created by KaL on 8/4/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import <UIKit/UIKit.h>

// forward deleclartion - informing the compiler that you will define it later (i.e. for us it's at the bottom)
@protocol SCRScrollViewDelegate;




@interface SCRScrollView : UIView

@property (nonatomic) float maxWidth;
@property (nonatomic) float minWidth;
@property (nonatomic) float currentWidth;

// potentially will use to change the slider color based on selected color
@property (nonatomic) UIColor *lineColor;

@property (nonatomic,assign) id <SCRScrollViewDelegate> delegate;

@end








@protocol SCRScrollViewDelegate <NSObject>

- (void)updateLineWidth:(float)lineWidth;

//@optional
//
//- (void)optionalMethod;

@end