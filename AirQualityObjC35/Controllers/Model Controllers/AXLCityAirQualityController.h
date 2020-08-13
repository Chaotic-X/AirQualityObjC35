//
//  AXLCityAirQualityController.h
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import <Foundation/Foundation.h>
#import "AXLCityAirQuality.h"
NS_ASSUME_NONNULL_BEGIN

@interface AXLCityAirQualityController : NSObject

+(instancetype)sharedInstance;

-(void)fetchSupportedCountries:(void(^) (NSArray<NSString *> *_Nullable))completion;

-(void)fetchSupportedStatesInCountry:(NSString *)country
                 completion:(void(^) (NSArray<NSString *> *_Nullable))completion;

-(void)fetchSupportedCitiesInState:(NSString *)state
                           country:(NSString *)country
                        completion:(void(^) (NSArray<NSString *> *_Nullable))completion;

-(void)fetchDataForCity:(NSString* )city
                  state:(NSString *)state
                country:(NSString *)country
             completion:(void(^) (AXLCityAirQuality * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
