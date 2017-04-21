//
//  NSSafeAddition.m
//  MQiangPiaoSDK
//
//
//

#import "NSSafeAddition.h"

static id safeObjectForKeys(id self, NSArray *keys);

@implementation NAME(NSObject_SafeAddition_Hack)

@end

@implementation NAME(NSObject_SafeAddition_Hack) (NAME(Extern))

@end

#pragma mark - NSNull
@implementation NSNull (NAME(SafeAddition))

- (char)safeCharValue
{
    return 0;
}
- (unsigned char)safeUnsignedCharValue
{
    return 0;
}
- (short)safeShortValue
{
    return 0;
}
- (unsigned short)safeUnsignedShortValue
{
    return 0;
}
- (int)safeIntValue
{
    return 0;
}
- (unsigned int)safeUnsignedIntValue
{
    return 0;
}
- (long)safeLongValue
{
    return 0;
}
- (unsigned long)safeUnsignedLongValue
{
    return 0;
}
- (long long)safeLongLongValue
{
    return 0;
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return 0;
}
- (float)safeFloatValue
{
    return .0;
}
- (double)safeDoubleValue
{
    return .0f;
}
- (BOOL)safeBoolValue
{
    return NO;
}

- (NSInteger)safeIntegerValue
{
    return 0;
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return 0;
}

- (id)safeObjectForKey:(id)aKey
{
    return nil;
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return nil;
}

- (NSString *)safeStringValue
{
    return nil;
}
- (NSArray *)safeArrayValue
{
    return nil;
}
- (NSMutableArray *)safeMutableArrayValue
{
    return nil;
}
- (NSNumber *)safeNumberValue
{
    return nil;
}
- (NSDictionary *)safeDictionaryValue
{
    return nil;
}
- (NSMutableDictionary *)safeMutableDictionaryValue
{
    return nil;
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return nil;
}

@end

#pragma mark - NSData
@implementation NSData (NAME(SafeAddition))

- (char)safeCharValue
{
    return 0;
}
- (unsigned char)safeUnsignedCharValue
{
    return 0;
}
- (short)safeShortValue
{
    return 0;
}
- (unsigned short)safeUnsignedShortValue
{
    return 0;
}
- (int)safeIntValue
{
    return 0;
}
- (unsigned int)safeUnsignedIntValue
{
    return 0;
}
- (long)safeLongValue
{
    return 0;
}
- (unsigned long)safeUnsignedLongValue
{
    return 0;
}
- (long long)safeLongLongValue
{
    return 0;
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return 0;
}
- (float)safeFloatValue
{
    return .0;
}
- (double)safeDoubleValue
{
    return .0f;
}
- (BOOL)safeBoolValue
{
    return NO;
}

- (NSInteger)safeIntegerValue
{
    return 0;
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return 0;
}

- (id)safeObjectForKey:(id)aKey
{
    return nil;
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return safeObjectForKeys(self, keys);
}

- (NSString *)safeStringValue
{
    return nil;
}
- (NSArray *)safeArrayValue
{
    return nil;
}
- (NSMutableArray *)safeMutableArrayValue
{
    return nil;
}
- (NSNumber *)safeNumberValue
{
    return nil;
}
- (NSDictionary *)safeDictionaryValue
{
    return nil;
}
- (NSMutableDictionary *)safeMutableDictionaryValue
{
    return nil;
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return [[NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil] safeDictionaryValue];
}

@end

#pragma mark - NSNumber
@implementation NSNumber (NAME(SafeAddition))

- (char)safeCharValue
{
    return [self charValue];
}
- (unsigned char)safeUnsignedCharValue
{
    return [self unsignedCharValue];
}
- (short)safeShortValue
{
    return [self shortValue];
}
- (unsigned short)safeUnsignedShortValue
{
    return [self unsignedShortValue];
}
- (int)safeIntValue
{
    return [self intValue];
}
- (unsigned int)safeUnsignedIntValue
{
    return [self unsignedIntValue];
}
- (long)safeLongValue
{
    return [self longValue];
}
- (unsigned long)safeUnsignedLongValue
{
    return [self unsignedLongValue];
}
- (long long)safeLongLongValue
{
    return [self longLongValue];
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return [self unsignedLongLongValue];
}
- (float)safeFloatValue
{
    return [self floatValue];
}
- (double)safeDoubleValue
{
    return [self doubleValue];
}
- (BOOL)safeBoolValue
{
    return [self boolValue];
}

- (NSInteger)safeIntegerValue
{
    return [self integerValue];
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return [self unsignedIntegerValue];
}

- (id)safeObjectForKey:(id)aKey
{
    return nil;
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return nil;
}

- (NSString *)safeStringValue
{
    return [self stringValue];
}
- (NSArray *)safeArrayValue
{
    return nil;
}
- (NSMutableArray *)safeMutableArrayValue
{
    return nil;
}
- (NSNumber *)safeNumberValue
{
    return self;
}
- (NSDictionary *)safeDictionaryValue
{
    return nil;
}
- (NSMutableDictionary *)safeMutableDictionaryValue
{
    return nil;
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return nil;
}

@end

#pragma mark - NSString
@implementation NSString (NAME(SafeAddition))

- (char)safeCharValue
{
    return [self intValue];
}
- (unsigned char)safeUnsignedCharValue
{
    return [self intValue];
}
- (short)safeShortValue
{
    return [self intValue];
}
- (unsigned short)safeUnsignedShortValue
{
    return [self intValue];
}
- (int)safeIntValue
{
    return [self intValue];
}
- (unsigned int)safeUnsignedIntValue
{
    return [self intValue];
}
- (long)safeLongValue
{
    return [self intValue];
}
- (unsigned long)safeUnsignedLongValue
{
    return [self intValue];
}
- (long long)safeLongLongValue
{
    return [self longLongValue];
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return [self longLongValue];
}
- (float)safeFloatValue
{
    return [self floatValue];
}
- (double)safeDoubleValue
{
    return [self doubleValue];
}
- (BOOL)safeBoolValue
{
    return [self boolValue];
}

- (NSInteger)safeIntegerValue
{
    return [self integerValue];
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return [self integerValue];
}

- (id)safeObjectForKey:(id)aKey
{
    return nil;
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return safeObjectForKeys(self, keys);
}

- (NSArray *)safeArrayValue
{
    return nil;
}

- (NSMutableArray *)safeMutableArrayValue
{
    return nil;
}

- (NSString *)safeStringValue
{
    return self;
}
- (NSNumber *)safeNumberValue
{
    return nil;
}
- (NSDictionary *)safeDictionaryValue
{
    return nil;
}
- (NSMutableDictionary *)safeMutableDictionaryValue
{
    return nil;
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return [[NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil] safeDictionaryValue];
}

@end

#pragma mark - NSArray
@implementation NSArray (NAME(SafeAddition))

- (char)safeCharValue
{
    return 0;
}
- (unsigned char)safeUnsignedCharValue
{
    return 0;
}
- (short)safeShortValue
{
    return 0;
}
- (unsigned short)safeUnsignedShortValue
{
    return 0;
}
- (int)safeIntValue
{
    return 0;
}
- (unsigned int)safeUnsignedIntValue
{
    return 0;
}
- (long)safeLongValue
{
    return 0;
}
- (unsigned long)safeUnsignedLongValue
{
    return 0;
}
- (long long)safeLongLongValue
{
    return 0;
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return 0;
}
- (float)safeFloatValue
{
    return 0;
}
- (double)safeDoubleValue
{
    return 0;
}
- (BOOL)safeBoolValue
{
    return 0;
}

- (NSInteger)safeIntegerValue
{
    return 0;
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return 0;
}

- (id)safeObjectForKey:(id)aKey
{
    return nil;
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return safeObjectForKeys(self, keys);
}

- (NSString *)safeStringValue
{
    return nil;
}

- (NSArray *)safeArrayValue
{
    return self;
}

- (NSMutableArray *)safeMutableArrayValue
{
    if ([self isKindOfClass:[NSMutableArray class]]) {
        return (NSMutableArray *)self;
    } else {
        return nil;
    }
}

- (NSNumber *)safeNumberValue
{
    return nil;
}

- (NSDictionary *)safeDictionaryValue
{
    return nil;
}

- (NSMutableDictionary *)safeMutableDictionaryValue
{
    return nil;
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return nil;
}

@end

#pragma mark - NSMutableArray
@implementation NSMutableArray (NAME(SafeAddition))

- (char)safeCharValue
{
    return 0;
}
- (unsigned char)safeUnsignedCharValue
{
    return 0;
}
- (short)safeShortValue
{
    return 0;
}
- (unsigned short)safeUnsignedShortValue
{
    return 0;
}
- (int)safeIntValue
{
    return 0;
}
- (unsigned int)safeUnsignedIntValue
{
    return 0;
}
- (long)safeLongValue
{
    return 0;
}
- (unsigned long)safeUnsignedLongValue
{
    return 0;
}
- (long long)safeLongLongValue
{
    return 0;
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return 0;
}
- (float)safeFloatValue
{
    return 0;
}
- (double)safeDoubleValue
{
    return 0;
}
- (BOOL)safeBoolValue
{
    return 0;
}

- (NSInteger)safeIntegerValue
{
    return 0;
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return 0;
}

- (id)safeObjectForKey:(id)aKey
{
    return nil;
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return safeObjectForKeys(self, keys);
}

- (NSString *)safeStringValue
{
    return nil;
}

- (NSArray *)safeArrayValue
{
    return self;
}

- (NSMutableArray *)safeMutableArrayValue
{
    return self;
}

- (NSNumber *)safeNumberValue
{
    return nil;
}
- (NSDictionary *)safeDictionaryValue
{
    return nil;
}
- (NSMutableDictionary *)safeMutableDictionaryValue
{
    return nil;
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return nil;
}

@end

#pragma mark - NSDictionary
@implementation NSDictionary (NAME(SafeAddition))

- (char)safeCharValue
{
    return 0;
}
- (unsigned char)safeUnsignedCharValue
{
    return 0;
}
- (short)safeShortValue
{
    return 0;
}
- (unsigned short)safeUnsignedShortValue
{
    return 0;
}
- (int)safeIntValue
{
    return 0;
}
- (unsigned int)safeUnsignedIntValue
{
    return 0;
}
- (long)safeLongValue
{
    return 0;
}
- (unsigned long)safeUnsignedLongValue
{
    return 0;
}
- (long long)safeLongLongValue
{
    return 0;
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return 0;
}
- (float)safeFloatValue
{
    return 0;
}
- (double)safeDoubleValue
{
    return 0;
}
- (BOOL)safeBoolValue
{
    return 0;
}

- (NSInteger)safeIntegerValue
{
    return 0;
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return 0;
}

- (id)safeObjectForKey:(id)aKey
{
    return [self objectForKey:aKey];
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return safeObjectForKeys(self, keys);
}

- (NSString *)safeStringValue
{
    return nil;
}
- (NSArray *)safeArrayValue
{
    return nil;
}
- (NSMutableArray *)safeMutableArrayValue
{
    return nil;
}
- (NSNumber *)safeNumberValue
{
    return nil;
}
- (NSDictionary *)safeDictionaryValue
{
    return self;
}
- (NSMutableDictionary *)safeMutableDictionaryValue
{
    if ([self isKindOfClass:[NSMutableDictionary class]]) {
        return (NSMutableDictionary *)self;
    } else {
        return nil;
    }
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return self;
}

@end

#pragma mark - NSMutableDictionary
@implementation NSMutableDictionary (NAME(SafeAddition))

- (char)safeCharValue
{
    return 0;
}
- (unsigned char)safeUnsignedCharValue
{
    return 0;
}
- (short)safeShortValue
{
    return 0;
}
- (unsigned short)safeUnsignedShortValue
{
    return 0;
}
- (int)safeIntValue
{
    return 0;
}
- (unsigned int)safeUnsignedIntValue
{
    return 0;
}
- (long)safeLongValue
{
    return 0;
}
- (unsigned long)safeUnsignedLongValue
{
    return 0;
}
- (long long)safeLongLongValue
{
    return 0;
}
- (unsigned long long)safeUnsignedLongLongValue
{
    return 0;
}
- (float)safeFloatValue
{
    return 0;
}
- (double)safeDoubleValue
{
    return 0;
}
- (BOOL)safeBoolValue
{
    return 0;
}

- (NSInteger)safeIntegerValue
{
    return 0;
}
- (NSUInteger)safeUnsignedIntegerValue
{
    return 0;
}

- (id)safeObjectForKey:(id)aKey
{
    return [self objectForKey:aKey];
}

- (id)safeObjectForKeys:(NSArray *)keys
{
    return safeObjectForKeys(self, keys);
}

- (NSString *)safeStringValue
{
    return nil;
}
- (NSArray *)safeArrayValue
{
    return nil;
}
- (NSMutableArray *)safeMutableArrayValue
{
    return nil;
}
- (NSNumber *)safeNumberValue
{
    return nil;
}
- (NSDictionary *)safeDictionaryValue
{
    return self;
}
- (NSMutableDictionary *)safeMutableDictionaryValue
{
    return self;
}
- (NSDictionary *)safeConvertDictionaryValue
{
    return self;
}

@end

static id safeObjectForKeys(id self, NSArray *keys)
{
    if (!keys) {
        return nil;
    }
    id object = self;
    for (NSUInteger i = 0, count = keys.count; i < count; ++i) {
        if (!object) {
            return nil;
        } else if ([object isKindOfClass:[NSString class]]) {
            object = [object dataUsingEncoding:NSUTF8StringEncoding];
        }
        if ([object isKindOfClass:[NSData class]]) {
            object = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingAllowFragments error:nil];
        }
        if ([object isKindOfClass:[NSDictionary class]]) {
            id key = [keys objectAtIndex:i];
            object = [object safeObjectForKey:key];
        } else if ([object isKindOfClass:[NSArray class]]) {
            id key = [keys objectAtIndex:i];
            if ([key isKindOfClass:[NSNumber class]]) {
                object = [object objectAtIndex:[key unsignedIntegerValue]];
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    }
    return object;
}
