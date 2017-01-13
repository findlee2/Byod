package slst.byod.api.cmm.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import slst.byod.api.userManage.UserManageVO;

@Controller
public class CommonViewController {
	/*
	*//**
	 * url root
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/")
	public String redirectLoginView() throws Exception{
		return "forward:/login";
	}
	
	*//**
	 * 로그인 페이지 출력
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/login")
	public String loginView() throws Exception{		
		
		
		return "userLogin";
	}
	
	*//**
	 * 화면단 탑 메뉴 출력
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/cmm/byodManagerTopView")
	public ModelAndView byodManagerTopView() throws Exception{
		return new ModelAndView("include/top");
	}
	
	*//**
	 * 업무관리 리스트 페이지 출력
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/srchInfo/srchInfoList")
	public ModelAndView byodManagerSrchInfoListView(HttpServletRequest request,	ModelMap model) throws Exception{
		
		UserManageVO userVO = (UserManageVO)request.getSession().getAttribute("userVO");		
		model.addAttribute("userVO", userVO);
		
		return new ModelAndView("srchInfo/srchInfoList");
		
	}
	
	*//**
	 * 업무관리 리스트 페이지 출력
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/srchInfo/srchDetailInfo")
	public ModelAndView byodManagerSrchDetailInfoView(@RequestParam("reportNo") String reportNo,
			ModelMap model) throws Exception{
		
		model.addAttribute("reportNo", reportNo);
		return new ModelAndView("srchInfo/srchDetailInfo");
		
	}
	
	*//**
	 * 사용자관리 리스트 페이지 출력
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/userInfo/userInfoList")
	public ModelAndView byodManagerUserInfoListView(HttpServletRequest request,	ModelMap model) throws Exception{
		
		UserManageVO userVO = (UserManageVO)request.getSession().getAttribute("userVO");		
		model.addAttribute("userVO", userVO);
		
		return new ModelAndView("userInfo/userInfoList");
	}
	
	*//**
	 * 단말기관리 리스트 페이지 출력
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/srchEqupmnt/srchEqupmntList")
	public ModelAndView byodManagerSrchEqupmntListListView(HttpServletRequest request,	ModelMap model) throws Exception{
		
		UserManageVO userVO = (UserManageVO)request.getSession().getAttribute("userVO");		
		model.addAttribute("userVO", userVO);
		
		return new ModelAndView("srchEqupmnt/srchEqupmntList");
	}
	
	*//**
	 * 로그관리 리스트 페이지 출력
	 * @return
	 * @throws Exception
	 *//*
	@RequestMapping(value="/logInfo/logInfoList")
	public ModelAndView byodManagerLogInfoListView(HttpServletRequest request,	ModelMap model) throws Exception{
		
		UserManageVO userVO = (UserManageVO)request.getSession().getAttribute("userVO");		
		model.addAttribute("userVO", userVO);
		
		return new ModelAndView("logInfo/logInfoList");
	}
	*/
}
