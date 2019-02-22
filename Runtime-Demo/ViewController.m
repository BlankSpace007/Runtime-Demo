//
//  ViewController.m
//  Runtime-Demo
//
//  Created by drore on 2019/2/20.
//  Copyright © 2019 lxp. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "Student.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getInstanceMethod];
//    [self getClassMethod];
//    [self getMethodImplementation];
//    [self copyMethodList];
//    [self addMethod];
//    [self getName];
    
//    [self getClass];
//    [self isMetaClass];
//    [self getClassWithObjc];
//    [self setClass];
//    [self copyClassList];
//    [self classLifeCycle];
//    [self getClassList];
//    [self getInstanceSize];
//    [self isClass];
    
    [self version];
}
-(void)version {
    int verson = class_getVersion(objc_getClass("Person"));
    NSLog(@"version = %d",verson);
    class_setVersion(objc_getClass("Person"), 10);
    int newVersion = class_getVersion(objc_getClass("Person"));
    NSLog(@"newVersion = %d",newVersion);
}

-(void)isClass {
    Person* person = [Person new];
    BOOL isClass_objc = object_isClass(person);
    BOOL isClass_class = object_isClass(objc_getClass("Person"));
    BOOL isClass_metaClass = object_isClass(objc_getMetaClass("Person"));

    NSLog(@"isClass_objc = %d  isClass_class = %d  isClass_metaClass = %d",isClass_objc,isClass_class,isClass_metaClass);
}

-(void)getInstanceSize {
    size_t size = class_getInstanceSize(objc_getClass("Person"));
    NSLog(@"size = %zu",size);
}

-(void)getClassList {
    int bufferCount = 4;
    Class* buffer = (Class*)malloc(sizeof(Class)* bufferCount);
    int count1 = objc_getClassList(buffer, bufferCount);
    for (unsigned int i =0; i <bufferCount; i++) {
        NSLog(@"name = %s",class_getName(buffer[i]));
    }
    NSLog(@"count1 = %d",count1);
    
    
    int count2 = objc_getClassList(NULL, 0);
    NSLog(@"count2 = %d",count2);

}

-(void)classLifeCycle {
    Class class = objc_allocateClassPair(objc_getClass("Person"), "Teacher" , 0);
    const char* name = class_getName(class);
    Class allocateClass = objc_getClass(name);
    NSLog(@"allocateClass = %@",allocateClass);
    
    objc_registerClassPair(class);
    Class registerClass = objc_getClass(name);
    NSLog(@"registerClass = %@",registerClass);
    
    objc_disposeClassPair(class);
    Class disposeClass = objc_getClass(name);
    NSLog(@"disposeClass = %@",disposeClass);
}

-(void)copyClassList {
    unsigned int outCount;
    Class *classes = objc_copyClassList(&outCount);
    NSLog(@"outCount = %d",outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"%s", class_getName(classes[i]));
    }
    free(classes);
}

-(void)setClass {
    Student* student = [Student new];
    Class class = object_setClass(student, objc_getClass("Person"));
    NSLog(@"oldClass = %@",class);
    NSLog(@"newStudent = %@",student);
}


-(void)getSuperclass {
    Class class = class_getSuperclass(objc_getClass("Student" ));
    NSLog(@"class = %@",class);
}

-(void)getClassWithObjc {
    Person* person = [Person new];
    Class class = object_getClass(person);
    NSLog(@"class = %@",class);
}

-(void)isMetaClass {
    const char* name = "Person";
    BOOL isMetaClass1 = class_isMetaClass(objc_getMetaClass(name ));
    BOOL isMetaClass2 = class_isMetaClass(objc_getClass(name));
    NSLog(@"objc_getMetaClass = %d,objc_getClass = %d",isMetaClass1,isMetaClass2);
}

-(void)getName {
    const char* name = class_getName([Person class]);
    NSString* nameStr = [NSString stringWithUTF8String:name];
    NSLog(@"nameStr=%@",nameStr);
}

-(void)getClass {
    const char* name = "Person1";
    const char* name_exist = "Person";
    Class class1_exist = objc_getClass(name_exist );
    NSLog(@"class1_exist = %@",class1_exist);

    Class class1 = objc_getClass(name);
    NSLog(@"class1 = %@",class1);
    Class class2_exist = objc_lookUpClass(name_exist );
    NSLog(@"class2_exist = %@",class2_exist);
    Class class2 = objc_lookUpClass(name );
    NSLog(@"class2 = %@",class2);

    Class class3_exist = objc_getRequiredClass(name_exist );
    NSLog(@"class3_exist = %@",class3_exist);
    Class class3 = objc_getRequiredClass(name );
    NSLog(@"class3 = %@",class3);
}


- (void)getInstanceMethod {
    //获得实例方法
    SEL selector = NSSelectorFromString(@"function1");
    Method method = class_getInstanceMethod([Person class], selector);
    [self logMethodDescription:method];
}

- (void)getClassMethod {
    //获得类方法
    SEL selector = NSSelectorFromString(@"classFunction1");
    Method method = class_getClassMethod([Person class], selector);
    [self logMethodDescription:method];
}


-(void)getMethodImplementation {
    IMP imp = class_getMethodImplementation([Person class], NSSelectorFromString(@"function1"));
    imp();
}

-(void)copyMethodList {
    unsigned int count = 0;
    Method* methodList = class_copyMethodList([Person class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        [self logMethodDescription:method];
    }
    free(methodList);
}

-(void)addMethod {
    NSString* types = @"v16@0:8";
    BOOL isSuccess = class_addMethod([Person class], NSSelectorFromString(@"newFunction1"), class_getMethodImplementation([Person class], NSSelectorFromString(@"function1")), [types UTF8String]);
    NSLog(@"isSuccess=%d",isSuccess);
}

-(void)logMethodDescription:(Method)method {
    struct objc_method_description * description =  method_getDescription(method);
    SEL selector = description->name;
    char* types = description->types;
    NSLog(@"selector=%@,type=%@",NSStringFromSelector(selector),[NSString stringWithUTF8String:types]);
}
@end
