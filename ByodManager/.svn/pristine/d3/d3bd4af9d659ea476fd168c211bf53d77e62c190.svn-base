package slst.byod;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import slst.byod.api.cmm.controller.interceptor.RequestInterceptor;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootApplication
@EnableSwagger2
@EnableAspectJAutoProxy
@EnableAutoConfiguration
public class ByodManagerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ByodManagerApplication.class, args);
	}
	
	/**
	 * 인터셉터 등록.
	 * @return
	 */
	@Bean
	public WebMvcConfigurerAdapter webMvcConfigurerAdapter() {
		return new WebMvcConfigurerAdapter() {
			@Override
			public void addInterceptors(InterceptorRegistry registry) {
				registry.addInterceptor(new RequestInterceptor()).addPathPatterns("/**");
			}
			
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**").allowedMethods("GET","POST", "PUT", "DELETE");
			}
			
		};
	}
}

