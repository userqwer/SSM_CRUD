package su.ssm.crud.bean;

import org.junit.Test;

/**
 * @author Mr.su
 * @create 2022-02-07 下午 10:22
 */
public class text {
    @Test
    public void test(){
        String str = "a-b-c";
        String[] split = str.split("-",2);
        for(int i=0; i<split.length; i++){
            System.out.print(split[i]);
        }
    }
}
