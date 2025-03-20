package com.example.aop;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@Aspect  //aop类
public class TimeAspect {
    /**
     * 连接点：joinPoint 可以被aop控制的方法
     * 通知：Advice 共性功能
     * 切入点：PointCut 匹配连接点的条件，通知仅会在切入点方法执行时被应用
     * 切面： Aspect 描述通知与切入点的对应关系 （通知 + 切入点）
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    @Around("execution(* com.example.service.*.*(..))")  //切入点表达式
    public Object recordTime(ProceedingJoinPoint joinPoint) throws Throwable{
        //1.记录开始时间
        long begin = System.currentTimeMillis();

        //2.调用原始方法运行
        Object result = joinPoint.proceed();

        //3.记录结束时间，计算方法执行耗时
        long end = System.currentTimeMillis();
        log.info(joinPoint.getSignature() + "方法执行耗时： {}ms", end-begin);
        return result;

    }
}
