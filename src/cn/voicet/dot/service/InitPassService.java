package cn.voicet.dot.service;

import cn.voicet.dot.util.DotSession;

public interface InitPassService {
	public final static String SERVICE_NAME = "cn.voicet.dot.service.impl.InitPassServiceImpl";
	void initPasswordByDqbm(DotSession ds, String dqbm);
}
