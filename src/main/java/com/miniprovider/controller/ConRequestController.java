package com.miniprovider.controller;

import com.miniprovider.dao.IDao;
import com.miniprovider.entity.AddressBean;
import com.miniprovider.entity.ClientBean;
import com.miniprovider.entity.ConRequestBean;
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
public class ConRequestController {

    @Resource(name="conRequestDaoImpl")
    private IDao<ConRequestBean> idao;


    @RequestMapping(value = "/admin/allconRequest", method = RequestMethod.GET)
    public  String getAll(@RequestParam(value = "from", required = false)  Integer from,Model model){
        if ( from!=null){
            if( from<0) {
                from=0;
            }
            List<ConRequestBean> adr_list = idao.getAll(from,10);
            if (adr_list.isEmpty() ) {
                model.addAttribute("disable_next", "disabled");
                model.addAttribute("prev_page_from", from-10);
                model.addAttribute("conRequest_list", idao.getAll(from-10,10));
                return "all_con_request";
            }
            if (adr_list.size()<5 ) {
                model.addAttribute("disable_next", "disabled");
            }
            if (from<=0){
                model.addAttribute("disable_prev", "disabled");
            }
            model.addAttribute("conRequest_list", adr_list);
            model.addAttribute("prev_page_from", from-10);
            model.addAttribute("next_page_from", from+10);
        }
        else{
            model.addAttribute("disable_prev", "disabled");
            model.addAttribute("disable_next", "disabled");
            model.addAttribute("conRequest_list", idao.getAll());
        }
        return "all_con_request";
    }

    @RequestMapping(value = "/admin/conRequest/{id}", method = RequestMethod.GET)
    public  String get(@PathVariable Integer id,Model model) {
        ConRequestBean conRequestBean=idao.get(id);
            if(conRequestBean!=null) {
                model.addAttribute("conRequest", idao.get(id));
                model.addAttribute("action", "/admin/conRequest/update");
                return "conRequest_info";
            }
            model.addAttribute("info", "Адрес c даным номером не существует");
            return "adminpage";
    }

    @RequestMapping(value = "/admin/conRequest", method = RequestMethod.GET)
    public  String getFromRequestParam(@RequestParam(value = "id", required = true) Integer id,Model model) {
        ConRequestBean conRequestBean=idao.get(id);
        if(conRequestBean!=null) {
            model.addAttribute("address", idao.get(id));
            model.addAttribute("action", "/admin/conRequest/update");
            return "conRequest_info";
        }
        model.addAttribute("info", "Адрес c даным номером не существует");
        return "adminpage";
    }

    @RequestMapping(value = "/admin/conRequest/add", method = RequestMethod.GET)
    public  String getAdd(@RequestParam(value = "id", required = true) Integer id,Model model){
        ConRequestBean conRequestBean= idao.get(id);
        ClientBean clientBean=new ClientBean();
        clientBean.setPhone(conRequestBean.getPhone());
        clientBean.setEmail(conRequestBean.getEmail());
        clientBean.setAddress_id(conRequestBean.getAddress_id());
        clientBean.setRoom(conRequestBean.getRoom());
        clientBean.setFirstName(conRequestBean.getFirstName());
        clientBean.setLastName(conRequestBean.getLastName());
        model.addAttribute("id_con_req", id);
        model.addAttribute("clientBean", clientBean);
        model.addAttribute("con_req_address",conRequestBean.getAddressBean().getPath());
        return "add_client";
    }

    @RequestMapping(value = "/admin/conRequest/add", method = RequestMethod.POST)
    public  String add( @Valid ConRequestBean conRequestBean,Errors errors, Model model){
        if (errors.hasErrors()) {
            return "add_client";
        }
        try {
            idao.add(conRequestBean);
        }catch (DuplicateEntryExceptions e){
            model.addAttribute("addressBean",conRequestBean);
            model.addAttribute("err",e.getMessage());
            return "add_client";
        }
        model.addAttribute("info", "Абонент успешно добавлен");
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/admin/conRequest/delete", method = RequestMethod.GET)
    public  String delete(@RequestParam(value="id", required=true)  Integer id,Model model) {
        int result = idao.delete(id);
        if (result==-1) {
            model.addAttribute("info", "Заявка c даным номером не существует");
        }
        else  model.addAttribute("info", "Заявка успешно удалена");
        int con_req_size = idao.getAll().size();
        if (con_req_size==0){
            model.addAttribute("disabled_con_rec_button", "disabled");
        }
        model.addAttribute("con_req_size", con_req_size);
        return "adminpage";
    }

}
