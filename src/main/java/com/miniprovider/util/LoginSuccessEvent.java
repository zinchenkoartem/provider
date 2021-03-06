package com.miniprovider.util;

import com.miniprovider.entity.ClientBean;
import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;

@Service
public class LoginSuccessEvent implements AuthenticationSuccessHandler {

    private static final Logger logger = Logger.getLogger(LoginSuccessEvent.class);

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

        ClientBean cl = null;
        Object obj = authentication.getPrincipal();
        if (obj instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) obj;
            Set<GrantedAuthority> set = (Set<GrantedAuthority>) userDetails.getAuthorities();
            for (GrantedAuthority ga : set) {
                if (ga instanceof ClientBean) {
                    cl = (ClientBean) ga;
                }
            }
        }

        if(cl!=null)
        logger.info("Logged In:  ->"+ "  IP:"+request.getRemoteAddr()+"  ->"+cl.toString());
        response.sendRedirect( request.getContextPath() + "/client/home" );
    }
}
