package com.miniprovider.util;

import com.miniprovider.dao.IDao;
import com.miniprovider.entity.ConRequestBean;
import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import javax.validation.Valid;

@Component
public class FlowConRequestUtil {

    @Resource(name="conRequestDaoImpl")
    private IDao<ConRequestBean> idao;

    public String addRequest(@Valid ConRequestBean conRequestBean){
        idao.add(conRequestBean);
        return "added";
    }
}
