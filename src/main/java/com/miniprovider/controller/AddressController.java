package com.miniprovider.controller;

import com.miniprovider.dao.IDao;
import com.miniprovider.entity.AddressBean;
import com.miniprovider.exceptions.DuplicateEntryExceptions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.List;

@Controller
public class AddressController {

    @Resource(name="addressDaoImpl")
    private IDao<AddressBean> idao;


    @RequestMapping(value = "/admin/alladdress", method = RequestMethod.GET)
    public  String getAll(@RequestParam(value = "from", required = false)  Integer from,Model model){
        if ( from!=null){
            if( from<0) {
                from=0;
            }
            List<AddressBean> adr_list = idao.getAll(from,10);
            if (adr_list.isEmpty() ) {
                model.addAttribute("disable_next", "disabled");
                model.addAttribute("prev_page_from", from-10);
                model.addAttribute("adr_list", idao.getAll(from-10,10));
                return "all_address";
            }
            if (adr_list.size()<5 ) {
                model.addAttribute("disable_next", "disabled");
            }
            if (from<=0){
                model.addAttribute("disable_prev", "disabled");
            }
            model.addAttribute("adr_list", adr_list);
            model.addAttribute("prev_page_from", from-10);
            model.addAttribute("next_page_from", from+10);
        }
        else{
            model.addAttribute("disable_prev", "disabled");
            model.addAttribute("disable_next", "disabled");
            model.addAttribute("adr_list", idao.getAll());
        }
        return "all_address";
    }

    @RequestMapping(value = "/admin/address/{id}", method = RequestMethod.GET)
    public  String get(@PathVariable Integer id,Model model) {
            AddressBean addressBean=idao.get(id);
            if(addressBean!=null) {
                model.addAttribute("address", idao.get(id));
                model.addAttribute("action", "/admin/address/update");
                return "address_info";
            }
            model.addAttribute("info", "Адрес c даным номером не существует");
            return "adminpage";
    }

    @RequestMapping(value = "/admin/address", method = RequestMethod.GET)
    public  String getFromRequestParam(@RequestParam(value = "id", required = true) Integer id,Model model) {
        AddressBean addressBean=idao.get(id);
        if(addressBean!=null) {
            model.addAttribute("address", idao.get(id));
            model.addAttribute("action", "/admin/address/update");
            return "address_info";
        }
        model.addAttribute("info", "Адрес c даным номером не существует");
        return "adminpage";
    }

    @RequestMapping(value = "/admin/address/add", method = RequestMethod.GET)
    public  String getAdd(Model model){

        model.addAttribute("addressBean", new AddressBean());
        model.addAttribute("caption","Добавить");
        model.addAttribute("action","/admin/address/add");
        return "add_address";
    }

    @RequestMapping(value = "/admin/address/add", method = RequestMethod.POST)
    public  String add( @Valid AddressBean addressBean,Errors errors, Model model){
        if (errors.hasErrors()) {
            model.addAttribute("caption","Добавить");
            model.addAttribute("action","/admin/address/add");
            return "add_address";
        }
        try {
            idao.add(addressBean);
        }catch (DuplicateEntryExceptions e){
            model.addAttribute("addressBean",addressBean);
            model.addAttribute("err",e.getMessage());
            model.addAttribute("caption","Добавить");
            model.addAttribute("action","/admin/address/add");;
            return "add_address";
        }
        model.addAttribute("info", "Адрес успешно добавлен");
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/admin/address/update", method = RequestMethod.GET)
    public  String getUpdate(@RequestParam(value = "id")Integer id, Model model){
        AddressBean addressBean =idao.get(id);
        if (addressBean !=null){
            model.addAttribute("addressBean", addressBean);
            model.addAttribute("caption","Изменить");
            model.addAttribute("action","/admin/address/update");
            model.addAttribute("readonly","true");
            return "add_address";
        }
        else {
            model.addAttribute("info", "Адрес c даным номером не существует");
            return "adminpage";
        }
    }

    @RequestMapping(value = "/admin/address/update", method = RequestMethod.POST)
    public  String update(@Valid AddressBean addressBean,Errors errors, Model model){

        if (errors.hasErrors()) {
            System.out.println(errors.getAllErrors());
//            model.addAttribute("addressBean", addressBean);
            model.addAttribute("caption","Изменить");
            model.addAttribute("action","/admin/address/update");
            return "add_address";
        }
        idao.update(addressBean);
        model.addAttribute("info", "Адрес успешно обновлен");
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/admin/address/delete", method = RequestMethod.GET)
    public  String delete(@RequestParam(value="id", required=true)  Integer id,Model model) {
        int result = idao.delete(id);
        if (result==-1) {
            model.addAttribute("info", "Адрес c даным номером не существует");
        }
        else  model.addAttribute("info", "Адрес успешно удален");
        return "adminpage";
    }

}
