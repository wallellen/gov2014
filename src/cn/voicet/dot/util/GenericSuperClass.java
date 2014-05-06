package cn.voicet.dot.util;

import java.lang.reflect.ParameterizedType;

@SuppressWarnings("unchecked")
public class GenericSuperClass {

	/**
	 * 范类转换, 转换成对应的对象
	 * @param tClass 范类
	 * @return
	 */
	public static Class getClass(Class tClass) {
		ParameterizedType parameterizedType = (ParameterizedType) tClass.getGenericSuperclass();
		Class entity = (Class)parameterizedType.getActualTypeArguments()[0];
		return entity;
	}

}
