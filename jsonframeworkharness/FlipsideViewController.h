//
//  FlipsideViewController.h
//  jsonframeworkharness
//
//  Created by Rodney Degracia on 10/24/11.
//  Copyright (c) 2011 Venture Intellectual LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
