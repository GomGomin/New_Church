package com.church.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	
		return "home";
	}

	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String notice(Locale locale, Model model) {
	
		return "home";
	}
	
	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public String header(Locale locale, Model model) {

		return "header";
	}

	@RequestMapping(value = "/vision", method = RequestMethod.GET)
	public String vision(Locale locale, Model model) {

		return "/about/vision";
	}

	@RequestMapping(value = "/history", method = RequestMethod.GET)
	public String history(Locale locale, Model model) {

		return "/about/history";
	}


	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public String map(Locale locale, Model model) {

		return "/about/map";
	}
	
	@RequestMapping(value = "/time", method = RequestMethod.GET)
	public String time(Locale locale, Model model) {

		return "/about/time";
	}
}