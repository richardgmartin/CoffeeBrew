//
//  CoffeePlace.h
//  CoffeeBrew
//
//  Created by Richard Martin on 2016-03-28.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CoffeePlace : NSObject

@property MKMapItem *mapItem;
@property float milesDifference;

@end
