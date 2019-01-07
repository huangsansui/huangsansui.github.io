---
title: Swagger搭建
date: 2018-05-15 20:48:44 
categories: "Swagger" 
tags: Swagger
description: 简单记录Swgger文档搭建
---

之前的项目使用过次Swagger，但这次使用的时候发现有很多不熟悉的地方，花掉了很多时间，CV大法果然不太靠谱，还是踏踏实实多思考记录吧。

<!--more-->
#1.Swagger介绍
Swagger的目标是为REST APIs 定义一个标准的，与语言无关的接口，使人和计算机在看不到源码或者看不到文档或者不能通过网络流量检测的情况下能发现和理解各种服务的功能。当服务通过Swagger定义，消费者就能与远程的服务互动通过少量的实现逻辑。类似于低级编程接口，Swagger去掉了调用服务时的很多猜测。 

[Swagger官网](https://swagger.io/)

浏览  [Swagger-Spec](https://github.com/OAI/OpenAPI-Specification)去了解更多关于Swagger 项目的信息，包括附加的支持其他语言的库。

#2.搭建
##引入相关依赖
```xml
<!--使用Swagger2构建RESTful API文档-->
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger2</artifactId>
    <version>2.2.2</version>
</dependency>
<dependency>
    <groupId>io.springfox</groupId>
    <artifactId>springfox-swagger-ui</artifactId>
    <version>2.2.2</version>
 </dependency>
```
##修改启动代码
```java
@SpringBootApplication
@Configuration
@EnableSwagger2
public class Application extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    /**
     * 以下是使用swagger2 生成api文档
     *
     * @return
     */
    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                //当前包路径
                .apis(RequestHandlerSelectors.basePackage("com.test.controller"))
                .paths(PathSelectors.any())
                .build();
    }

    /**
     * 构建 api文档的详细信息函数
     *
     * @return
     */
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                //页面标题
                .title("标题")
                //描述
                .description("描述")
                .termsOfServiceUrl("http://localhost:8080/swagger-ui.html")
                //创建人
                .contact("api")
                //版本
                .version("1.0")
                .build();
    }
}
```
搭建好之后可以启动项目可以打开浏览器，访问http://localhost:8080/swagger-ui.html 即可看到文档界面

#3.相关使用
简单的一个例子
```java
package com.dxyl.explame;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Huangqing
 * @date 2018/5/17 10:20
 */
@RestController
@RequestMapping("/swagger")
public class SwaggerController {

    @ApiOperation(value = "你好Swagger", notes = "测试使用")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "name", value = "姓名", dataType = "String", paramType = "query", required = true),
            @ApiImplicitParam(name = "age", value = "年龄", dataType = "int", paramType = "query", required = false)
    })
    @PostMapping("/hello")
    public String hello(@RequestParam(value = "name", required = false) String name, @RequestParam(value = "age", required = false) int age) {
        return String.format("Hello Swagger！name:%s,age:%s", name, age);
    }
}
```
测试结果
![Swagger](http://p8urisuqw.bkt.clouddn.com/swagger1.png)

##Swagger注解
| Api |作用范围|使用位置| 
| - | - | - | 
|@ApiModelProperty|对象属性 |用在出入参数对象的字段上|
|@Api|协议集描述 |用于controller类上|
|@ApiOperation |协议描述 |用在controller的方法上|
|@ApiResponses |Response集 |用在controller的方法上|
|@ApiResponse |Response |用在 @ApiResponses里边|
|@ApiImplicitParams |非对象参数集 |用在controller的方法上|
|@ApiImplicitParam |非对象参数描述 | 用在@ApiImplicitParams的方法里边|
|@ApiModel |描述返回对象的意义 |用在返回对象类上|

##@ApiImplicitParam中的属性详情

| 属性 |取值|使用位置| 
| - | - | - | 
|paramType | - |查询参数类型 | 
| - | path|以地址的形式提交数据 | 
| - |query | 直接跟参数完成自动映射赋值 | 
| - |body | 以流的形式提交 仅支持POST | 
| - | header | 参数在request headers 里边提交 | 
| - | form | 以form表单的形式提交 仅支持POST | 
| dataType | - |参数的数据类型 只作为标志说明，并没有实际验证 | 
| - | Long | - | 
| - | String | - | 
| - | int | - | 
| - | Object | - | 
|name | - |     接收参数名(非参数描述) | 
| value | - | 接收参数的意义描述 | 
|required | - | 参数是否必填 | 
| - | true |必填 | 
| - | false |非必填 | 
|defaultValue |  |  默认值 | 
