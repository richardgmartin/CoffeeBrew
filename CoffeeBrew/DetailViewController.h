//
//  DetailViewController.h
//  CoffeeBrew
//
//  Created by Richard Martin on 2016-03-30.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeePlace.h"

@interface DetailViewController : UIViewController

@property CoffeePlace *coffeePlace;
@property CLLocation *currentLocation;

@end
