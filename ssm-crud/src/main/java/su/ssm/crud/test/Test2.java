package su.ssm.crud.test;

/**
 * @author Mr.su
 * @create 2022-02-04 下午 9:39
 */
//单例饿汉式
class Test2 {
    private Test2() {

    }
    private static Test2 t = new Test2();

    public static Test2 getInstance(){
        return t;
    }

}

class tttt{
    public static void main(String[] args) {
        Test2 instance = Test2.getInstance();
        Test2 instance2 = Test2.getInstance();
        System.out.println(instance==instance2);

    }
}
