//
//  ViewController.m
//  Map
//
//  Created by Aditya Narayan on 4/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UISearchBarDelegate>

@end


@implementation ViewController

// initial coordinates
#define TTT_LATITUDE 40.741434
#define TTT_LONGITUDE -73.990039
#define TTT_SPAN 0.01f;



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
         for (MKMapItem *item in response.mapItems) {
             [placemarks addObject:item.placemark];
//             NSLog(@"response:%@\nitem:%@",response.mapItems, item);
         }
         [self.myMapView removeAnnotations:[self.myMapView annotations]];
         [self.myMapView showAnnotations:placemarks animated:NO];
     }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [self.locationManager startUpdatingLocation];
        self.myMapView.showsUserLocation = YES;
        
    }
    
    self.myMapView.delegate = self;
    
    self.TTTlogo.image = [UIImage imageNamed: @"TTTlogoRed.png"];
    [self.view addSubview:self.TTTlogo];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //center
    CLLocationCoordinate2D tttLocation;
    tttLocation.latitude = TTT_LATITUDE;
    tttLocation.longitude = TTT_LONGITUDE;
    
    //span
    MKCoordinateSpan span;
    span.latitudeDelta = TTT_SPAN
    
    // Create Region
    MKCoordinateRegion myRegion;
    myRegion.center = tttLocation;
    myRegion.span = span;
    
    [self.myMapView  setRegion:myRegion animated:YES];
    
    //Add annotation
    //1. Create a coordinate for use with the annotation
    Annotation *tttech = [Annotation alloc];
    tttech.coordinate = tttLocation;
    tttech.title = @"TurnToTech";
    tttech.subtitle = @"IOS BootCamp";
    
    //2. Add annotation to mapView
    [self.myMapView addAnnotation: tttech];
    [self initializeMyPins];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Initialization Methods

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager setDelegate: self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    return self;
}

-(void) initializeMyPins {
    
    // Add/Show pin for restaurants in Flatiron District
    
    Annotation *gramercyTavern = [Annotation alloc];
    gramercyTavern.coordinate = CLLocationCoordinate2DMake(40.738541, -73.988504);
    gramercyTavern.title = @"Gramercy Tavern";
    gramercyTavern.subtitle = @"American Cuisine. Danny Meyer's Flatiron District tavern with a fixed-price-only dining room & a bustling bar area.";
    [self.myMapView addAnnotation:gramercyTavern];
    
    
    Annotation *giorgios = [Annotation alloc];
    giorgios.coordinate = CLLocationCoordinate2DMake(40.739716, -73.988622);
    giorgios.title = @"Giorgio's of Gramercy";
    giorgios.subtitle = @"American Cuisine. Longtime eatery serving a New American menu along with numerous pasta dishes.";
    [self.myMapView addAnnotation:giorgios];
    
    Annotation *ILILI = [Annotation alloc];
    ILILI.coordinate = CLLocationCoordinate2DMake(40.748379, -73.996712);
    ILILI.title = @"Giorgio's of Gramercy";
    ILILI.subtitle = @"American Cuisine. Upscale American tasting menus from chef Daniel Humm served in a high-ceilinged art deco space.";
    [self.myMapView addAnnotation:ILILI];
    
    Annotation *elevenMadisonPark = [Annotation alloc];
    elevenMadisonPark.coordinate = CLLocationCoordinate2DMake(40.73748, -73.981331);
    elevenMadisonPark.title = @"Mediterranean Cuisine. Creative Lebanese small plates ideal for sharing in a trendy space that also serves cocktails.";
    [self.myMapView addAnnotation:elevenMadisonPark];
    
    
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

#pragma mark Map Annotation Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Try to dequeue an existing pin view first.
    MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Cell"];
    if (!pinView)
    {
        // try to dequeue an existing pin view first
        static NSString* AnnotationIdentifier = @"Cell";
        MKPinAnnotationView* pinView = [[MKPinAnnotationView alloc]
                                        initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        pinView.draggable = NO;
        pinView.annotation = annotation;
        pinView.enabled = YES;
        pinView.exclusiveTouch = YES;
        pinView.highlighted = YES;
        pinView.multipleTouchEnabled = YES;
        pinView.pinTintColor = [UIColor colorWithRed:0.9 green:0.02 blue:1 alpha:1];
        pinView.userInteractionEnabled = YES;
        
        // Add a detail disclosure button to the rhs of callout.
        UIButton* detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.rightCalloutAccessoryView = detailButton;
        
        // Add a logo to the lhs of callout.
        UIImageView * logoImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"flower.gif" ]];
        pinView.leftCalloutAccessoryView = logoImage;
        
                pinView.annotation = annotation;
        return pinView;
    } else {
        pinView.annotation = annotation;
    }
    return nil;
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

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    // Create the next view controller.
    WebViewController *webVC = [[WebViewController alloc]initWithNibName:nil bundle:nil];
    webVC.displayURL= @"http://www.turntotech.io";
    webVC.title = @"TurnToTech";
    [self.navigationController pushViewController:webVC animated:YES];
    NSLog(@"Clicked a pin");
    
}
@end
