//
//  ViewController.m
//  Map - zooms in on user location
//
//  Created by Aditya Narayan on 4/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UISearchBarDelegate, UISearchBarDelegate>

@end


@implementation ViewController
#define MY_SPAN 0.01f;


#pragma mark Initialization Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager setDelegate: self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

    self.myMapView.delegate = self;
    [self.locationManager startUpdatingLocation];
    self.myMapView.showsUserLocation = YES;

}



#pragma mark Map Update Methods
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = MY_SPAN;
    span.longitudeDelta = MY_SPAN;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}


#pragma mark Map Annotation Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString* AnnotationIdentifier = @"Cell";
    
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

    // Try to dequeue an existing pin view first.
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!pinView)
    {
        // try to dequeue an existing pin view first
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.draggable = NO;
        pinView.annotation = annotation;
        pinView.enabled = YES;
        pinView.exclusiveTouch = YES;
        pinView.highlighted = YES;
        pinView.multipleTouchEnabled = YES;
        pinView.pinTintColor = [UIColor colorWithRed:1.0 green:.05 blue:.7 alpha:1];
        pinView.userInteractionEnabled = YES;
        
        // Add a detail disclosure button to the rhs of callout.
        UIButton* detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = detailButton;
    }
    pinView.annotation = annotation;
    return pinView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
 
    // Create the next view controller.
    self.webVC = [[WebViewController alloc]init];
    Annotation * myAnnotation = (Annotation*)view.annotation;
    
    self.webVC.displayURL = myAnnotation.url;
    self.webVC.title = view.annotation.title;

    [self.navigationController pushViewController:self.webVC animated:YES];
    NSLog(@"Clicked a pin");
}

-(void)mapView:(MKMapView*)mapView didSelectAnnotationView:(MKAnnotationView*)view {
    
    if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
        
        Annotation * myAnnotation = (Annotation*)view.annotation;
        UIImageView * leftCalloutView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
        
        if ([myAnnotation.title isEqualToString:@"TurnToTech"]) {
            // set tttlogo
            [leftCalloutView setImage:[UIImage imageNamed:@"tttlogo2.png"]];
            leftCalloutView.layer.masksToBounds = YES;
            leftCalloutView.layer.cornerRadius = 6;
            
        }else {
            
            [leftCalloutView setImage:[UIImage imageNamed:@"flower.gif"]];
            leftCalloutView.layer.masksToBounds = YES;
            leftCalloutView.layer.cornerRadius = 6;
        }
        view.leftCalloutAccessoryView = leftCalloutView;
    }
}


#pragma mark Set Map Type
- (IBAction)mapTypeTapped:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        self.myMapView.mapType = MKMapTypeStandard;
    } else if (sender.selectedSegmentIndex == 1) {
        self.myMapView.mapType = MKMapTypeHybrid;
    } else if (sender.selectedSegmentIndex == 2) {
        self.myMapView.mapType = MKMapTypeSatellite;
    }
}


#pragma mark Search bar 
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *query = searchBar.text;
    
    // Create and initialize a search request object.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.region = self.myMapView.region;
    request.naturalLanguageQuery = query;
    // Create and initialize a search object.
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    NSLog(@"%@", query);
    
    // Start the search and display the results as annotations on the map.
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
     {
         NSMutableArray *placemarks = [NSMutableArray array];
         NSMutableArray *annotations = [NSMutableArray array];
         for (MKMapItem *item in response.mapItems) {
             [placemarks addObject:item.placemark];
             
             Annotation *annotation = [[Annotation alloc] init];
             annotation.coordinate = item.placemark.coordinate;
             annotation.title = item.name;
             annotation.subtitle =  item.placemark.title;
             annotation.url = item.url;
             
             [annotations addObject:annotation];
             
             NSLog(@"annotation:%@\nitem:%@",annotation, item);
         }
         [self.myMapView removeAnnotations:[self.myMapView annotations]];
         [self.myMapView addAnnotations:annotations ];
     }];
    
}

#pragma mark Utility Methods

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


