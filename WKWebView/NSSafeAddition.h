//
//  NSSafeAddition.h
//  MQiangPiaoSDK
//
//
//

#import <Foundation/Foundation.h>

@interface NAME(NSObject_SafeAddition_Hack) : NSObject

@end


@interface NAME(NSObject_SafeAddition_Hack) (NAME(Extern))

@end

#pragma mark - NSNull
@interface NSNull (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end

#pragma mark - NSData
@interface NSData (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end

#pragma mark - NSNumber
@interface NSNumber (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end

#pragma mark - NSString
@interface NSString (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end

#pragma mark - NSArray
@interface NSArray (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end

#pragma mark - NSMutableArray
@interface NSMutableArray (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end

#pragma mark - NSDictionary
@interface NSDictionary (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end

#pragma mark - NSMutableDictionary
@interface NSMutableDictionary (NAME(SafeAddition))

- (char)safeCharValue;
- (unsigned char)safeUnsignedCharValue;
- (short)safeShortValue;
- (unsigned short)safeUnsignedShortValue;
- (int)safeIntValue;
- (unsigned int)safeUnsignedIntValue;
- (long)safeLongValue;
- (unsigned long)safeUnsignedLongValue;
- (long long)safeLongLongValue;
- (unsigned long long)safeUnsignedLongLongValue;
- (float)safeFloatValue;
- (double)safeDoubleValue;
- (BOOL)safeBoolValue;

- (NSInteger)safeIntegerValue;
- (NSUInteger)safeUnsignedIntegerValue;

- (id)safeObjectForKey:(id)aKey;
- (id)safeObjectForKeys:(NSArray *)keys;

- (NSString *)safeStringValue;
- (NSArray *)safeArrayValue;
- (NSMutableArray *)safeMutableArrayValue;
- (NSNumber *)safeNumberValue;
- (NSDictionary *)safeDictionaryValue;
- (NSMutableDictionary *)safeMutableDictionaryValue;
- (NSDictionary *)safeConvertDictionaryValue;

@end
