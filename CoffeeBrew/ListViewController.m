//
//  ListViewController.m
//  CoffeeBrew
//
//  Created by Richard Martin on 2016-03-28.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

#import "ListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CoffeePlace.h"


@interface ListViewController () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    
    [self updateCurrentLocation];
    


}

-(void)updateCurrentLocation {
    
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    
}

-(void)findCoffeeLocations:(CLLocation *)location {
    
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"coffee";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.05, .05));
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *mapItems = response.mapItems;
        NSMutableArray *tempArray = [NSMutableArray new];
        
        for (int i = 0; i < 5; i++) {
            MKMapItem *mapItem = [mapItems objectAtIndex:i];
            
            CLLocationDistance metresAway = [mapItem.placemark.location distanceFromLocation:location];
            float milesDifference = metresAway / 1609.34;
            
            CoffeePlace *coffeePlace = [CoffeePlace new];
            coffeePlace.mapItem = mapItem;
            coffeePlace.milesDifference = milesDifference;
            
            [tempArray addObject:coffeePlace];
            
            NSLog(@"%@", coffeePlace.mapItem.name);
        }
        
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    self.currentLocation = locations.firstObject;
    NSLog(@"%@", self.currentLocation);
    [self.locationManager stopUpdatingLocation];
    
    [self findCoffeeLocations:self.currentLocation];
    
}

@end
