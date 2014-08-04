//
//  SCRDrawViewController.m
//  Scribbles
//
//  Created by KaL on 8/4/14.
//  Copyright (c) 2014 Kalson Kalu. All rights reserved.
//

#import "SCRDrawViewController.h"
#import "SCRDrawView.h"

@interface SCRDrawViewController ()

@end

@implementation SCRDrawViewController
{
    UIImage *image;
    UIButton *hideButtons;
    UIButton *scribbleButton;
    UIButton *linesButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
        // setting the view controller to be the draw view
        self.view = [[SCRDrawView alloc]initWithFrame:self.view.frame];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    
    
    NSArray *colors = @[
                        [UIColor orangeColor],
                        [UIColor colorWithRed:1.000f green:0.000f blue:0.333f alpha:1.0f],
                        [UIColor purpleColor],
                        [UIColor blueColor],
                        [UIColor cyanColor]
                        ];
    
    for (UIColor *color in colors)
    {
        // index for each color
        NSInteger index = [colors indexOfObject:color];
        
        UIButton *colorButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10 + (50 * index), 40, 40)];
        colorButton.backgroundColor = color;
        colorButton.layer.cornerRadius = 20;
        [colorButton addTarget:self action:@selector(changelineColor:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:colorButton];
        
    }
    
    hideButtons = [[UIButton alloc]initWithFrame:CGRectMake(270, SCREEN_HEIGHT - 50, 40, 40)];
    [hideButtons addTarget:self action:@selector(hidesButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    hideButtons.layer.borderWidth = 1;
    hideButtons.layer.cornerRadius = 20;
    image = [UIImage imageNamed:@"scribble_button"];
    [hideButtons setBackgroundImage:image forState:UIControlStateNormal];
    [self.view addSubview:hideButtons];
    
    scribbleButton = [[UIButton alloc]initWithFrame:CGRectMake(275, SCREEN_HEIGHT - 90, 30, 30)];
    [scribbleButton addTarget:self action:@selector(scribbleButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    scribbleButton.layer.borderWidth = 1;
    scribbleButton.layer.cornerRadius = 15;
    [self.view addSubview:scribbleButton];
    image = [UIImage imageNamed:@"scribble_button"];
    [scribbleButton setBackgroundImage:image forState:UIControlStateNormal];
     scribbleButton.hidden = YES;
    
    linesButton = [[UIButton alloc]initWithFrame:CGRectMake(275, SCREEN_HEIGHT - 130, 30, 30)];
    [linesButton addTarget:self action:@selector(linesButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
    linesButton.layer.borderWidth = 1;
    linesButton.layer.cornerRadius = 15;
    [self.view addSubview:linesButton];
    image = [UIImage imageNamed:@"lines_button"];
    [linesButton setBackgroundImage:image forState:UIControlStateNormal];
    linesButton.hidden = YES;

    
    
//    UIButton *linesButton = [[UIButton alloc]initWithFrame:CGRectMake(275, SCREEN_HEIGHT - 130, 30, 30)];
//    [linesButton addTarget:self action:@selector(scribbleButtonWasPressed) forControlEvents:UIControlEventTouchUpInside];
//    linesButton.layer.borderWidth = 1;
//    linesButton.layer.cornerRadius = 15;
//    [self.view addSubview:linesButton];
//    image = [UIImage imageNamed:@"lines_button"];
//    [linesButton setBackgroundImage:image forState:UIControlStateNormal];
    
//    UIButton *mainButton =
    
   
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

- (void)scribbleButtonWasPressed
{
        scribbleButton.hidden = YES;
        linesButton.hidden = YES;
    
    image = [UIImage imageNamed:@"scribble_button"];
    [hideButtons setBackgroundImage:image forState:UIControlStateNormal];
}


- (void)linesButtonWasPressed
{
    scribbleButton.hidden = YES;
    linesButton.hidden = YES;
    
    image = [UIImage imageNamed:@"lines_button"];
    [hideButtons setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)changelineColor:(UIButton *)button
{
    SCRDrawView *view = (SCRDrawView *)self.view;
    view.lineColor = button.backgroundColor;
    [view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{return YES;}

@end
