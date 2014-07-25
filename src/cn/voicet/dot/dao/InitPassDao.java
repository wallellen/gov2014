package cn.voicet.dot.dao;

import cn.voicet.dot.util.DotSession;

public interface InitPassDao {
	public final static String SERVICE_NAME = "cn.voicet.dot.dao.impl.InitPassDaoImpl";
	void initPasswordByDqbm(DotSession ds, String dqbm);
}
