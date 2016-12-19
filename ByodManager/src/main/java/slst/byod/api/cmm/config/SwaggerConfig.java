package slst.byod.api.cmm.config;

import static com.google.common.base.Predicates.or;
import static springfox.documentation.builders.PathSelectors.regex;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import com.google.common.base.Predicate;

import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.builders.ResponseMessageBuilder;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.ResponseMessage;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

@Component
public class SwaggerConfig {
	private List<ResponseMessage> responseList = new ArrayList<ResponseMessage>();

	/**
	 * Customizing 응답 메시지 초기화
	 */
	@PostConstruct
	private void initResponseMessage() {
		ResponseMessage response500 = new ResponseMessageBuilder().code(500).message("Error").build();

		responseList.add(response500);
	}
	
	/**
	 * byod 업무별/권한별 api
	 * @return
	 */
	@Bean
	public Docket byodManagerApi() {
		return new Docket(DocumentationType.SWAGGER_2)
				// 기본 응답 Message가 아닌 특정 응답 메시지만을 사용하는 경우
				.useDefaultResponseMessages(true)
//				.globalResponseMessage(RequestMethod.GET, responseList)
				.groupName("ByodManager")
				.apiInfo(byodManagerApiInfo())
				.select()
				.apis(RequestHandlerSelectors.basePackage("slst.byod.api")) // 특정 패키지 내의 Rest API 만 Document를 생성
			 	.paths(byodManagerPath()) // 특정 URL 경로에 해당하는 REST API만 Document 생성
				.build();
	}


	private ApiInfo byodManagerApiInfo() {
		return new ApiInfoBuilder().title("ByodManager : 업무별 관리")
				.description("현장조사업무지원 시스템 - 업무별/권한별 API")
				.contact("SelimSoft")
				.version("v1.0")
				.build();
	}
	
	
	private Predicate<String> byodManagerPath() {
		return or(
				regex("/Byod/*"),
				regex("/Byod/*.*"));
	}
}
