package xyz.springabc.web.front;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import xyz.springabc.domin.Node;
import xyz.springabc.domin.Topic;
import xyz.springabc.service.NodeServ;
import xyz.springabc.service.TopicServ;

@Controller
@RequestMapping("/nodes")
public class NodeAction {
	
	@Autowired
	private NodeServ nodeServ;
	
	@Autowired
	private TopicServ topicServ;
	
	/**
	 * page不能作为分页参数
	 * 显示所有节点
	 * @return
	 */
	@RequestMapping({"/",""})
	public String showAll(@RequestParam(value="p",defaultValue="1") int p,Model model){
		model.addAttribute("nodes",nodeServ.getAllOrderByTopicCount(p, 100).getContent());
		return "/nodes/index";
	}
	
	/**
	 * 显示节点内容，即按照节点显示话题列表
	 * @param name 节点名称
	 * @param p 分页参数
	 * @return
	 */
	@RequestMapping("/{id}")
	public String list(@PathVariable("id") int id,
			@RequestParam(defaultValue="1",value="p") int p,
			HttpServletRequest request,
			Model model){
		Node node=nodeServ.getOneNode(id);
		Page<Topic> topicPage=topicServ.getByNodeOrderByDefault(node, p);
		List<Topic> topics=topicPage.getContent();
		model.addAttribute("topics",topics);
		model.addAttribute("page",topicPage);
		model.addAttribute("node",node);
		return "/nodes/list";
	}
	
	/**
	 * 按照分类获取节点名
	 * @param sectionName
	 * @return List<String> 节点名
	 */
	@RequestMapping("/list/{sectionName}")
	@ResponseBody
	public List<String> list(@PathVariable("sectionName") String sectionName){
		return nodeServ.getNodeNameBySectionName(sectionName);
	}
	
}
