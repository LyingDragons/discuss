package com.forum.web.listener;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.forum.service.MessageService;
import com.forum.service.impl.MessageServiceImpl;

public class MessageListener implements ServletContextListener {

    public void contextDestroyed(ServletContextEvent arg0)  { 
    }

    public void contextInitialized(ServletContextEvent arg0)  { 
    	
    	
    	MessageService ms=new MessageServiceImpl();
    	Timer timer=new Timer();
    	timer.schedule(new TimerTask(){
    		public void run(){
    			DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    			Date date=new Date();
    			Calendar ca = Calendar.getInstance();
    			ca.setTime(date);
    			ca.set(Calendar.DATE, ca.get(Calendar.DATE)-1);
    			String c = format1.format(ca.getTime());
    			ms.deleteMessage(c);
    		}
    	},1000,1000l*86400);
    }
	
}
