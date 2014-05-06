package cn.voicet.dot.util;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class Base64 {
	/** BASE64加密  */              
    public static String encryptBASE64(byte[] key) throws Exception {               
        return (new BASE64Encoder()).encodeBuffer(key);               
    }
    
	/** BASE64解密 */              
    public static byte[] decryptBASE64(String key) throws Exception {               
        return (new BASE64Decoder()).decodeBuffer(key);               
    } 
    
    public static void main(String args[]) throws Exception{
    	//String key = Base64.encryptBASE64((sname+"_"+sid).getBytes());
    	String data = Base64.encryptBASE64(("demo@demo.com"+"_"+"36").getBytes());     
        System.out.print("加密前："+data);     
             
        byte[] byteArray = Base64.decryptBASE64(data);     
        System.out.print("解密后："+new String(byteArray)); 
    }
}
