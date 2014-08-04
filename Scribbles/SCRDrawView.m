//
//  SCRDrawView.m
//  Scribbles
//
//  Created by KaL on 8/4/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "SCRDrawView.h"

@implementation SCRDrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // alloc/init the arrays
        self.scribbles = [@[]mutableCopy];
    
        // alloc/init the line color
        self.lineColor = [UIColor darkGrayColor];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    // this grabs our context layer to draw on
     CGContextRef context = UIGraphicsGetCurrentContext();
    
    // this sets stroke or fill colors that follows
    [self.lineColor set];
    // [[UIColor whiteColor]set];
    
    // edit the style of the scribbles
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    // to loop through every scribble
    for (NSDictionary *scribble in self.scribbles)
    {
        // changes the width of the scribble
        CGContextSetLineWidth(context,[scribble[@"width"]intValue]);
        
        NSArray *points = (NSArray *)scribble[@"points"];
        
        UIColor *lineColor = scribble[@"color"];
        [lineColor set];
        
        if (points.count > 0)
        {
            CGPoint startPoint = [points[0]CGPointValue];
            CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        }
        
        for (NSValue *pointVal in points)
        {
            CGPoint point = [pointVal CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        
        // this draws the context
        CGContextStrokePath(context);
        
    }
    
    
   

    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextAddEllipseInRect(context, CGRectMake(20, 20, 100, 100));
    //    // fill in  color
    //    [[UIColor redColor]set];
    //    // for new object
    //    CGContextFillPath(context);
    //
    //    CGContextAddEllipseInRect(context, CGRectMake(60, 20, 100, 100));
    //    [[UIColor colorWithWhite:1.0 alpha:0.5]set];
    //    // fill in the color
    //    CGContextFillPath(context);
    
    
    //    CGContextMoveToPoint(context, 10, 10);
    //    CGContextAddLineToPoint(context, 50, 50)
    //
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // changing the width
    int random = arc4random_uniform(20) + 5;
    
    self.currentscribble = [@{
                              @"color":self.lineColor,
                              @"points":[@[]mutableCopy],
                              @"width":@(random)
                              }mutableCopy];
    
    // adding current scribble to the array of scribble
    [self.scribbles addObject:self.currentscribble];
    
    [self scribbleWithTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self scribbleWithTouches:touches];
}

- (void)scribbleWithTouches:(NSSet *)touches
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        // add an object to scribbe array
        [self.currentscribble[@"points"] addObject:[NSValue valueWithCGPoint:location]];
    }
    
    // this runs the draw method again
    [self setNeedsDisplay];
}


@end





