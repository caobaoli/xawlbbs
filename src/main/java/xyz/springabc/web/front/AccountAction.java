package xyz.springabc.web.front;

import java.io.IOException;
import java.util.Random;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import xyz.springabc.domin.User;
import xyz.springabc.service.UserService;
import xyz.springabc.web.form.UserResetForm;

@Controller
@RequestMapping("/account")
public class AccountAction {
	
	@Autowired
	private UserService userServ;
	
	/**
	 * 登出动作
	 */
	@RequestMapping("/signout")
	public String signout(HttpServletRequest request,RedirectAttributes attributes){
		request.getSession().setAttribute("user", null);
		attributes.addFlashAttribute("msg","已经登出");
		return "redirect:/";
	}
	
	/**
	 * 注册页面
	 * @return
	 */
	@RequestMapping(value="/signup",method=RequestMethod.GET)
	public String singupPage(){
		return "/account/signup";
	}
	
	/**
	 * 注册动作
	 * @param user
	 * @param password1
	 * @param attributes
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/signup",method=RequestMethod.POST)
	public String singupAction(@Validated User user,
			Errors erros,
			String password1,
			RedirectAttributes attributese,
			HttpServletRequest request){
			User signinUser=userServ.signup(user, password1,erros);
			
			if(erros.hasErrors()){
				attributese.addFlashAttribute("myerror", "用户名三到十八个个字母或者下滑线,下划线不能再开头或结尾。请重试！");
				attributese.addFlashAttribute("user",user);
				attributese.addFlashAttribute("error",erros.getAllErrors());
				return "redirect:/account/signup";
			}
			
			request.getSession().setAttribute("user", signinUser);
			attributese.addFlashAttribute("msg","你已经成功注册登录");
			return "redirect:/";
	}
	
	/**
	 * 通过用户名检测用户
	 * @param username
	 * @return false 没有
	 */
	@RequestMapping("/checkUsername")
	@ResponseBody
	public boolean checkUsername(String username) {
		return userServ.getUserByNickOrEmailOrUsername(username)==null?false:true;
	}
	
	/**
	 * 通过昵称检测用户
	 * @param nick
	 * @return
	 */
	@RequestMapping("/checkNick")
	@ResponseBody
	public boolean checkNick(String nick) {
		return userServ.getUserByNickOrEmailOrUsername(nick)==null?false:true;
	}
	
	/**
	 * 按照邮件检测用户是否
	 * @param email
	 * @return
	 */
	@RequestMapping("/checkEmail")
	@ResponseBody
	public boolean checkEmail(String email) {
		return userServ.getUserByNickOrEmailOrUsername(email)==null?false:true;
	}
	
	/**
	 * 登陆页面
	 * @return
	 */
	@RequestMapping(value="/signin",method=RequestMethod.GET)
	public String signinPage(HttpServletRequest request){
		String from=request.getHeader("Referer");//获取来源
		request.getSession().setAttribute("fromUrl", from);
		return "/account/signin";
	}
	
	/**
	 * 登陆
	 * @param user
	 * @param attributes
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/signin",method=RequestMethod.POST)
	public String signinAction(User user,
			Errors errors,
			RedirectAttributes attributes,
			HttpServletRequest request){
		User userInDatabase=userServ.signin(user, errors);
		if(userInDatabase == null) {
			attributes.addFlashAttribute("myerror", "用户名密码错误！");
			return "redirect:/account/signin";
		} else {
			request.getSession().setAttribute("user", userInDatabase);
			attributes.addFlashAttribute("msg","您已经登录");
			return "redirect:/";
		}
	}
	
	/**
	 * 发送找回密码邮件的页面
	 * @return
	 */
	@RequestMapping(value="/forget",method=RequestMethod.GET)
	public String forgetPage(){
		return "/account/forget";
	}
	
	
	/**
	 * 发送邮件
	 * 产生的唯一校验码放在session
	 * @param email
	 * @param request
	 * @return
	 * @throws IOException
	 * @throws MessagingException
	 */
	@RequestMapping("/sendEmail")
	@ResponseBody
	public boolean sendEmail(@RequestParam("email") String email,
			HttpServletRequest request) throws IOException, MessagingException{
		User user=userServ.getUserByNickOrEmailOrUsername(email);
		if(user==null){
			return false;
		}else{
			Random random=new Random();
			String code=random.nextInt(99999)+"";
			request.getSession().setAttribute("code", code);
			return true;
//			return userServ.sendValidateEmail(email, code);
		}
	}
	
	/**
	 * 检测校验码
	 * @param code
	 * @return
	 */
	@RequestMapping("/checkCode")
	public boolean checkCode(@RequestParam("code") String code){
		return true;
	}
	
	/**
	 * 通过校验码重置密码
	 * @param username
	 * @param attributes
	 * @return
	 */
	@RequestMapping(value="/forget",method=RequestMethod.POST)
	public String forgetAction(@Validated UserResetForm userResetForm,
			Errors errors,
			HttpServletRequest request,
			RedirectAttributes attributes){
		User user=userServ.getUserByNickOrEmailOrUsername(userResetForm.getEmail());
		if(user==null){
			attributes.addFlashAttribute("myerror", "邮箱不存在！");
			return "redirect:/account/forget";
		}
//		String userCode = userResetForm.getCode();
		String code =(String) request.getSession().getAttribute("code");
//		if(code == null) {
//			attributes.addFlashAttribute("myerror", "确认你已经收到邮件了吗？");
//			return "redirect:/account/forget";
//		} else if(!code.equals(userCode)) {
//			attributes.addFlashAttribute("myerror", "亲，你的验证码输入错误！请查证再试，谢谢！");
//			return "redirect:/account/forget";
//		}
		userResetForm.setCode(code);
		userResetForm.setPassword(user.getPassword());
		userResetForm.setPassword2(userResetForm.getPassword1());
		userServ.updatePassword(userResetForm, user, errors);
		if(errors.hasErrors()){
			attributes.addFlashAttribute("error",errors.getAllErrors());
			return "redirect:/account/forget";
		}
		attributes.addFlashAttribute("msg","密码已重置");
		return "redirect:/account/signin";
	}
	
	/**
	 * 重置密码页面
	 * @return
	 */
	@RequestMapping(value="/reset",method=RequestMethod.GET)
	public String restPage(){
		return "/account/reset";
	}
	
	/**
	 * 重置密码动作
	 * @param password
	 * @param password1
	 * @param attributes
	 * @return
	 */
	@RequestMapping(value="/reset",method=RequestMethod.POST)
	public String restAction(@Validated UserResetForm userRestForm,
			Errors errors,
			HttpServletRequest request,
			RedirectAttributes attributes){
		User user=(User)request.getSession().getAttribute("user");
		userServ.updatePassword(userRestForm, user, errors);
		if(errors.hasErrors()){
			attributes.addFlashAttribute("error",errors.getAllErrors());
			return "redirect:/account/reset";
		}
		attributes.addFlashAttribute("msg","密码已经更改，请重新登录入");
		return "redirect:/account/signin";
	}
	
	/**
	 * 获取用户信息
	 * 登陆！
	 * @return
	 */
	@RequestMapping(value="/setting",method=RequestMethod.GET)
	public String infomationPage(){
		//可以直接从sessionScope获取内容
		return "/account/setting";
	}
	
	/**
	 * 激活
	 * @param code
	 * @param attributes
	 * @return
	 */
	@RequestMapping("/active")
	public String active(@RequestParam("code") String code,
			RedirectAttributes attributes){
		return "redirect:/";
	}
	
	/**
	 * 更新用户信息，需要登录拦截
	 * @param user 表单用户
	 * @param password0
	 * @param password1
	 * @param password2
	 * @param part
	 * @param request
	 * @param attributes
	 * @return
	 */
	@RequestMapping(value="/setting/update",method=RequestMethod.POST)
	public String updateInfomatio(@Validated User user,
			Errors errors,
			MultipartFile file,
			HttpServletRequest request,
			Model model){
		User oldUser=(User)request.getSession().getAttribute("user");
		String avatar="";
		user.setAvatar(avatar);
		User newUser = userServ.update(oldUser,user,errors);
		if(errors.hasErrors()){
			model.addAttribute("error",errors.getAllErrors());
			return "/account/setting";
		}	
		request.getSession().setAttribute("user", newUser);
		model.addAttribute("msg","信息已更新");
		return "/account/setting";
	}
}
