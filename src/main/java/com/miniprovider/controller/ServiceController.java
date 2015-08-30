package com.miniprovider.controller;


import com.miniprovider.dao.IDao;
import com.miniprovider.entity.ServiceBean;
import com.miniprovider.exceptions.DuplicateEntryExceptions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.List;

@Controller
//@RequestMapping("/main")
public class ServiceController {

    @Resource(name="serviceDaoImpl")
    private IDao<ServiceBean> idao;


    @RequestMapping(value = "/admin/allservice", method = RequestMethod.GET)
    public  String getAll(@RequestParam(value = "from", required = false)  Integer from,Model model){
        if ( from!=null){
            if( from<0) {
                from=0;
            }
            List<ServiceBean> serv_list = idao.getAll(from,5);
            if (serv_list.isEmpty() ) {
                model.addAttribute("disable_next", "disabled");
                model.addAttribute("prev_page_from", from-5);
                model.addAttribute("serv_list", idao.getAll(from-5,5));
                return "all_service";
            }
            if (serv_list.size()<5 ) {
                model.addAttribute("disable_next", "disabled");
            }
            if (from<=0){
                model.addAttribute("disable_prev", "disabled");
            }
            model.addAttribute("serv_list", serv_list);
            model.addAttribute("prev_page_from", from-5);
            model.addAttribute("next_page_from", from+5);
        }
        else{
            model.addAttribute("disable_prev", "disabled");
            model.addAttribute("disable_next", "disabled");
            model.addAttribute("serv_list", idao.getAll());
        }
        return "all_service";
    }

    @RequestMapping(value = "/admin/service/{id}", method = RequestMethod.GET)
    public  String get(@PathVariable Integer id,Model model) {
        ServiceBean serviceBean=idao.get(id);
        if(serviceBean!=null) {
            model.addAttribute("service", idao.get(id));
            model.addAttribute("action", "/admin/service/update");
            return "service_info";
        }
        model.addAttribute("info", "Услуга c даным номером не существует");
        return "adminpage";
    }

    @RequestMapping(value = "/admin/service", method = RequestMethod.GET)
    public  String getFromRequestParam(@RequestParam(value = "id", required = true) Integer id,Model model) {
        ServiceBean serviceBean=idao.get(id);
        if(serviceBean!=null) {
            model.addAttribute("service", idao.get(id));
            model.addAttribute("action", "/admin/service/update");
            return "service_info";
        }
        model.addAttribute("info", "Услуга c даным номером не существует");
        return "adminpage";
    }

    @RequestMapping(value = "/admin/service/add", method = RequestMethod.GET)
    public  String getAdd(Model model){

        model.addAttribute("serviceBean", new ServiceBean());
        model.addAttribute("caption","Добавить");
        model.addAttribute("action","/admin/service/add");
        return "add_service";
    }

    @RequestMapping(value = "/admin/service/add", method = RequestMethod.POST)
    public  String add( @Valid ServiceBean serviceBean,Errors errors, Model model){
        if (errors.hasErrors()) {
            System.out.println(errors.getAllErrors());
            model.addAttribute("caption","Добавить");
            model.addAttribute("action","/admin/service/add");
            return "add_service";
        }
        try {
            idao.add(serviceBean);
        }catch (DuplicateEntryExceptions e){
            model.addAttribute("serviceBean",serviceBean);
            model.addAttribute("err",e.getMessage());
            model.addAttribute("caption","Добавить");
            model.addAttribute("action","/admin/service/add");
            return "add_service";
        }
        model.addAttribute("info", "Услуга успешно добавлена");
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/admin/service/update", method = RequestMethod.GET)
    public  String getUpdate(@RequestParam(value = "id")Integer id, Model model){
        ServiceBean serviceBean =idao.get(id);
        if (serviceBean !=null){
            model.addAttribute("serviceBean", serviceBean);
            model.addAttribute("caption","Изменить");
            model.addAttribute("action","/admin/service/update");
            model.addAttribute("readonly","true");
            return "add_service";
        }
        else {
            model.addAttribute("info", "Услуга c даным номером не существует");
            return "adminpage";
        }
    }

    @RequestMapping(value = "/admin/service/update", method = RequestMethod.POST)
    public  String update(@Valid ServiceBean serviceBean,Errors errors, Model model){

        if (errors.hasErrors()) {
            System.out.println(errors.getAllErrors());
//            model.addAttribute("serviceBean", serviceBean);
            model.addAttribute("caption","Изменить");
            model.addAttribute("action","/admin/service/update");
            return "add_service";
        }
        idao.update(serviceBean);
        model.addAttribute("info", "Услуга успешно обновлена");
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/admin/service/delete", method = RequestMethod.GET)
    public  String delete(@RequestParam(value="id", required=true)  Integer id,Model model) {
        int result = idao.delete(id);
        if (result==-1) {
            model.addAttribute("info", "Услуга c даным номером не существует");
        }
        else  model.addAttribute("info", "Услуга успешно удалена");
        return "adminpage";
    }
}
