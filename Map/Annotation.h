//
//  Annotation.h
//  Map
//
//  Created by Aditya Narayan on 4/29/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *subtitle;


@end
