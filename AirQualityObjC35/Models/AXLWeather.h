//
//  AXLWeather.h
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXLWeather : NSObject

@property (nonatomic, readonly)NSInteger temperature;
@property (nonatomic, readonly)NSInteger humidity;
@property (nonatomic, readonly)float windSpeed;

-(instancetype)initWithWeatherInfo:(NSInteger)temperature humidity:(NSInteger)humidity windSpeed:(float)windSpeed;

@end

@interface AXLWeather (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary;

@end
NS_ASSUME_NONNULL_END
