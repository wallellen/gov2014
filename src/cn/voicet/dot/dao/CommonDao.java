package cn.voicet.dot.dao;

import java.util.LinkedHashMap;
import java.util.List;

public interface CommonDao<T> {
	
	void save(T entity);
	void update(T entity);
	List<T> findCollectionByConditionNoPage(String hqlWhere, Object[] params, LinkedHashMap<String, String> orderby);
	
}
