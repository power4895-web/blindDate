package com.example.self_board_project.core.authority;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

/**
 * Argument 사용자 정보 조회
 */
public class UserHandlerMethodArgumentResolver  implements HandlerMethodArgumentResolver {


	public boolean supportsParameter(MethodParameter parameter) {
		System.out.println("supportsParameter Start"); //api에서 파라미터에 auth넣고 컨파일 돌리면 실행
		System.out.println("parameter" + parameter); //파라미터는 해당 메소드이름, 등록되는 듯
		System.out.println("Auth.class.isAssignableFrom(parameter.getParameterType()" + Auth.class.isAssignableFrom(parameter.getParameterType())); //true
		return Auth.class.isAssignableFrom(parameter.getParameterType());
	}

	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
                                  NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {

		System.out.println("resolveArgument");
		return AuthUtil.getUser();
	}

}