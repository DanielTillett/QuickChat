//
//  ImageViewController.m
//  QuickChat
//
//  Created by Taylor on 12/2/13.
//  Copyright (c) 2013 Taylor Beck. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end


@implementation ImageViewController

@synthesize myCounterLabel;


int hours, minutes, seconds;
int secondsLeft;


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileUrl = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileUrl];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"Sent from %@", senderName];
    self.navigationItem.title = title;
    
    // Countdown Timer
    secondsLeft = 10;
    [self countdownTimer];
}

- (void)viewDidAppear:(BOOL)animated
{
    secondsLeft = 10;
    [super viewDidAppear:animated];
    if ([self respondsToSelector:@selector(timeout)]) {
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    }
    else {
        NSLog(@"Error: selector missing!");
    }
}

#pragma mark - Helper Methods

- (void)timeout
{
    [timer invalidate];
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Countdown Timer Methods
- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ){
        secondsLeft -- ;
        seconds = (secondsLeft %3600) % 60;
        myCounterLabel.text = [NSString stringWithFormat:@"%.d", seconds];
    }
    else{
        secondsLeft = 10;
    }
}


-(void)countdownTimer
{
    secondsLeft = hours = minutes = seconds = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}



- (BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
