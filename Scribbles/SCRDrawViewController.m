//
//  SCRDrawViewController.m
//  Scribbles
//
//  Created by KaL on 8/4/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "SCRDrawViewController.h"
#import "SCRDrawView.h"
#import "SCRScrollView.h"

@interface SCRDrawViewController ()<SCRScrollViewDelegate>

@end

@implementation SCRDrawViewController
{
    UIImage *image;
    UIButton *drawStyleButton;
    UIButton *scribbleButton;
    UIButton *linesButton;
    NSMutableArray *buttons;
    NSArray *colors;
    BOOL colorChoicesOpen;
    float priority;
    UIView *scrollView;
    UIView *lineWidthSize;
    UIButton *centerButton;
    UIButton *resetButton;
    
    SCRScrollView *lineSlider;
   
}

///// add reset button (clear the screen of scribbles)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
        // setting the view controller to be the draw view
        self.view = [[SCRDrawView alloc]initWithFrame:self.view.frame];
        
//        self.view = [[SCRScrollView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 210, 50, 200)];
        
        buttons = [@[]mutableCopy];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
//    chooseColor = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 60 / 2.0), SCREEN_HEIGHT - 70, 60, 60)];
//    chooseColor.layer.cornerRadius = 30;
//    chooseColor.backgroundColor = colors[0];
//    [chooseColor addTarget:self action:@selector(showColorChoices) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:chooseColor];
//    self.view.lineColor = colors[0];
    
    
    
    colors = [@[
                [UIColor cyanColor],
                [UIColor colorWithRed:0.000f green:1.000f blue:0.604f alpha:1.0f],
                [UIColor colorWithRed:0.800f green:0.992f blue:0.204f alpha:1.0f],
                [UIColor yellowColor],
                [UIColor orangeColor],
                [UIColor colorWithRed:1.000f green:0.000f blue:0.333f alpha:1.0f],
                [UIColor purpleColor],
                [UIColor blueColor]
                
                ]mutableCopy];
  
    int buttonCount = 8;
    int radius = 55;
    float angleBetweenButtons = (2 * M_PI) / buttonCount;
    float x = 110;
    float y = 350;
    CGAffineTransform rotationTransform;
    
    // for button in buttons array
    
    for (UIButton * buttonCircle in buttons)
    {
        NSInteger i = [buttons indexOfObject:buttonCircle];
        
        x = radius + cosf(i * angleBetweenButtons) * radius;
        y = radius + sinf(i * angleBetweenButtons) * radius;
        rotationTransform = CGAffineTransformIdentity;
        rotationTransform = CGAffineTransformRotate(rotationTransform, (i * angleBetweenButtons));
        
        buttonCircle.center = CGPointMake( x+105 , y+430);
        buttonCircle.transform = rotationTransform;
        [self.view addSubview:buttonCircle];
        
    }
    
    //big parent (i.e. a drawer opens to show you options
    drawStyleButton = [[UIButton alloc]initWithFrame:CGRectMake(270, SCREEN_HEIGHT - 50, 40, 40)];
    [drawStyleButton addTarget:self action:@selector(hidesButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    drawStyleButton.layer.borderWidth = 1;
    drawStyleButton.layer.cornerRadius = 20;
    image = [UIImage imageNamed:@"scribble_button"];
    [drawStyleButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.view addSubview:drawStyleButton];
    
    // first option
    scribbleButton = [[UIButton alloc]initWithFrame:CGRectMake(275, SCREEN_HEIGHT - 90, 30, 30)];
    [scribbleButton addTarget:self action:@selector(scribbleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    scribbleButton.layer.borderWidth = 1;
    scribbleButton.layer.cornerRadius = 15;
    [self.view addSubview:scribbleButton];
    image = [UIImage imageNamed:@"scribble_button"];
    [scribbleButton setBackgroundImage:image forState:UIControlStateNormal];
     scribbleButton.hidden = YES;
    
    // second option
    linesButton = [[UIButton alloc]initWithFrame:CGRectMake(275, SCREEN_HEIGHT - 130, 30, 30)];
    [linesButton addTarget:self action:@selector(linesButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    linesButton.layer.borderWidth = 1;
    linesButton.layer.cornerRadius = 15;
    [self.view addSubview:linesButton];
    image = [UIImage imageNamed:@"lines_button"];
    [linesButton setBackgroundImage:image forState:UIControlStateNormal];
    linesButton.hidden = YES;
    
    centerButton = [[UIButton alloc]initWithFrame:CGRectMake(140, SCREEN_HEIGHT - 105, 40, 40)];
    [centerButton addTarget:self action:@selector(showColorChoices) forControlEvents:UIControlEventTouchUpInside];
    centerButton.layer.cornerRadius = 20;
    centerButton.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:centerButton];
    
    
    lineWidthSize = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2, 2)];
    lineWidthSize.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:lineWidthSize];
    
    UIButton *openLineWidthSlider = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 50, 40, 40)];
    openLineWidthSlider.layer.cornerRadius = 20;
    openLineWidthSlider.layer.borderWidth = 1;
    openLineWidthSlider.layer.borderColor = [[UIColor blackColor]CGColor];
    
    [openLineWidthSlider addTarget:self action:@selector(openSlider) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:openLineWidthSlider];
    lineWidthSize.center = openLineWidthSlider.center;
    
    resetButton = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 320, 40, 40)];
    [resetButton addTarget:self action:@selector(resetButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    resetButton.backgroundColor = [UIColor redColor];
    resetButton.layer.cornerRadius = 20;
    [self.view addSubview:resetButton];
    resetButton.hidden = YES;

}

- (void)resetButtonWasPressed
{
    [self.view.scribbles removeAllObjects];
    [self.view setNeedsDisplay];
}


- (void)openSlider
{
    if (lineSlider)
    {
        // Right lets close everything up so they don't see any of these options
        [lineSlider removeFromSuperview];
        resetButton.hidden = YES;
        lineSlider = nil;
        // get the hell out of here so you don't recreate and therefore reshow the lineslider
        return; // escape from this method
    }
    
    // At this point, it means that we're opening and showing all the options (both line width & reset button)
    lineSlider = [[SCRScrollView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 270, 40, 200)];
    lineSlider.currentWidth = self.view.lineWidth;
    lineSlider.delegate = self;
    [self.view addSubview:lineSlider];
    resetButton.hidden = NO;
}

- (void)hideColorChoices
{
    for (UIButton *colorButton in buttons) {
        NSInteger index = [buttons indexOfObject:colorButton];
        [UIView animateWithDuration:0.2 delay:0.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
            colorButton.center = centerButton.center;
        } completion:^(BOOL finished) {
            [colorButton removeFromSuperview];
        }];
    }
    [buttons removeAllObjects];
    colorChoicesOpen = NO;
}

- (void)showColorChoices
{
    if (colorChoicesOpen) {
        [self hideColorChoices];
        return;
    }
    
    for (UIColor *color in colors)
    {
        NSInteger index = [colors indexOfObject:color];
        UIButton *colorButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [buttons addObject:colorButton];
        colorButton.center = centerButton.center;
        colorButton.backgroundColor = color;
        colorButton.layer.cornerRadius = 20;
        
        [colorButton addTarget:self action:@selector(changelineColor:) forControlEvents:UIControlEventTouchUpInside];
        
        float radius = 60;
        float mpi = M_PI/180;
        float angle = 360/colors.count;
        float radians = angle * mpi;
        
        float moveX = centerButton.center.x + sinf(radians * index) * radius;
        float moveY = centerButton.center.y + cosf(radians * index) * radius;
        
        [UIView animateWithDuration:0.2 delay:0.05 * index options:UIViewAnimationOptionAllowUserInteraction animations:^{
            colorButton.center = CGPointMake(moveX, moveY);
        } completion:^(BOOL finished) {
            
        }];
        [self.view insertSubview:colorButton atIndex:0];
    }
    colorChoicesOpen = YES;
}

- (void)updateLineWidth:(float)lineWidth
{
    self.view.lineWidth = lineWidth;
    
    CGPoint center = lineWidthSize.center;
    lineWidthSize.frame = CGRectMake(0, 0, lineWidth * 2, lineWidth * 2);
    lineWidthSize.center = center;
    lineWidthSize.layer.cornerRadius = lineWidth;

}


- (void)hidesButtonWasPressed
{
    if ([scribbleButton isHidden] && [linesButton isHidden])
    {
        scribbleButton.hidden = NO;
        linesButton.hidden = NO;
    } else {
        scribbleButton.hidden = YES;
        linesButton.hidden = YES;
    }
}

- (void)scribbleButtonPressed
{
    self.view.isScribbleMode = YES;
    
    [self hideDrawStyleButtons];
    
    image = [UIImage imageNamed:@"scribble_button"];
    [drawStyleButton setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)hideDrawStyleButtons
{
    scribbleButton.hidden = YES;
    linesButton.hidden = YES;
}

- (void)linesButtonWasPressed
{
    self.view.isScribbleMode = NO;
    
    [self hideDrawStyleButtons];
    
    image = [UIImage imageNamed:@"lines_button"];
    [drawStyleButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
}

//- (void)changelineColor:(UIButton *)miniColorChangeButton
- (void)changelineColor:(UIButton *)miniColorChangeButton
{
    SCRDrawView *view = (SCRDrawView *)self.view;
    view.lineColor = miniColorChangeButton.backgroundColor;
    centerButton.backgroundColor = miniColorChangeButton.backgroundColor;
    [view setNeedsDisplay];
}

- (BOOL)prefersStatusBarHidden{return YES;}

@end
