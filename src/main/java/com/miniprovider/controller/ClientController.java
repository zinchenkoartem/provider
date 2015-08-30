package com.miniprovider.controller;


import com.miniprovider.entity.AddressBean;
import com.miniprovider.entity.ConRequestBean;
import com.miniprovider.exceptions.DuplicateEntryExceptions;
import com.miniprovider.dao.IClientService;
import com.miniprovider.dao.IDao;
import com.miniprovider.entity.ClientBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;

@Controller
public class ClientController {

    @Resource(name="clientDaoImpl")
    private IDao<ClientBean> cl_dao;
    @Resource(name="conRequestDaoImpl")
    private IDao<ConRequestBean> con_req_dao;
    @Resource(name="addressDaoImpl")
    private IDao<AddressBean> adr_dao;
    @Resource(name="clientServiceImpl")
    private IClientService clientService;


    @RequestMapping(value = "/admin/allclient", method = RequestMethod.GET)
        public  String getAllParam(@RequestParam(value = "from", required = false)  Integer from, Model model){
        if ( from!=null){
            if( from<0) {
             from=0;
            }
            List<ClientBean> cl_list = cl_dao.getAll(from,10);
            if (cl_list.isEmpty() ) {
                model.addAttribute("disable_next", "disabled");
                model.addAttribute("prev_page_from", from-20);
                model.addAttribute("cl_list", cl_dao.getAll(from-10,10));
                return "all_client";
            }
            if (cl_list.size()<10 ) {
                model.addAttribute("disable_next", "disabled");
            }
            if (from<=0){
                model.addAttribute("disable_prev", "disabled");
            }
            model.addAttribute("cl_list", cl_list);
            model.addAttribute("prev_page_from", from-10);
            model.addAttribute("next_page_from", from+10);
        }
        else{
            model.addAttribute("disable_prev", "disabled");
            model.addAttribute("disable_next", "disabled");
            model.addAttribute("cl_list", cl_dao.getAll());
        }
        return "all_client";
    }

    @RequestMapping(value = "/admin/client/{id}", method = RequestMethod.GET)
    public  String get(@PathVariable  Integer id,  Model model){
        ClientBean clientBean= cl_dao.get(id);
        if(clientBean!=null) {
            model.addAttribute("cl", cl_dao.get(id));
            model.addAttribute("action", "/admin/client/update");
            return "client_info";
        }
        model.addAttribute("info", "Абонент c даным номером не существует");
        return "adminpage";
    }

    @RequestMapping(value = "/admin/client", method = RequestMethod.GET)
    public  String getFromRequestParam(@RequestParam(value = "id", required = true)  Integer id,  Model model){
        ClientBean clientBean= cl_dao.get(id);
        if(clientBean!=null) {
            model.addAttribute("cl", cl_dao.get(id));
            model.addAttribute("action", "/admin/client/update");
            return "client_info";
        }
        model.addAttribute("info", "Абонент c даным номером не существует");
        return "adminpage";
    }

    @RequestMapping(value = "/client/home", method = RequestMethod.GET)
    public  String toMainPage(@RequestParam(value="info", required=false)  String info,Model model,Authentication authentication,HttpSession session){
       ClientBean clientBean=getClientBeanFromSecCtx(authentication);
            if (clientBean.getRole().equals("admin")) {
               if  (session.getAttribute("admin")==null)
                session.setAttribute("admin",clientBean);
                return "redirect:/admin/adminpage";
            }
            else {
                model.addAttribute("cl", cl_dao.get(clientBean.getClient_ID()));
                model.addAttribute("info",info);
                model.addAttribute("action", "/client/update_me");
                return "client_info";
            }
    }

    @RequestMapping(value = "/admin/adminpage", method = RequestMethod.GET)
    public  String getAdminpage(@RequestParam(value="info", required=false)  String info,Model model) {
        int con_req_size = con_req_dao.getAll().size();
        model.addAttribute("info", info);
        model.addAttribute("con_req_size",con_req_size);
        if (con_req_size==0){
            model.addAttribute("disabled_con_rec_button", "disabled");
        }
        return "adminpage";
    }

    @RequestMapping(value = "/admin/client/add", method = RequestMethod.GET)
    public  String getAdd(Model model){
        model.addAttribute("adr_list",adr_dao.getAll());
        model.addAttribute("clientBean", new ClientBean());
        return "add_client";
    }

    @RequestMapping(value = "/admin/client/add", method = RequestMethod.POST)
    public  String add( @Valid ClientBean clientBean,Errors errors, Model model,
                                @RequestParam(value = "id_con_req", required = false) Integer id_con_req){
       if (errors.hasErrors()) {
           model.addAttribute("adr_list",adr_dao.getAll());
           return "add_client";
       }
        try {
          cl_dao.add(clientBean);
        }catch (DuplicateEntryExceptions e){
            model.addAttribute("clientBean",clientBean);
            model.addAttribute("err",e.getMessage());
            model.addAttribute("adr_list",adr_dao.getAll());
            return "add_client";
        }
        if (id_con_req !=null){
            con_req_dao.delete(id_con_req);
        }
                model.addAttribute("info", "Абонент успешно добавлен  ");
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/admin/client/update", method = RequestMethod.GET)
    public  String getUpdate(@RequestParam(value = "id")Integer id, Model model){
       ClientBean clientBean = cl_dao.get(id);
        if (clientBean !=null){
            model.addAttribute("adr_list",adr_dao.getAll());
            clientBean.setPassword("");
            model.addAttribute("clientBean", clientBean);
            return "update_client";
        }
        else {
            model.addAttribute("info", "Абонент c даным номером не существует");
            return "adminpage";
        }
    }

    @RequestMapping(value = "/admin/client/update", method = RequestMethod.POST)
    public  String update(@Valid ClientBean clientBean,Errors errors, Model model){
        if (errors.hasErrors()) {
            model.addAttribute("adr_list",adr_dao.getAll());
            model.addAttribute("clientBean", clientBean);
            return "update_client";
        }
        try {
          cl_dao.update(clientBean);
        } catch (DuplicateEntryExceptions e){
            model.addAttribute("err",e.getMessage());
            model.addAttribute("adr_list",adr_dao.getAll());
            model.addAttribute("clientBean",clientBean);
            return "update_client";
        }
        model.addAttribute("info", "Абонент успешно обновлен");
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/client/update_me", method = RequestMethod.GET)
    public  String getUpdateMe(@RequestParam(value = "id")Integer id, Model model, Authentication authentication){
        ClientBean current_client =  getClientBeanFromSecCtx(authentication);
        if (current_client.getStatus()==0){
            return "denied";
        }
        ClientBean clientBean = cl_dao.get(id);
        if (clientBean !=null) {
            if (current_client.getClient_ID() == id) {
                clientBean.setPassword("");
                model.addAttribute("clientBean", clientBean);
                return "update_me";
            }
            else return  "denied";
        }
        else {
            model.addAttribute("info", "Абонент c даным номером не существует");
            return "error_page";
        }
    }

    @RequestMapping(value = "/client/update_me", method = RequestMethod.POST)
    public  String updateMe(@Valid ClientBean clientBean,Errors errors, Model model){
        ClientBean cl = null;
        if (errors.hasErrors()) {
            return "update_me";
        }
        try {
            cl = cl_dao.update(clientBean);
        } catch (DuplicateEntryExceptions e){
            model.addAttribute("err",e.getMessage());
            model.addAttribute("clientBean",clientBean);
            return "add_client";
        }
        if(cl !=null) model.addAttribute("info", "Абонент успешно обновлен");
        else model.addAttribute("info", "Ошибка");
        return "redirect:/client/home";
    }

    @RequestMapping(value = "/admin/client/delete", method = RequestMethod.GET)
    public  String delete(@RequestParam(value="id", required=true)  Integer id,Model model) {
        int result = cl_dao.delete(id);
        if (result==-1) {
            model.addAttribute("info", "Абонент c даным номером не существует");
        }
        else  model.addAttribute("info", "Абонент успешно удален");
        return "adminpage";
    }

    @RequestMapping(value = "/client/delService", method = RequestMethod.GET)
    public  String deleteService(@RequestParam(value="id_serv", required=true)  Integer id_serv,
                                          @RequestParam(value="id_client", required=true)  Integer id_client,
                                          Model model, Authentication authentication) {
        String role = getRoleUser(authentication);
        int result = clientService.deleteService(id_client, id_serv);
        if (result==0) {
            model.addAttribute("info", "Ошибка");
        }
        else {
            model.addAttribute("info", "Услуга успешно удалена");
        }
        if  (role.equals("user"))
        return "redirect:/client/home";
        return "redirect:/admin/adminpage";
    }

    @RequestMapping(value = "/client/addService", method = RequestMethod.GET)
    public  String addService(@RequestParam(value="id_serv", required=true)  Integer id_serv,
                                          @RequestParam(value="id_client", required=true)  Integer id_client,
                                          Model model, Authentication authentication) {
        String role = getRoleUser(authentication);
        int result = clientService.addService(id_client, id_serv);
        if (result==0) {
            model.addAttribute("info", "Ошибка");
        }
        else {
            model.addAttribute("info", "Услуга успешно добавлена");
        }
        if  (role.equals("user"))
        return "redirect:/client/home";
        return "redirect:/admin/adminpage";
    }

    private String getRoleUser(Authentication authentication) {
        Set<String> roles=new HashSet<>();
        Object obj = authentication.getPrincipal();
        if (obj instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) obj;
            Set<GrantedAuthority> set = (Set<GrantedAuthority>) userDetails.getAuthorities();
                for (GrantedAuthority ga : set) {
                    roles.add(ga.getAuthority());
                }
        }
        if (roles.contains("admin"))
        {  return "admin";}
        else if    (roles.contains("user"))
        {return "user";}
        return "guest";
    }

    private ClientBean getClientBeanFromSecCtx(Authentication authentication){

        Object obj = authentication.getPrincipal();
        if (obj instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) obj;
            Set<GrantedAuthority> set = (Set<GrantedAuthority>) userDetails.getAuthorities();
            for (GrantedAuthority ga : set) {
                if (ga instanceof ClientBean){
                    return (ClientBean) ga;
                }
            }
        }
        return null;
    }
}