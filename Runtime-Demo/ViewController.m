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
#import "Car.h"
#import "Cat.h"
@interface ViewController ()

@property(nonatomic, strong)Person* person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //test class function
//    [self getName];
//    [self createInstance];
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
    //test method
//    [self getMethod];
//    [self getMethodImplementation];
//    [self copyMethodList];
//    [self setImplementation];
//    [self getSEL];
//    [self getType];
//    [self addMethod];
//    [self exchangeImplementations];
    //test ivar
//    [self getIvar];
//    [self copyIvarList];
//    [self getTypeEncoding];
//    [self setIvar];
//    [self getIvarValue];
//    [self getOffset];
//    [self ivarLayout];
//    [self addIvar];
//    [self getIvarLayout];
    //test property
//    [self getProperty];
//    [self copyPropertyList];
//    [self getAttributes];
//    [self copyAttributeValue];
//    [self addProperty];
//    [self replaceProperty];
    //test protocol
//    [self protocolCommen];
//    [self conformsToProtocol];
//    [self isEqual];
//    [self isEqual2];
//    [self getMethodDescription];
//    [self copyMethodDescriptionList];
//    [self getProperty_Protocol];
//    [self copyPropertyList_protocol];
//    [self conformsToProtocol_class];
//    [self copyProtocolList];
//    [self copyProtocolList_class];
//    [self copyProtocolList_objc];
//    [self allocateProtocol];
//    [self addMethodDescription1];
//    [self addMethodDescription2];
//    [self addProperty_protocol];
//    [self addProtocol_protocol];
    [self addProtocol_class];

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

#pragma mark - Method
-(void)logMethodDescription:(Method)method {
    if (method) {
        struct objc_method_description * description = method_getDescription(method);
        SEL selector = description->name;
        char* types = description->types;
        NSLog(@"selector=%s,type=%s", sel_getName(selector),types);
    } else {
        NSLog(@"Method 为 null");
    }
}

- (void)getMethod {
    //获取function1
    SEL selector = sel_registerName("function1");
    Method method = class_getInstanceMethod(objc_getClass("Car"), selector);
    [self logMethodDescription:method];
    
    //获取function1
    SEL selector1 = sel_registerName("function2");
    Method method1 = class_getInstanceMethod(objc_getClass("Car"), selector1);
    [self logMethodDescription:method1];
    
    //获取function1_class
    SEL selector2 = sel_registerName("function1_class");
    Method method2 = class_getInstanceMethod(objc_getMetaClass("Car"), selector2);
    [self logMethodDescription:method2];
    
    //获取function2_class
    SEL selector3 = sel_registerName("function2_class");
    Method method3 = class_getInstanceMethod(objc_getMetaClass("Car"), selector3);
    [self logMethodDescription:method3];
}
-(void)getMethodImplementation {
    IMP imp1 = class_getMethodImplementation(objc_getClass("Car"), sel_registerName("function1"));
    imp1();
    
    IMP imp2 = class_getMethodImplementation(objc_getMetaClass("Car"), sel_registerName("function1_class"));
    imp2();
    
    Method method1 = class_getInstanceMethod(objc_getClass("Car"), sel_registerName("function1"));
    IMP imp3 = method_getImplementation(method1);
    imp3();
    
    Method method2 = class_getInstanceMethod(objc_getMetaClass("Car"), sel_registerName("function1_class"));
    IMP imp4 = method_getImplementation(method2);
    imp4();
    
}

-(void)copyMethodList {
    unsigned int count1 ;
    Method* instanceMethods = class_copyMethodList(objc_getClass("Car"), &count1);
    
    unsigned int count2 ;
    Method* classMethods = class_copyMethodList(objc_getMetaClass("Car"), &count2);
    NSLog(@"--------------------------");
    for (unsigned int i = 0; i < count1; i++) {
        Method method = instanceMethods[i];
        [self logMethodDescription:method];
    }
    NSLog(@"--------------------------");

    for (unsigned int i = 0; i < count1; i++) {
        Method method = classMethods[i];
        [self logMethodDescription:method];
    }
    
    free(instanceMethods);
    free(classMethods);

}

-(void)setImplementation {
    Method method = class_getClassMethod(objc_getMetaClass("Car"), sel_registerName("function1_class"));
    IMP imp = class_getMethodImplementation(objc_getClass("Car"), sel_registerName("function1"));
    
    IMP oldIMP = method_setImplementation(method, imp);
    
    oldIMP();
    
    IMP newIMP = method_getImplementation(method);
    
    newIMP();
}

-(void)getSEL {
    Method method = class_getClassMethod(objc_getMetaClass("Car"), sel_registerName("function1_class"));
    SEL sel = method_getName(method);
    NSLog(@"sel = %s",sel_getName(sel));
}

-(void)getType {
    Method method = class_getInstanceMethod(objc_getClass("Car"), sel_registerName("function1"));
    const char* type = method_getTypeEncoding(method);
    NSLog(@"type = %s",type);
    
    int count  = method_getNumberOfArguments(method);
    NSLog(@"count = %d",count);

    char* returnChar = method_copyReturnType(method);
    NSLog(@"returnChar = %s",returnChar);
    
    for (int i = 0; i < count; i++) {
        char* argumentType = method_copyArgumentType(method,i);
        NSLog(@"第%d个参数类型为%s",i,argumentType);
    }
    
    char dst[2] = {};
    method_getReturnType(method,dst,2);
    NSLog(@"returnType = %s",dst);
    
    
    for (int i = 0; i < count; i++) {
        char dst2[2] = {};
        method_getArgumentType(method,i,dst2,2);
        NSLog(@"第%d个参数类型为%s",i,dst2);
    }
    
}

-(void)addMethod {
    IMP imp = class_getMethodImplementation(objc_getClass("Car"), sel_registerName("function1"));
    //v@: 无参数，无返回值
    BOOL addSuccess = class_addMethod(objc_getClass("Car"), sel_registerName("test"), imp, "v@:");
    NSLog(@"增加不存在的方法 = %d",addSuccess);
    
    BOOL addSuccess2 = class_addMethod(objc_getClass("Car"), sel_registerName("function1"), imp, "v@:");
    NSLog(@"增加已存在的方法 = %d",addSuccess2);
}

-(void)exchangeImplementations {
    Method method1 = class_getInstanceMethod(objc_getClass("Car"), sel_registerName("function1"));
    Method method2 = class_getInstanceMethod(objc_getClass("Car"), sel_registerName("function3"));
    //交换方法
    method_exchangeImplementations(method1, method2);
    //此时的function1的实现应该是`function3`的实现
    IMP imp1 = method_getImplementation(method1);
    //此时的function3的实现应该是`function1`的实现
    IMP imp2 = method_getImplementation(method2);

    imp1();
    imp2();
}
#pragma mark - Ivar
-(void)logIvarName:(Ivar)ivar {
    if (ivar) {
        const char* name = ivar_getName(ivar);
        NSLog(@"name = %s",name);
    } else {
        NSLog(@"ivar为null");
    }
}

-(void)getIvar {
    Ivar ivar = class_getInstanceVariable(objc_getClass("Cat"), "_name");
    Ivar ivar1 = class_getInstanceVariable(objc_getClass("Cat"), "_age");
    [self logIvarName:ivar];
    [self logIvarName:ivar1];

}


-(void)copyIvarList {
    unsigned int count;
    Ivar* ivars =class_copyIvarList(objc_getClass("Cat"), &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        [self logIvarName:ivar];
    }
    free(ivars);
}

-(void)getTypeEncoding {
    Ivar ivar = class_getInstanceVariable(objc_getClass("Cat"), "_name");
    const char* type = ivar_getTypeEncoding(ivar);
    NSLog(@"type = %s",type);
}

-(void)getIvarValue {
    Cat* cat = [Cat new];
    Ivar ivar = class_getInstanceVariable(objc_getClass("Cat"), "_name");
    NSString* name = object_getIvar(cat, ivar);
    NSLog(@"赋值前：%@",name);
    cat.name = @"jack";
    NSString* name2 = object_getIvar(cat, ivar);
    NSLog(@"赋值后：%@",name2);
}



-(void)setIvar {
    Cat* cat = [Cat new];
    Ivar ivar = class_getInstanceVariable(objc_getClass("Cat"), "_breed");
    Ivar ivar2 = class_getInstanceVariable(objc_getClass("Cat"), "_style");
    object_setIvar(cat, ivar,@"英短");
    object_setIvar(cat, ivar2,@"活泼");
    NSLog(@"breed = %@",cat.breed);
    NSLog(@"style = %@",cat.style);
}

-(void)getOffset {
    unsigned int count;
    Ivar* ivars =class_copyIvarList(objc_getClass("Cat"), &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        ptrdiff_t offset = ivar_getOffset(ivar);
        NSLog(@"%s = %td",ivar_getName(ivar),offset);
    }
    free(ivars);
    NSLog(@"Cat总字节 = %lu",class_getInstanceSize(objc_getClass("Cat")));
}

-(void)ivarLayout {
    const uint8_t* layouts = class_getIvarLayout(objc_getClass("Cat"));
    int i = 0;
    while (1) {
        uint8_t layout =  layouts[i];
        NSLog(@"%d",layout);
        i++;
        if (i == 10) {
            break;
        }
    }
    
}


-(void)addIvar {
    Class class = objc_allocateClassPair(objc_getClass("NSObject"), "Dog", 0);
    float alignment = log2f(sizeof(int));
    class_addIvar(class, "age", sizeof(int), alignment, "int");
    objc_registerClassPair(class);
    Ivar ivar = class_getInstanceVariable(class, "age");
    NSLog(@"name = %s",ivar_getName(ivar));
    NSLog(@"size = %zu",class_getInstanceSize(objc_getClass("Dog")));
}

-(void)getIvarLayout {
    const uint8_t *strongLayout =   class_getIvarLayout(objc_getClass("Lion"));
    if (!strongLayout) {
        return;
    }
    uint8_t byte;
    while ((byte = *strongLayout++)) {
        printf("strongLayout = #%02x\n",byte);
    }
    
    const uint8_t *weakLayout =   class_getWeakIvarLayout(objc_getClass("Lion"));
    if (!weakLayout) {
        return;
    }
    while ((byte = *weakLayout++)) {
        printf("weakLayout = #%02x\n",byte);
    }
}

#pragma mark - property
-(void)logProperty:(objc_property_t)property {
    NSLog(@"-------------------");
    unsigned int count;
    objc_property_attribute_t* attributeList = property_copyAttributeList(property, &count);
    for (unsigned int i = 0; i < count; i++) {
       objc_property_attribute_t attribute = attributeList[i];
        NSLog(@"name = %s",attribute.name);
        NSLog(@"value = %s",attribute.value);
    }
}

-(void)getProperty {
    objc_property_t property = class_getProperty(objc_getClass("Cat"), "name");
    [self logProperty:property];
}

-(void)copyPropertyList {
    unsigned int count;
    objc_property_t* propertyList = class_copyPropertyList(objc_getClass("Cat"), &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        NSLog(@"name = %s",property_getName(property));
    }
    free(propertyList);
}

-(void)getAttributes {
    objc_property_t property = class_getProperty(objc_getClass("Cat"), "name");
    const char* attributes = property_getAttributes(property);
    NSLog(@"attributes = %s",attributes);
}


-(void)copyAttributeValue {
    objc_property_t property = class_getProperty(objc_getClass("Cat"), "name");
    //V我们已知是属性所代表的ivar的名字，看打印是否是ivar
    char* value = property_copyAttributeValue(property,"V");
    NSLog(@"value = %s",value);
}

-(void)addProperty {
    unsigned int count = 5;
    objc_property_attribute_t attributeList[count];
    objc_property_attribute_t attribute1 ;
    attribute1.name = "T";
    attribute1.value = "NSString";
    objc_property_attribute_t attribute2 ;
    attribute2.name = "V";
    attribute2.value = "_mood";
    objc_property_attribute_t attribute3 ;
    attribute3.name = "N";
    attribute3.value = "";
    objc_property_attribute_t attribute4 ;
    attribute4.name = "C";
    attribute4.value = "";
    objc_property_attribute_t attribute5 ;
    attribute5.name = "R";
    attribute5.value = "";
    attributeList[0] = attribute1;
    attributeList[1] = attribute2;
    attributeList[2] = attribute3;
    attributeList[3] = attribute4;
    attributeList[4] = attribute5;
    
    BOOL isSuccess = class_addProperty(objc_getClass("Cat"), "mood", (const objc_property_attribute_t *)&attributeList, count);
    NSLog(@"新增%@",isSuccess?@"成功":@"失败");
    
    [self copyPropertyList];
    
    objc_property_t property = class_getProperty(objc_getClass("Cat"), "mood");
    const char* attributes = property_getAttributes(property);
    NSLog(@"attributes = %s",attributes);
}

-(void)replaceProperty {
    unsigned int count = 4;
    objc_property_attribute_t attributeList[count];
    objc_property_attribute_t attribute1 ;
    attribute1.name = "T";
    attribute1.value = "NSString";
    objc_property_attribute_t attribute2 ;
    attribute2.name = "V";
    attribute2.value = "_mood";
    objc_property_attribute_t attribute3 ;
    attribute3.name = "N";
    attribute3.value = "";
    objc_property_attribute_t attribute4 ;
    attribute4.name = "C";
    attribute4.value = "";
    attributeList[0] = attribute1;
    attributeList[1] = attribute2;
    attributeList[2] = attribute3;
    attributeList[3] = attribute4;

    class_replaceProperty(objc_getClass("Cat"), "name", (const objc_property_attribute_t*)&attributeList, count);
    [self copyPropertyList];

    objc_property_t property = class_getProperty(objc_getClass("Cat"), "name");
    const char* attributes = property_getAttributes(property);
    NSLog(@"attributes = %s",attributes);
    
}


#pragma mark - protocol
-(void)protocolCommen {
    Protocol *protocol = objc_getProtocol("PlayProtocol");
    if (protocol) {
        const char* name = protocol_getName(protocol);
        NSLog(@"name = %s",name);
    }else {
        NSLog(@"不存在该协议");
    }
}


-(void)conformsToProtocol {
    Protocol* playProtocol = objc_getProtocol("PlayProtocol");
    Protocol* singProtocol = objc_getProtocol("SingProtocol");

    BOOL isConform = protocol_conformsToProtocol(playProtocol, singProtocol);
    NSLog(@"PlayProtocol协议  %@ SingProtocol协议",isConform?@"遵循":@"不遵循");
    BOOL isConform2 = protocol_conformsToProtocol(singProtocol, playProtocol);
    NSLog(@"SingProtocol协议  %@ PlayProtocol协议",isConform2?@"遵循":@"不遵循");

}

-(void)isEqual {
    Protocol* playProtocol = objc_getProtocol("PlayProtocol");
    Protocol* runProtocol = objc_getProtocol("SingProtocol");
    BOOL isEqual = protocol_isEqual(playProtocol, runProtocol);
    NSLog(@"%@",isEqual?@"相等":@"不相等");
}

-(void)isEqual2 {
    Protocol* playProtocol1 = objc_getProtocol("PlayProtocol");
    NSLog(@"playProtocol1 = %@",playProtocol1);
    Protocol* playProtocol2 = objc_getProtocol("PlayProtocol");
    NSLog(@"playProtocol2 = %@",playProtocol2);
    BOOL isEqual = protocol_isEqual(playProtocol1, playProtocol2);
    NSLog(@"%@",isEqual?@"相等":@"不相等");
}

-(void)getMethodDescription  {
    Protocol* singProtocol = objc_getProtocol("SingProtocol");
    struct objc_method_description method =  protocol_getMethodDescription(singProtocol, sel_registerName("singFolkSongs"), YES, YES);
    NSLog(@"singFolkSongs方法 name = %s,types = %s", sel_getName(method.name)  ,method.types);
    
    struct objc_method_description method1 =  protocol_getMethodDescription(singProtocol, sel_registerName("singRockSongs"), YES, NO);
    NSLog(@"singRockSongs方法 name = %s,types = %s", sel_getName(method1.name)  ,method1.types);
    
    struct objc_method_description method2 =  protocol_getMethodDescription(singProtocol, sel_registerName("singPopularSongs"), NO, YES);
    NSLog(@"singPopularSongs方法 name = %s,types = %s", sel_getName(method2.name)  ,method2.types);
    
    struct objc_method_description method3 =  protocol_getMethodDescription(singProtocol, sel_registerName("singMetalSongs"), NO, NO);
    NSLog(@"singMetalSongs方法 name = %s,types = %s", sel_getName(method3.name)  ,method3.types);
}


-(void)copyMethodDescriptionList {
    Protocol* singProtocol = objc_getProtocol("SingProtocol");
    unsigned int count1;
    struct objc_method_description *methodList1 =   protocol_copyMethodDescriptionList(singProtocol, YES, YES, &count1);
    NSLog(@"-----必要方法以及实例方法-----");
    for (unsigned int i = 0; i < count1; i++) {
        struct objc_method_description method = methodList1[i];
        NSLog(@"name = %s,types = %s", sel_getName(method.name)  ,method.types);

    }
    free(methodList1);
    
    unsigned int count2;
    struct objc_method_description *methodList2 =   protocol_copyMethodDescriptionList(singProtocol, YES, NO, &count2);
    NSLog(@"-----必要方法以及类方法-----");
    for (unsigned int i = 0; i < count2; i++) {
        struct objc_method_description method = methodList2[i];
        NSLog(@"name = %s,types = %s", sel_getName(method.name)  ,method.types);
        
    }
    free(methodList2);

    
    unsigned int count3;
    struct objc_method_description *methodList3 =   protocol_copyMethodDescriptionList(singProtocol, NO, NO, &count3);
    NSLog(@"-----可选方法以及类方法-----");
    for (unsigned int i = 0; i < count3; i++) {
        struct objc_method_description method = methodList3[i];
        NSLog(@"name = %s,types = %s", sel_getName(method.name)  ,method.types);
        
    }
    free(methodList3);

    
    unsigned int count4;
    struct objc_method_description *methodList4 =   protocol_copyMethodDescriptionList(singProtocol, NO, YES, &count4);
    NSLog(@"-----可选方法以及实例方法-----");
    for (unsigned int i = 0; i < count4; i++) {
        struct objc_method_description method = methodList4[i];
        NSLog(@"name = %s,types = %s", sel_getName(method.name)  ,method.types);
        
    }
    free(methodList4);

}

-(void)getProperty_Protocol {
    Protocol* singProtocol = objc_getProtocol("SingProtocol");
    objc_property_t rockSongsProperty = protocol_getProperty(singProtocol, "rockSongs", YES, NO);
    const char* rockSongsName = property_getName(rockSongsProperty);
    NSLog(@"rockSongs 属性 name = %s",rockSongsName);
    
    objc_property_t folkSongsProperty = protocol_getProperty(singProtocol, "folkSongs", YES, YES);
    const char* folkSongsName = property_getName(folkSongsProperty);
    NSLog(@"folkSongs 属性 name = %s",folkSongsName);
    
    objc_property_t popularSongsProperty = protocol_getProperty(singProtocol, "popularSongs", YES, YES);
    const char* popularSongsName = property_getName(popularSongsProperty);
    NSLog(@"popularSongs 属性 name = %s",popularSongsName);
    
    objc_property_t metalSongsProperty = protocol_getProperty(singProtocol, "metalSongs", YES, NO);
    const char* metalSongsName = property_getName(metalSongsProperty);
    NSLog(@"metalSongs 属性 name = %s",metalSongsName);
    
}

-(void)copyPropertyList_protocol {
    Protocol* singProtocol = objc_getProtocol("SingProtocol");

    NSLog(@"-----copyPropertyList------");
    unsigned int count;
    objc_property_t* propertyList = protocol_copyPropertyList(singProtocol, &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        NSLog(@"name = %s",property_getName(property));
    }
    free(propertyList);

    NSLog(@"-----copyPropertyList2---instance propertys---");
    unsigned int count2;
    objc_property_t* propertyList2 = protocol_copyPropertyList2(singProtocol, &count2, YES, YES);
    for (unsigned int i = 0; i < count2; i++) {
        objc_property_t property = propertyList2[i];
        NSLog(@"name = %s",property_getName(property));
    }
    free(propertyList2);
    NSLog(@"-----copyPropertyList2---class propertys---");
    unsigned int count3;
    objc_property_t* propertyList3 = protocol_copyPropertyList2(singProtocol, &count3, YES, NO);
    for (unsigned int i = 0; i < count3; i++) {
        objc_property_t property = propertyList3[i];
        NSLog(@"name = %s",property_getName(property));
    }
    free(propertyList3);
}

-(void)conformsToProtocol_class {
    Protocol* playProtocol = objc_getProtocol("PlayProtocol");
    Protocol* runProtocol = objc_getProtocol("RunProtocol");

    BOOL isConforms = class_conformsToProtocol(objc_getClass("Person"), playProtocol);
    BOOL isConforms2 = class_conformsToProtocol(objc_getClass("Person"), runProtocol);

    NSLog(@"Person %@ PlayProtocol协议",isConforms?@"遵循":@"不遵循");
    NSLog(@"Person %@ RunProtocol协议",isConforms2?@"遵循":@"不遵循");
}


-(void)copyProtocolList {
    Protocol* eatProtocol = objc_getProtocol("EatProtocol");
    unsigned int count;
    __unsafe_unretained Protocol** protocolList = protocol_copyProtocolList(eatProtocol, &count);
    
    for (unsigned int i = 0; i < count ; i++) {
        Protocol* protocol = protocolList[i];
        NSLog(@"%s",protocol_getName(protocol));
    }
    
    free(protocolList);
}

-(void)copyProtocolList_class {
    Class class = objc_getClass("Person");
    unsigned int count;
    __unsafe_unretained Protocol** protocolList = class_copyProtocolList(class, &count);
    for (unsigned int i = 0; i < count ; i++) {
        Protocol* protocol = protocolList[i];
        NSLog(@"%s",protocol_getName(protocol));
    }
    
    free(protocolList);
}

-(void)copyProtocolList_objc {
    unsigned int count;
    __unsafe_unretained Protocol** protocolList = objc_copyProtocolList(&count);
    for (unsigned int i = 0; i < count ; i++) {
        Protocol* protocol = protocolList[i];
        NSLog(@"%s",protocol_getName(protocol));
    }
    
    free(protocolList);
}

-(void)allocateProtocol {
    Protocol* protocol = objc_allocateProtocol("TestProtocol");
    objc_registerProtocol(protocol);
    NSLog(@"%s",protocol_getName(protocol));
}

-(void)addMethodDescription1 {
    Protocol* eatProtocol = objc_getProtocol("EatProtocol");
    SEL selector = sel_registerName("test");
    const char* type = "v@:";
    BOOL isRequiredMethod = YES;
    BOOL isInstanceMethod = YES;
    protocol_addMethodDescription(eatProtocol, selector, type, isRequiredMethod, isInstanceMethod);
    
    struct objc_method_description method =  protocol_getMethodDescription(eatProtocol, sel_registerName("test"), YES, YES);
    NSLog(@"test方法 name = %s,types = %s", sel_getName(method.name)  ,method.types);
}

-(void)addMethodDescription2 {
    Protocol* protocol = objc_allocateProtocol("TestProtocol");
    
    SEL selector = sel_registerName("test");
    const char* type = "v@:";
    BOOL isRequiredMethod = YES;
    BOOL isInstanceMethod = YES;
    protocol_addMethodDescription(protocol, selector, type, isRequiredMethod, isInstanceMethod);
    objc_registerProtocol(protocol);

    struct objc_method_description method =  protocol_getMethodDescription(protocol, sel_registerName("test"), YES, YES);
    NSLog(@"test方法 name = %s,types = %s", sel_getName(method.name)  ,method.types);
}

-(void)addProperty_protocol {
    Protocol* protocol = objc_allocateProtocol("TestProtocol");
    const char* name = "juice";

    unsigned int count = 5;
    objc_property_attribute_t attributeList[count];
    objc_property_attribute_t attribute1 ;
    attribute1.name = "T";
    attribute1.value = "NSString";
    objc_property_attribute_t attribute2 ;
    attribute2.name = "V";
    attribute2.value = "_juice";
    objc_property_attribute_t attribute3 ;
    attribute3.name = "N";
    attribute3.value = "";
    objc_property_attribute_t attribute4 ;
    attribute4.name = "C";
    attribute4.value = "";
    objc_property_attribute_t attribute5 ;
    attribute5.name = "R";
    attribute5.value = "";
    attributeList[0] = attribute1;
    attributeList[1] = attribute2;
    attributeList[2] = attribute3;
    attributeList[3] = attribute4;
    attributeList[4] = attribute5;
    
    BOOL isRequiredProperty = YES;
    BOOL isInstanceProperty = YES;
    protocol_addProperty(protocol, name, (const objc_property_attribute_t*)attributeList, count, isRequiredProperty, isInstanceProperty);
    objc_registerProtocol(protocol);

    objc_property_t property = protocol_getProperty(protocol, "juice", YES, YES);

    NSLog(@"name = %s",property_getName(property));
}


-(void)addProtocol_protocol {
    Protocol* protocol = objc_allocateProtocol("TestProtocol");
    Protocol* protocol2 = objc_getProtocol("SingProtocol");
    protocol_addProtocol(protocol, protocol2);
    objc_registerProtocol(protocol);
    
    BOOL isConform = protocol_conformsToProtocol(protocol, protocol2);
    NSLog(@"isConform = %d",isConform);
}

-(void)addProtocol_class {
    Protocol* protocol = objc_getProtocol("PlayProtocol");
    Class class = objc_getClass("Cat");
    class_addProtocol(class, protocol);
    BOOL isConform = class_conformsToProtocol(class, protocol);
    NSLog(@"isConform = %d",isConform);
}
@end
