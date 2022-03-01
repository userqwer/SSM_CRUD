package su.ssm.crud.test;

import sun.security.jca.GetInstance;

/**
 * @author Mr.su
 * @create 2022-02-04 下午 7:59
 */
//单例懒汉式
class Test {
    private Test(){

    }

    private  static Test instance = null;

    public static Test getInstance(){
        //如果不是null了，就不用进入if里了，
        // 直接拿return instance这个对象走就行了
        if(instance == null){
            synchronized (Test.class){
                if(instance == null){
                    instance = new Test();
                }
            }
        }
        return instance;
    }
}
class ttttt{
    public static void main(String[] args) {
        Test instance = Test.getInstance();
        Test instance2 = Test.getInstance();
        System.out.println(instance==instance2);

    }
}


