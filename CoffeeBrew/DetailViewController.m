//
//  DetailViewController.m
//  CoffeeBrew
//
//  Created by Richard Martin on 2016-03-30.
//  Copyright © 2016 Richard Martin. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.coffeePlace.mapItem.name;
    
    [self getPathDirections:self.currentLocation.coordinate withDestination:self.coffeePlace.mapItem.placemark.location.coordinate];

}

-(void)getPathDirections:(CLLocationCoordinate2D)source withDestination:(CLLocationCoordinate2D)destination {
    
    MKPlacemark *placemarkSource = [[MKPlacemark alloc]initWithCoordinate:source addressDictionary:nil];
    MKMapItem *mapItemSource = [[MKMapItem alloc]initWithPlacemark:placemarkSource];
    
    MKPlacemark *placemarkDestination = [[MKPlacemark alloc]initWithCoordinate:destination addressDictionary:nil];
    MKMapItem *mapItemDestination = [[MKMapItem alloc]initWithPlacemark:placemarkDestination];
    
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    [request setSource:mapItemSource];
    [request setDestination:mapItemDestination];
    [request setTransportType:MKDirectionsTransportTypeWalking];
    request.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        MKRoute *route = response.routes.lastObject;
        
        NSString *allSteps = [NSString new];
        
        for (int i = 0; i < route.steps.count; i++) {
            MKRouteStep *step = [route.steps objectAtIndex:i];
            NSString *newStepString = step.instructions;
            
            allSteps = [allSteps stringByAppendingString:newStepString];
            allSteps = [allSteps stringByAppendingString:@"\n\n"];
            
        }
        
        self.textView.text = allSteps;
    }];
    
}

@end
