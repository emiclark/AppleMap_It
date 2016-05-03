//
//  ViewController.h
//  Map
//
//  Created by Aditya Narayan on 4/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WebViewController.h"
#import "Annotation.h"


//@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate,UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate >

@property (weak, nonatomic) IBOutlet UISearchBar *searchResultBar;
@property (nonatomic, strong) UISearchController *searchController;


@property (weak, nonatomic) IBOutlet UIImageView *TTTlogo;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@property (nonatomic, retain) WebViewController *webVC;


-(IBAction) mapTypeTapped:(UISegmentedControl *)sender;
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

@end

