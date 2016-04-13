package xyz.springabc.web.front;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import xyz.springabc.domin.Comment;
import xyz.springabc.domin.User;
import xyz.springabc.service.CommentServ;
import xyz.springabc.service.UserService;

@Controller
@RequestMapping("/comments")
public class CommentAction {
	
	@Autowired
	private CommentServ commentServ;
	
	@Autowired
	private UserService userServ;
	
	@RequestMapping("/create")
	public String create(@RequestParam(value = "topicId", required = true) int topicId,
			@RequestParam(value = "topicUserId", required = true) int topicUserId,
			@Validated Comment comment,
			Errors result,
			HttpServletRequest request,
			Model model,RedirectAttributes redirectAttrs){
		User user = (User) request.getSession().getAttribute("user");
		if(user != null && "0".equals(user.getAvatar())) {
			redirectAttrs.addFlashAttribute("error","您已被禁言，请与管理员联系");
			return "/comments/_msg";
		}
		User notifyUser = userServ.getByUserId(topicUserId);
		String contextPath=request.getContextPath();
		if(result.hasErrors()){
			model.addAttribute("error",result.getAllErrors());
			return "/comments/_msg";
		}else{
			comment.setUser(user);
			commentServ.create(notifyUser,comment, topicId, contextPath);
			model.addAttribute("comment",comment);
			return "/comments/_show";
		}
	}
	
	@RequestMapping("/{id}/edit")
	public String edit(@PathVariable("id") int id,Model model,HttpServletRequest request,RedirectAttributes redirectAttrs){
		User user = (User) request.getSession().getAttribute("user");
		if(user != null && "0".equals(user.getAvatar())) {
			redirectAttrs.addFlashAttribute("myerror","您已被禁言，请与管理员联系");
			return "/comments/_show";
		}
		model.addAttribute("comment",commentServ.getOne(id));
		return "/comments/edit";
	}
	
	@RequestMapping("/update")
	public String eidt(Comment comment,RedirectAttributes attributes){
		commentServ.update(comment);
		attributes.addFlashAttribute("msg","已经更改");
		return "redirect:/comments/"+comment.getId()+"/edit";
	}
	
	@RequestMapping("/{id}/delete")
	@ResponseBody
	public boolean delete(@PathVariable("id") int id,
			HttpServletRequest request){
		Comment comment=commentServ.getOne(id);
		commentServ.delete(comment);
		return true;
	}
	
	@RequestMapping("/{id}/like")
	@ResponseBody
	public boolean like(@PathVariable("id") int id,
			HttpServletRequest request){
		User user=(User)request.getSession().getAttribute("user");
		Comment comment=commentServ.getOne(id);
		return commentServ.like(comment, user);
	}
}
