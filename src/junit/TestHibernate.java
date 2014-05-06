package junit;

import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.hibernate.classic.Session;
import org.junit.Test;

public class TestHibernate {

	@Test
	public void testAcdData(){
		Configuration config = new Configuration();
		config.configure();
		// 创建sessionFactory对象
		SessionFactory sf = config.buildSessionFactory();
		Session session = sf.openSession();
		Transaction tr = session.beginTransaction();
		/*AcdData acd = new AcdData();
		acd.setGrpname("3");
		acd.setTelnum("13951006372");
		acd.setMaxordnum(3);
		acd.setOrddelay(4);
		acd.setMailaddr("ping@sina.com");
		session.save(acd);*/
		tr.commit();
		session.close();
	}
}
