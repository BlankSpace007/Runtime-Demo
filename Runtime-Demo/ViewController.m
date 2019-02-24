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
#import "Person+Actor.h"
@interface ViewController ()

@property(nonatomic, strong)Person* person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //test class function
//    [self getName];
    [self createInstance];
//    [self getClass];
//    [self isMetaClass];
//    [self getClassWithObjc];
//    [self setClass];
//    [self copyClassList];
//    [self classLifeCycle];
//    [self getClassList];
//    [self getInstanceSize];
//    [self isClass];
//    [self version];
    //test category function
//    [self testCategory];

}

#pragma mark - Class
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
    NSLog(@"name = %s",name);
}

-(void)createInstance {
    Person* person = class_createInstance(objc_getClass("Person"), 0);
    NSLog(@"%@",person);
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


#pragma mark - category
-(void)testCategory {
    _person = [Person new];
    _person.actingSkill = 0.1;
    NSLog(@"actingSkill = %f",_person.actingSkill);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_person) {
        objc_removeAssociatedObjects(_person);
        NSLog(@"actingSkill2 = %f",_person.actingSkill);
    }

}

@end
