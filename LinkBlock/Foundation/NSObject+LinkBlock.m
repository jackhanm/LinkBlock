//
//  NSObject+LinkBlock.m
//
//  Created by NOVO on 15/8/12.
//  Copyright (c) 2015年 NOVO. All rights reserved.
//

#import "NSObject+LinkBlock.h"
#import <objc/runtime.h>
#import "LinkBlock.h"

@implementation NSObject(LinkBlock)

- (id (^)(NSString *))valueForKeySafe
{
    return ^(NSString* key){
        @try {
            return [self valueForKey:key];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"LinkBlock log:\n%@",exception);
#endif
            return (id)nil;
        }
    };
}
- (void)setValueForKeySafe:(id (^)(NSString *))valueGetSafe{};

- (NSObject *(^)(id ,NSString* ))setValueForKeySafe
{
    return ^(id value,NSString* key){
        @try {
            [self setValue:value forKey:key];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"LinkBlock log:\n%@",exception);
#endif
            return self;
        }
        @finally {
            return self;
        }
    };
}
- (void)setSetValueForKeySafe:(NSObject *(^)(id value,NSString* key))valueSetSafe{};

- (id (^)(NSString *))valueForKeyPathSafe
{
    return ^(NSString* key){
        @try {
            return [self valueForKeyPath:key];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"LinkBlock log:\n%@",exception);
#endif
            return (id)nil;
        }
    };
}
- (void)setValueForKeyPathSafe:(id (^)(NSString *))valuePathGetSafe{};

- (NSObject *(^)(id ,NSString* ))setValueForKeyPathSafe
{
    return ^(id value,NSString* key){
        @try {
            [self setValue:value forKeyPath:key];
        }
        @catch (NSException *exception) {
#ifdef DEBUG
            NSLog(@"LinkBlock log:\n%@",exception);
#endif
            return self;
        }
        @finally {
            return self;
        }
    };
}
- (void)setSetValueForKeyPathSafe:(NSObject *(^)(id value,NSString* key))valuePathSetSafe{};

+ (BOOL)classContainProperty:(NSString*)property
{
    unsigned int outCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &outCount);
    for(i=0 ; i< outCount; i++)
        if([property isEqualToString:[NSString stringWithUTF8String:property_getName(properties[i])]])
            return YES;
    
    return NO;
}
+ (BOOL)classContainIvar:(NSString*)ivarName
{
    unsigned int outCout ,i ;
    Ivar* ivarList = class_copyIvarList([self class], &outCout);
    for(i=0;i< outCout;i++)
        if([ivarName isEqualToString:[NSString stringWithUTF8String:ivar_getName(ivarList[i])]])
            return YES;
    
    return NO;
}


+ (NSArray*)classGetIvarList
{
    unsigned int outCount , i;
    Ivar* ivarList = class_copyIvarList([self class], &outCount);
    NSMutableArray* reMArr = [NSMutableArray new];
    for(i=0 ; i< outCount; i++)
        [reMArr addObject:[NSString stringWithUTF8String:ivar_getName(ivarList[i])]];
    
    return (NSArray*)[reMArr copy];
}
+ (NSArray*)classGetPropertyList
{
    unsigned int outCount, i;
    objc_property_t* properties = class_copyPropertyList([self class], &outCount);
    
    NSMutableArray* reMArr = [NSMutableArray new];
    
    for(i=0 ; i< outCount; i++)
        [reMArr addObject:[NSString stringWithUTF8String:property_getName(properties[i])]];
    
    return (NSArray*)[reMArr copy];
}



- (NSObject *(^)())objCopy
{
    return ^(){
        return (NSObject*)[self copy];
    };
}
- (void)setObjCopy:(NSObject *(^)())objCopy{};

- (NSObject *(^)())objMutableCopy
{
    return ^(){
        return (NSObject*)[self mutableCopy];
    };
}
- (void)setObjMutableCopy:(NSObject *(^)())objMutableCopy{};

- (BOOL (^)(NSObject *))objIsEqual
{
    return ^(NSObject* obj){
        return [self isEqual:obj];
    };
}
- (void)setObjIsEqual:(BOOL (^)(NSObject *))objIsEqual{};

- (BOOL (^)( __unsafe_unretained Class))isKindOf
{
    return ^(Class classKind){
        if(!classKind)
            return NO;
        return [self isKindOfClass:classKind];
    };
}
- (void)setIsKindOf:(BOOL (^)(__unsafe_unretained Class))objIsKind{};

- (BOOL (^)(__unsafe_unretained Class))isSubClassOf
{
    return ^(Class classKind){
        if(!classKind)
            return NO;
        return [[self class] isSubclassOfClass:classKind];
    };
}
- (void)setIsSubClassOf:(BOOL (^)(__unsafe_unretained Class))isSubClassOf{};

- (NSObject* (^)(__unsafe_unretained Class))typeForceObj
{
    return ^(Class theClass){
        if(!theClass || !self.isKindOf(theClass)){
            return (NSObject*)[theClass new];
        }else{
            return self;
        }
    };
}
- (void)setTypeForceObj:(NSObject *(^)(__unsafe_unretained Class))typeForceObj{};

- (BOOL (^)(SEL))isRespondsSEL
{
    return ^(SEL theSEL){
        if(theSEL){
            if([self respondsToSelector:theSEL])
                return YES;
        }
        return NO;
    };
}
- (void)setIsRespondsSEL:(BOOL (^)(SEL))isResponseSEL{};


- (NSString *(^)())objToJsonString
{
    return ^(){
        LinkError_VAL_IF(NSObject){
            return (NSString*)@"";
        }
        if(![NSJSONSerialization isValidJSONObject:_self])
            return @"\"\"";
        NSError* error= nil;
        NSData * JSONData = [NSJSONSerialization dataWithJSONObject:_self
                                                            options:kNilOptions
                                                              error:&error];
        if(error)
            return @"\"\"";
        return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    };
}
- (void)setObjToJsonString:(NSString *(^)())objToJsonString{};

- (Class (^)())objClass
{
    return ^(){
        return [self class];
    };
}
- (void)setObjClass:(Class (^)())objClass{};

- (NSString *(^)())className
{
    return ^(){
        return NSStringFromClass(self.class);
    };
}
- (void)setClassName:(NSString *(^)())objClassName{};

- (NSString *(^)())superclassName
{
    return ^(){
        return NSStringFromClass(self.superclass);
    };
}
- (void)setSuperclassName:(NSString *(^)())superclassName{};

- (NSObject *(^)(id*))setTo
{
    return ^(id* toObject){
        LinkError_VAL_IF(NSObject){
            *toObject= nil;
        }else{
            *toObject= _self;
        }
        return _self;
    };
}
- (void)setSetTo:(NSObject *(^)(id*))setTo{};


- (NSObject *(^)())nslog
{
    return ^(){
        LinkError_VAL_IF(NSObject){
            return (NSObject*)_self;
        }
        NSLog(@"%@",_self);
        return _self;
    };
}
- (void)setNslog:(NSObject *(^)())nslog{};

- (NSObject *(^)(NSString *))nslogTitle
{
    return ^(NSString* title){
        LinkError_VAL_IF(NSObject){
            return (NSObject*)_self;
        }
        NSLog(@"%@%@",title,_self);
        return _self;
    };
}
- (void)setNslogTitle:(NSObject *(^)(NSString *))nslogTitle{};
- (id (^)())end
{
    return ^(){
        LinkError_VAL_IF(NSObject){
            return (id)nil;
        }
        return (id)_self;
    };
}
- (void)setEnd:(id(^)())end{};


- (id (^)(NSString *))valueForKey
{
    return ^(NSString* key){
        return [self valueForKey:key];
    };
}
- (void)setValueForKey:(id (^)(NSString *))valueForKey{};

- (NSObject *(^)(id, NSString* ))setValueForKey
{
    return ^(id value, NSString* key){
        [self setValue:value forKey:key];
        return self;
    };
}
- (void)setSetValueForKey:(NSObject *(^)(id, NSString *))setValueForKey{};

- (id (^)(NSString *))valueForKeyPath
{
    return ^(NSString* key){
        return [self valueForKeyPath:key];
    };
}
- (void)setValueForKeyPath:(id (^)(NSString *))valueForKeyPath{};

- (NSObject *(^)(id , NSString* ))setValueForKeyPath
{
    return ^(id value, NSString* key){
        [self setValue:value forKeyPath:key];
        return self;
    };
}
- (void)setSetValueForKeyPath:(NSObject *(^)(id, NSString *))setValueForKeyPath{};

#pragma mark - quick use type
- (NSString *(^)())typeIsNSString
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSString:(NSString *(^)())typeIsNSString{};

- (NSMutableString *(^)())typeIsNSMutableString
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSMutableString:(NSMutableString *(^)())typeIsNSMutableString{};

- (NSArray *(^)())typeIsNSArray
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSArray:(NSArray *(^)())typeIsNSArray{};

- (NSMutableArray *(^)())typeIsNSMutableArray
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSMutableArray:(NSMutableArray *(^)())typeIsNSMutableArray{};

- (NSDictionary *(^)())typeIsNSDictionary
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSDictionary:(NSDictionary *(^)())typeIsNSDictionary{};

- (NSMutableDictionary *(^)())typeIsNSMutableDictionary
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSMutableDictionary:(NSMutableDictionary *(^)())typeIsNSMutableDictionary{};

- (NSAttributedString *(^)())typeIsNSAttributedString
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSAttributedString:(NSAttributedString *(^)())typeIsNSAttributedString{};

- (NSMutableAttributedString *(^)())typeIsNSMutableAttributedString
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSMutableAttributedString:(NSMutableAttributedString *(^)())typeIsNSMutableAttributedString{};

- (NSURL *(^)())typeIsNSURL
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSURL:(NSURL *(^)())typeIsNSURL{};

- (NSUserDefaults *(^)())typeIsNSUserDefaults
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsNSUserDefaults:(NSUserDefaults *(^)())typeIsNSUserDefaults{};

- (UIView *(^)())typeIsUIView
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIView:(UIView *(^)())typeIsUIView{};

- (UILabel *(^)())typeIsUILabel
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUILabel:(UILabel *(^)())typeIsUILabel{};

- (UIControl *(^)())typeIsUIControl
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIControl:(UIControl *(^)())typeIsUIControl{};

- (UIButton *(^)())typeIsUIButton
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIButton:(UIButton *(^)())typeIsUIButton{};

- (UIScrollView *(^)())typeIsUIScrollView
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIScrollView:(UIScrollView *(^)())typeIsUIScrollView{};

- (UIImage *(^)())typeIsUIImage
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIImage:(UIImage *(^)())typeIsUIImage{};

- (UIColor *(^)())typeIsUIColor
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIColor:(UIColor *(^)())typeIsUIColor{};

- (UIViewController *(^)())typeIsUIViewController
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIViewController:(UIViewController *(^)())typeIsUIViewController{};

- (UIImageView *(^)())typeIsUIImageView
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUIImageView:(UIImageView *(^)())typeIsUIImageView{};

- (UITableView *(^)())typeIsUITableView
{
    return ^(){
        return (id)self;
    };
}
- (void)setTypeIsUITableView:(UITableView *(^)())typeIsUITableView{};


@end
