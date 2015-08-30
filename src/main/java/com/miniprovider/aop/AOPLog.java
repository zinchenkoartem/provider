package com.miniprovider.aop;

import com.miniprovider.dao.IDao;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.hibernate.engine.jdbc.spi.SqlExceptionHelper;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

@Component
@Aspect
public class AOPLog {

    private static final Logger logger = Logger.getLogger(AOPLog.class);

    @AfterReturning(value = "execution(* com.miniprovider.dao.IDao+.getAll(..)) && target(idao)  ", returning = "obj", argNames = "obj, idao")
    public void doLogAfterGetAll(Object obj, IDao idao){
        logger.debug("GETALL:  ->" + idao.getClass());
    }

    @AfterReturning(value = "execution(* com.miniprovider.dao.IDao+.get(..)) ", returning = "obj")
    public void doLogAfterGet(Object obj){
        if (obj!=null) logger.debug("GET:  ->" + obj.toString());
        else logger.debug("GET:  ->" + "Несуществующая запись!");
    }

    @AfterReturning(value = "execution(* com.miniprovider.dao.IDao+.update(..)) ", returning = "obj")
    public void doLogAfterUpdate(Object obj){
        logger.info("UPDATE!  -> "+obj.toString() );
    }

    @AfterReturning(value = "execution(* com.miniprovider.dao.IDao+.delete(..)) && target(idao) && args( id) ", returning = "obj", argNames = "obj, idao,id")
    public void doLogAfterDelete(Object obj, IDao idao, Integer id){
        logger.info("DELETE!  -> №"+id+"  "+idao.getClass() );
    }

    @AfterReturning(value = "execution(* com.miniprovider.dao.IDao+.add(..)) ", returning = "obj")
    public void doLogAfterAdd(Object obj){
        if (obj!=null)
        logger.info("ADD!  -> "+obj.toString() );
    }
}
