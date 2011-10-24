//
//  MainViewController.h
//  jsonframeworkharness
//
//  Created by Rodney Degracia on 10/24/11.
//  Copyright (c) 2011 Venture Intellectual LLC. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
