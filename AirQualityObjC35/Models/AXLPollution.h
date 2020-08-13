//
//  AXLPollution.h
//  AirQualityObjC35
//
//  Created by Alex Lundquist on 8/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXLPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

-(instancetype)initWithInt:(NSInteger)aqi;

@end

@interface AXLPollution (JSONConvertable)

-(instancetype) initWithDictionary:(NSDictionary<NSString *, id > *)dictionary;

@end
NS_ASSUME_NONNULL_END
