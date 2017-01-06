package slst.byod.api.cmm.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import slst.byod.api.userManage.UserManageVO;

@Controller
public class CommonViewController {
	
	/**
	 * url root
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/")
	public String redirectLoginView() throws Exception{
		return "forward:/login";
	}
	
	/**
	 * 로그인 페이지 출력
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/login")
	public String loginView() throws Exception{		
		return "userInfo/userLogin";
	}
	
	/**
	 * 화면단 탑 메뉴 출력
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cmm/byodManagerTopView")
	public ModelAndView byodManagerTopView() throws Exception{
		return new ModelAndView("include/top");
	}
	
	/**
	 * 업무관리 리스트 페이지 출력
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/srchInfo/srchInfoList",  method = RequestMethod.POST)
	public ModelAndView byodManagerSrchInfoListView(HttpServletRequest request,	ModelMap model) throws Exception{
		
		UserManageVO userVO = (UserManageVO)request.getSession().getAttribute("userVO");
		
		model.addAttribute("userVO", userVO);
		return new ModelAndView("srchInfo/srchInfoList");
	}
	
}
