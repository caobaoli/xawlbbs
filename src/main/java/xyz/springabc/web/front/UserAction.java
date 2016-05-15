package xyz.springabc.web.front;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import xyz.springabc.domin.User;
import xyz.springabc.service.CollectionServ;
import xyz.springabc.service.CommentServ;
import xyz.springabc.service.NotificationServ;
import xyz.springabc.service.TopicServ;
import xyz.springabc.service.UserService;

@Controller
@RequestMapping("/users")
public class UserAction {
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private CollectionServ collectionServ;
	
	@Autowired
	private NotificationServ  notificationServ;
	
	@Autowired
	private TopicServ topicServ;
	
	@Autowired
	private CommentServ commentServ;
	
	/**
	 * 获取收藏列表
	 * @param id
	 * @param p
	 * @return
	 */
	@RequestMapping("/{id}/collections")
	public String favorites(@PathVariable(value="id") int id,
			@RequestParam(defaultValue="1",value="p") int p,
			Model model,
			HttpServletResponse response){
		User user=userServ.getByUserId(id);
		if(user==null){
			response.setStatus(404);
		}else{
			model.addAttribute("user",user);
			model.addAttribute("page",collectionServ.getByUserId(user, p, 6));
		}
		return "/users/collections";
	}
	
	/**
	 * 获取用户话题列表
	 * @param p
	 * @param id
	 * @return
	 */
	@RequestMapping("/{id}/topics")
	public String topics(@RequestParam(defaultValue="1",value="p") int p,
			@PathVariable(value="id") int id,
			Model model,
			HttpServletResponse response){
		User user=userServ.getByUserId(id);
		if(user==null){
			response.setStatus(404);
		}else{
			model.addAttribute("user", user);
			model.addAttribute("page",topicServ.getByUser(user, p, 6));
		}
		return "users/topics";
	}
	
	/**
	 * 获取用户评论列表
	 * @param p
	 * @param id
	 * @return
	 */
	@RequestMapping("/{id}/comments")
	public String comments(@RequestParam(defaultValue="1",value="p") int p,
			@PathVariable(value="id") int id,
			Model model,
			HttpServletResponse response){
		User user=userServ.getByUserId(id);
		if(user==null){
			response.setStatus(404);
		}else{
			model.addAttribute("user",user);
			model.addAttribute("page",commentServ.getByUser(user, p, 6));
		}
		return "users/comments";
	}

}
