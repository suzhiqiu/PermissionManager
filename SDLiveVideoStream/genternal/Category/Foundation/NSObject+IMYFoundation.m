//
//  NSObject+IMYFoundation.m
//  IMYFoundation


#import "NSObject+IMYFoundation.h"
#import "NSString+IMYFoundation.h"
#import <objc/runtime.h>
#import <pthread.h>
#import <stdlib.h>

@interface _IMYAsyncBlockMap : NSObject
@property (nonatomic, assign) BOOL isNeedRemove;
@property (nonatomic, copy) void (^execBlock)(void);
@end

@protocol _IMYAsyncQueueProtocol
///获取线程队列
+ (dispatch_queue_t)imy_queueWithLevel:(NSInteger)level;
@end

static pthread_mutex_t kGlobalAsyncLock;
static NSMutableDictionary *kGlobalExcuteBlockMap;

@implementation _IMYAsyncBlockMap
+ (NSMutableDictionary *)globalExcuteBlockMap {
    return kGlobalExcuteBlockMap;
}
+ (pthread_mutex_t)globalAsyncLock {
    return kGlobalAsyncLock;
}
@end

@interface IMYCallSuperProxy : NSProxy
@property (weak, nonatomic) id target;
@property Class invokeClass;
@end

@implementation IMYCallSuperProxy
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [self.target methodSignatureForSelector:selector];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    if (self.target == nil) {
        return;
    }
    Class invokeClass = self.invokeClass;

    NSString *selectorName = NSStringFromSelector(invocation.selector);
    NSString *superSelectorName = [NSString stringWithFormat:@"IMYSuper_%@_%@", NSStringFromClass(invokeClass), selectorName];
    SEL superSelector = NSSelectorFromString(superSelectorName);

    if ([invokeClass instancesRespondToSelector:superSelector] == NO) {
        Method superMethod = class_getInstanceMethod(invokeClass, invocation.selector);
        if (superMethod == NULL) {
            NSLog(@"class:%@ undefine funcation: %@ ", NSStringFromClass(invokeClass), selectorName);
            return;
        }
        IMP superIMP = method_getImplementation(superMethod);
        class_addMethod(invokeClass, superSelector, superIMP, method_getTypeEncoding(superMethod));
    }

    invocation.selector = superSelector;
    [invocation invokeWithTarget:self.target];
}
- (NSString *)description {
    return [self.target description];
}
- (NSString *)debugDescription {
    return [self.target debugDescription];
}
- (Class)superclass {
    return [self.target superclass];
}
- (Class) class
{
    return [self.target class];
}
    @end

#define DareToBe(cls) ([self isKindOfClass:cls.class] ? (id)self : nil)

    @implementation
    NSObject(IMYFoundation)

    - (NSString *)maybeNSString {
    return DareToBe(NSString);
}

- (NSMutableString *)maybeNSMutableString {
    return DareToBe(NSMutableString);
}

- (NSArray *)maybeNSArray {
    return DareToBe(NSArray);
}

- (NSMutableArray *)maybeNSMutableArray {
    return DareToBe(NSMutableArray);
}

- (NSDictionary *)maybeNSDictionary {
    return DareToBe(NSDictionary);
}

- (NSMutableDictionary *)maybeNSMutableDictionary {
    return DareToBe(NSMutableDictionary);
}

- (NSSet *)maybeNSSet {
    return DareToBe(NSSet);
}

- (NSMutableSet *)maybeNSMutableSet {
    return DareToBe(NSMutableSet);
}

- (NSData *)maybeNSData {
    return DareToBe(NSData);
}

- (NSMutableData *)maybeNSMutableData {
    return DareToBe(NSMutableData);
}

- (NSNumber *)maybeNSNumber {
    return DareToBe(NSNumber);
}

- (NSError *)maybeNSError {
    return DareToBe(NSError);
}

- (NSValue *)maybeNSValue {
    return DareToBe(NSValue);
}

- (NSURL *)maybeNSURL {
    return DareToBe(NSURL);
}

- (NSDate *)maybeNSDate {
    return DareToBe(NSDate);
}

- (instancetype)imy_callSuper {
    Class clazz = object_getClass(self);
    NSString *className = NSStringFromClass(clazz);
    if ([className hasPrefix:@"NSKVONotifying_"]) {
        clazz = class_getSuperclass(clazz);
    }
    Class superclass = class_getSuperclass(clazz);
    return [self imy_callWithSuperClass:superclass];
}
- (instancetype)imy_callWithSuperClass:(Class)superClass {
    if (object_getClass(self) == superClass || superClass == nil || [self isKindOfClass:superClass] == NO) {
        return self;
    }

    IMYCallSuperProxy *proxy = [IMYCallSuperProxy alloc];
    proxy.target = self;
    proxy.invokeClass = superClass;
    return (id)proxy;
}

+ (void)imy_asyncMainBlock:(void (^)(void))block {
    imy_asyncMainBlock(0, block);
}

+ (void)imy_asyncMainBlock:(void (^)(void))block afterSecond:(double)second {
    imy_asyncMainBlock(second, block);
}

+ (void)imy_asyncMainExecuteBlock:(void (^)(void))block {
    imy_asyncMainExecuteBlock(block);
}

+ (void)imy_syncMainExecuteBlock:(void (^)(void))block {
    imy_syncMainExecuteBlock(block);
}

- (void)imy_asyncMainBlock:(void (^)(void))block {
    imy_asyncMainBlock(0, block);
}

- (void)imy_asyncMainBlock:(void (^)(void))block afterSecond:(double)second {
    imy_asyncMainBlock(second, block);
}

- (void)imy_asyncMainExecuteBlock:(void (^)(void))block {
    imy_asyncMainExecuteBlock(block);
}

- (void)imy_syncMainExecuteBlock:(void (^)(void))block {
    imy_syncMainExecuteBlock(block);
}

+ (void)imy_asyncBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue afterSecond:(double)second forKey:(NSString *)key {
    if (block == nil) {
        return;
    }

    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));

    ///不可取消
    if (key == nil) {
        dispatch_after(delayTime, queue, block);
        return;
    }

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pthread_mutex_init(&kGlobalAsyncLock, NULL);
        kGlobalExcuteBlockMap = [NSMutableDictionary dictionary];
    });

    _IMYAsyncBlockMap *blockMap = [_IMYAsyncBlockMap new];
    blockMap.execBlock = block;

    pthread_mutex_lock(&kGlobalAsyncLock);
    _IMYAsyncBlockMap *removeObject = [kGlobalExcuteBlockMap objectForKey:key];
    if (removeObject) {
        removeObject.isNeedRemove = YES;
        removeObject.execBlock = nil;
    }
    [kGlobalExcuteBlockMap setObject:blockMap forKey:key];
    pthread_mutex_unlock(&kGlobalAsyncLock);

    __weak _IMYAsyncBlockMap *weakBlockMap = blockMap;
    dispatch_after(delayTime, queue, ^{
        void (^doExecBlock)(void) = nil;
        pthread_mutex_lock(&kGlobalAsyncLock);
        if (weakBlockMap && weakBlockMap.isNeedRemove == NO) {
            weakBlockMap.isNeedRemove = YES;
            doExecBlock = weakBlockMap.execBlock;
            [kGlobalExcuteBlockMap removeObjectForKey:key];
        }
        pthread_mutex_unlock(&kGlobalAsyncLock);
        if (doExecBlock) {
            doExecBlock();
        }
    });
}
+ (void)imy_cancelBlockForKey:(NSString *)key {
    if (key == nil) {
        return;
    }
    pthread_mutex_lock(&kGlobalAsyncLock);
    _IMYAsyncBlockMap *blockMap = [kGlobalExcuteBlockMap objectForKey:key];
    if (blockMap) {
        blockMap.isNeedRemove = YES;
        blockMap.execBlock = nil;
        [kGlobalExcuteBlockMap removeObjectForKey:key];
    }
    pthread_mutex_unlock(&kGlobalAsyncLock);
}
+ (BOOL)imy_hasAsyncBlockForKey:(NSString *)key {
    if (key == nil) {
        return NO;
    }
    pthread_mutex_lock(&kGlobalAsyncLock);
    BOOL hasContain = NO;
    _IMYAsyncBlockMap *blockMap = [kGlobalExcuteBlockMap objectForKey:key];
    if (blockMap) {
        hasContain = YES;
    }
    pthread_mutex_unlock(&kGlobalAsyncLock);
    return hasContain;
}
+ (dispatch_queue_t)imy_defaultQualityQueue {
    static dispatch_once_t onceToken = 0;
    if (onceToken == 0) {
        onceToken = [self respondsToSelector:@selector(imy_queueWithLevel:)] ? 1 : 2;
    }
    if (onceToken == 1) {
        return [(id)self imy_queueWithLevel:0];
    } else {
        return dispatch_get_global_queue(0, 0);
    }
}

- (BOOL)imy_isNotEmptyString {
    return imy_isNotEmptyString((id)self);
}

- (BOOL)imy_isEmptyString {
    return imy_isEmptyString((id)self);
}

- (BOOL)imy_isNotBlankString {
    return imy_isNotBlankString((id)self);
}

- (BOOL)imy_isBlankString {
    return imy_isBlankString((id)self);
}

+ (BOOL)imy_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError **)error_ {
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
        return NO;
    }
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
        return NO;
    }

    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));

    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));

    return YES;
}

+ (BOOL)imy_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError **)error_ {
    return [object_getClass((id)self) imy_swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}

+ (BOOL)imy_replaceMethod:(SEL)origSel_ withBlock:(id)block_ error:(NSError **)error_ {
    IMP newImplementation = imp_implementationWithBlock(block_);

    Method method = class_getInstanceMethod(self, origSel_);
    class_replaceMethod(self, origSel_, newImplementation, method_getTypeEncoding(method));
    return YES;
}

+ (BOOL)imy_replaceClassMethod:(SEL)origSel_ withBlock:(id)block_ error:(NSError **)error_ {
    return [object_getClass((id)self) imy_replaceMethod:origSel_ withBlock:block_ error:error_];
}

@end

@implementation NSProxy (IMYSwizzle)
+ (BOOL)imy_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError **)error_ {
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
        return NO;
    }
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
        return NO;
    }

    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));

    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));

    return YES;
}

+ (BOOL)imy_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError **)error_ {
    return [object_getClass((id)self) imy_swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}
@end

__attribute__((overloadable)) void imy_asyncMainBlock(void (^block)(void)) {
    imy_asyncMainBlock(0, block);
}

__attribute__((overloadable)) void imy_asyncMainBlock(double second, void (^block)(void)) {
    if (!block) {
        return;
    }
    if (second > 0) {
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), block);
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void imy_asyncMainExecuteBlock(void (^block)(void)) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void imy_syncMainExecuteBlock(void (^block)(void)) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

void IMY_RUN_ON_UI_THREAD(void (^block)(void)) {
    imy_syncMainExecuteBlock(block);
}

inline BOOL imy_isEmptyString(NSString *string) {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    NSString *trimString = string.imy_trimString;
    if (trimString.length == 0) {
        return YES;
    }
    NSString *lowercaseString = trimString.lowercaseString;
    if ([lowercaseString isEqualToString:@"(null)"] || [lowercaseString isEqualToString:@"null"] || [lowercaseString isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

inline BOOL imy_isNotEmptyString(NSString *string) {
    return !imy_isEmptyString(string);
}

inline BOOL imy_isBlankString(NSString *string) {
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    NSString *trimString = string.imy_trimString;
    if (trimString.length == 0) {
        return YES;
    }
    return NO;
}

inline BOOL imy_isNotBlankString(NSString *string) {
    return !imy_isBlankString(string);
}
