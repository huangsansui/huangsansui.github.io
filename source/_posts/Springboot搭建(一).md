---
title: SpringBoot框架搭建，一次就学会(一)
date: 2018-05-17 17:23:44 
categories: "框架" 
tags: SpringBoot
description: 
    从零搭建一个属于自己的SpringBoot框架，简单易懂一次就成功。
---

>本章讲述项目的初始搭建和Mybatis的整合，让我们的项目能启动并且操作数据库。我的项目环境：
JDK1.8,Maven,MySQL5.8;开发工具IDEA。如果你有更好的建议或者问题，请联系我：yyhq0622@163.com。感谢你的浏览，大牛轻喷~

<h2>项目新建</h2>

1.打开idea,选择Create New Project
![springboot1](http://p8urisuqw.bkt.clouddn.com/springboot1.png)

或者可以从[Spring官网](http://start.spring.io/)中创建

![springboot2](http://p8urisuqw.bkt.clouddn.com/springboot2.png)

2.点击Next,配置如下图

![springboot3](http://p8urisuqw.bkt.clouddn.com/springboot3.png)

3.选择我们要添加的依赖，或创建项目之后再pom.xml中添加，点击Next,配置如下图

![springboot4](http://p8urisuqw.bkt.clouddn.com/springboot4.png)

4.点击Next,创建项目

<h2>配置数据库信息</h2>

在application.properties中添加一下配置
```
## 数据库连接信息
spring.datasource.url=jdbc:mysql://localhost:3306/test?useSSL=false&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&transformedBitIsBoolean=true&autoReconnect=true&failOverReadOnly=false
spring.datasource.username=root
spring.datasource.password=root
spring.datasource.driverClassName=com.mysql.jdbc.Driver

```

首先先保证你下载了mysql,这里不做深究,注意修改你建的数据库名字，账号密码也对应修改

<h3>创建user表</h3>

```mysql
CREATE TABLE `user` (
    `id` int(32) NOT NULL AUTO_INCREMENT,
     `user_name` varchar(255) DEFAULT NULL,
     PRIMARY KEY (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8; 
```

<h2>建立好工程目录结构</h2>
![springboot5](http://p8urisuqw.bkt.clouddn.com/springboot5.png)

<h2>创建mybatis-config.xml</h2>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
        <configuration>
        <!-- 全局参数 -->    
        <settings>        
                <!-- 使全局的映射器启用或禁用缓存。 -->        
                <setting name="cacheEnabled" value="true"/>        
                <!-- 全局启用或禁用延迟加载。当禁用时，所有关联对象都会即时加载。 -->        
                <setting name="lazyLoadingEnabled" value="true"/>        
                <!-- 当启用时，有延迟加载属性的对象在被调用时将会完全加载任意属性。否则，每种属性将会按需要加载。 -->        
                <setting name="aggressiveLazyLoading" value="true"/>        
                <!-- 是否允许单条sql 返回多个数据集  (取决于驱动的兼容性) default:true -->        
                <setting name="multipleResultSetsEnabled" value="true"/>        
                <!-- 是否可以使用列的别名 (取决于驱动的兼容性) default:true -->        
                <setting name="useColumnLabel" value="true"/>        
                <!-- 允许JDBC 生成主键。需要驱动器支持。如果设为了true，这个设置将强制使用被生成的主键，有一些驱动器不兼容不过仍然可以执行。  default:false  -->        
                <setting name="useGeneratedKeys" value="true"/>        
                <!-- 指定 MyBatis 如何自动映射 数据基表的列 NONE：不隐射　PARTIAL:部分  FULL:全部  -->        
                <setting name="autoMappingBehavior" value="PARTIAL"/>        
                <!-- 这是默认的执行类型  （SIMPLE: 简单； REUSE: 执行器可能重复使用prepared statements语句；BATCH: 执行器可以重复执行语句和批量更新）  -->        
                <setting name="defaultExecutorType" value="SIMPLE"/>        
                <!-- 使用驼峰命名法转换字段。 -->        
                <setting name="mapUnderscoreToCamelCase" value="true"/>        
                <!-- 设置本地缓存范围 session:就会有数据的共享  statement:语句范围 (这样就不会有数据的共享 ) defalut:session -->        
                <setting name="localCacheScope" value="SESSION"/>        
                <!-- 设置但JDBC类型为空时,某些驱动程序 要指定值,default:OTHER，插入空值时不需要指定类型 -->        
                <setting name="jdbcTypeForNull" value="NULL"/>    
         </settings>
        </configuration>

```

<h2>配置Mybatis</h2>
```java
package com.example.demo.core;
import java.io.IOException;
import javax.sql.DataSource;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
/**
 * @author Huangqing
 * @date 2018/5/17 16:58
 */


@Configuration
@Mapper
@MapperScan("com.example.demo.dao")
public class MybatisConfig {
    /**   mybatis 配置路径     */
    private static String MYBATIS_CONFIG = "mybatis-config.xml";
    /**   mybatis mapper resource 路径     */
    private static String MAPPER_PATH = "/mapper/**.xml";

    @Autowired
    private DataSource dataSource;

    private String typeAliasPackage = "com.example.demo.model";

    /**
     *创建sqlSessionFactoryBean 实例
     * 并且设置configtion 如驼峰命名.等等
     * 设置mapper 映射路径
     * 设置datasource数据源
     * @return
     */
    @Bean
    public SqlSessionFactoryBean createSqlSessionFactoryBean() throws IOException {
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        /** 设置mybatis configuration 扫描路径 */
        sqlSessionFactoryBean.setConfigLocation(new ClassPathResource(MYBATIS_CONFIG));
        /** 添加mapper 扫描路径 */
        PathMatchingResourcePatternResolver pathMatchingResourcePatternResolver = new PathMatchingResourcePatternResolver();
        String packageSearchPath = ResourcePatternResolver.CLASSPATH_ALL_URL_PREFIX + MAPPER_PATH;
        sqlSessionFactoryBean.setMapperLocations(pathMatchingResourcePatternResolver.getResources(packageSearchPath));
        /** 设置datasource */
        sqlSessionFactoryBean.setDataSource(dataSource);
        /** 设置typeAlias 包扫描路径 */
        sqlSessionFactoryBean.setTypeAliasesPackage(typeAliasPackage);
        return sqlSessionFactoryBean;
    }
}
```

<h2>使用Mybatis-genertor快速建立实体，DAO,Mapper</h2>

1.pom.xml导入依赖

```xml
<!-- mybatis-generator -->
        <dependency>
            <groupId>org.mybatis.generator</groupId>
            <artifactId>mybatis-generator-core</artifactId>
            <version>1.3.5</version>
        </dependency>
```

2.创建mybatis-generator.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
    <!--数据库驱动-->
    <classPathEntry    location="D:\Maven\mysql\mysql-connector-java\5.1.46\mysql-connector-java-5.1.46.jar"/>
    <context id="DB2Tables"    targetRuntime="MyBatis3">
        <commentGenerator>
            <property name="suppressDate" value="true"/>
            <property name="suppressAllComments" value="true"/>
        </commentGenerator>
        <!--数据库链接地址账号密码-->
        <jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="jdbc:mysql://localhost:3306/test" userId="root" password="root">
        </jdbcConnection>
        <javaTypeResolver>
            <property name="forceBigDecimals" value="false"/>
        </javaTypeResolver>
        <!--生成Model类存放位置-->
        <javaModelGenerator targetPackage="com.example.demo.model" targetProject="./src/main/java">
            <property name="enableSubPackages" value="true"/>
            <property name="trimStrings" value="true"/>
        </javaModelGenerator>
        <!--生成映射文件存放位置-->
        <sqlMapGenerator targetPackage="mapper" targetProject="./src/main/resources">
            <property name="enableSubPackages" value="true"/>
        </sqlMapGenerator>
        <!--生成Dao类存放位置-->
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.example.demo.dao" targetProject="./src/main/java">
            <property name="enableSubPackages" value="true"/>
        </javaClientGenerator>
        <!--生成对应表及类名-->
        <table tableName="user" domainObjectName="User"
               enableCountByExample="false" enableUpdateByExample="false"
               enableDeleteByExample="false" enableSelectByExample="false"
               selectByExampleQueryId="false">
        </table>
    </context>
</generatorConfiguration>
```

PS：location是本地mysql-connector-java包地址，targetPackage是目标包，targetProject是目目标项目，tableName是数据库表名，domainObjectName是生成的实体名字

3.pom修改
```xml
        <plugin>
                <groupId>org.mybatis.generator</groupId>
                <artifactId>mybatis-generator-maven-plugin</artifactId>
                <version>1.3.5</version>
                <dependencies>
                    <dependency>
                        <groupId> mysql</groupId>
                        <artifactId> mysql-connector-java</artifactId>
                        <version> 5.0.8</version>
                    </dependency>
                    <dependency>
                        <groupId>org.mybatis.generator</groupId>
                        <artifactId>mybatis-generator-core</artifactId>
                        <version>1.3.5</version>
                    </dependency>
                </dependencies>
                <executions>
                    <execution>
                        <id>Generate MyBatis Artifacts</id>
                        <phase>package</phase>
                        <goals>
                            <goal>generate</goal>
                        </goals>
                    </execution>
                </executions>
                <configuration>
                    <!--允许移动生成的文件 -->
                    <verbose>true</verbose>
                    <!-- 是否覆盖 -->
                    <overwrite>true</overwrite>
                    <!-- 自动生成的配置 -->
                    <configurationFile>
                        src/main/resources/mybatis-generator.xml</configurationFile>
                </configuration>
            </plugin>
```

4.执行plugin
![springboot6](http://p8urisuqw.bkt.clouddn.com/springboot6.png)

可以看到生成了相应的实体类，DAO类，Mapper.xml

<h2>编写Controller</h2>

Controller
```java
package com.example.demo.controller;
import com.example.demo.model.User;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * @author Huangqing
 * @date 2018/5/17 17:45
 */
@RestController
    @RequestMapping("/user")
    public class UserController {
    @Autowired
    private UserService userService;
    @GetMapping("/{id}")
    public User getUser(@PathVariable("id") int id){
        return userService.getById(id);
        }
    }
```

Service
```java
package com.example.demo.service;

import com.example.demo.model.User;

/**
 * @author Huangqing
 * @date 2018/5/17 17:46
 */
public interface UserService {
    User getById(int id);
}
```

ServiceImpl
```java
package com.example.demo.service.impl;

import com.example.demo.dao.UserMapper;
import com.example.demo.model.User;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Huangqing
 * @date 2018/5/17 17:46
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User getById(int id) {
        return userMapper.selectByPrimaryKey(id);
    }
}

```


<h2>启动你的项目测试吧！</h2>

![springboot7](http://p8urisuqw.bkt.clouddn.com/springboot7.png)

<h3>结尾</h3>
本次搭建内容已经结束，后续的搭建待更新，感谢观看。有问题可以联系我 yyhq0622@163.com