package com.miniprovider.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String main(){
        return "index";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin(Model model,  @RequestParam(value = "error", required = false) String error){

        if (error != null) {
            model.addAttribute("error_message", "Проверьте правильность введенных данных");

        }
        return "login";
    }

    @RequestMapping(value = "/denied", method = RequestMethod.GET)
    public  String denied( Model model) {
        return "denied";
    }

}
