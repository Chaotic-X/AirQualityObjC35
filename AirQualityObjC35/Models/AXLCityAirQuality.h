//
//  AXLCityAirQuality.h
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import <Foundation/Foundation.h>
#import "AXLWeather.h"
#import "AXLPollution.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXLCityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString * city;
@property (nonatomic, copy, readonly) NSString * state;
@property (nonatomic, copy, readonly) NSString * country;
@property (nonatomic, copy, readonly) AXLWeather * weather;
@property (nonatomic, copy, readonly) AXLPollution * pollution;

-(instancetype)initWithCity:(NSString *)city
                      state:(NSString *)state
                    country:(NSString *)country
                    weather:(AXLWeather *)weather
                  pollution:(AXLPollution *)pollution;
@end

@interface AXLCityAirQuality (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
