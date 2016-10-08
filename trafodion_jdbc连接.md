## Trafodion JDBC 连接
[参考指引](https://trafodion.apache.org/docs/client_install/index.html#jdbct4-install-instructions)

## 下载 JDBCT4 依赖包
- 下载对应版本的 *client* [下载连接](http://trafodion.apache.org/download.html)
- 解压里面的 JDBCT4.zip 在lib目录找到对应的jar包

## 配置好你的 JAVA 环境
- Trafodion 要求 JDK版本必须是1.7以上的**The Java version should be 1.7 or higher**
- 将上面的 jdbcT4.jar 放入你的 classpath ，如果是用IDE环境，记得引入上述jar包

## 启动 Trafodion DCS 服务
到 Trafodion 安装服务器启动 DCS ( Trafodion Database Connectivity Services )服务
```
./server/dcs-2.0.1/bin/start-dcs.sh
确保 JDBC 连接的端口 23400 已经开启
```

## 编写连接测试代码
```java
//STEP 1. Import required packages
import java.sql.*;

public class TrafodionConn {
    // JDBC driver name and database URL
    static final String JDBC_DRIVER = "org.trafodion.jdbc.t4.T4Driver";
    static final String DB_URL = "jdbc:t4jdbc://172.18.84.84:23400/:";
    //  Database credentials
    static final String USER = "usr";
    static final String PASS = "pwd";

    public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        try{
            //STEP 2: Register JDBC driver
            Class.forName(JDBC_DRIVER);
            //STEP 3: Open a connection
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL,USER,PASS);

            //STEP 4: Execute a query
            System.out.println("Creating statement...");
            stmt = conn.createStatement();
            String sql;
            sql = "select * from trafodion.sales.odetail";
            ResultSet rs = stmt.executeQuery(sql);

            //STEP 5: Extract data from result set
            while(rs.next()){
                //Retrieve by column name
                int ordernum  = rs.getInt("ordernum");
                int partnum = rs.getInt("partnum");
                float unit_price = rs.getFloat("unit_price");
                int qty_ordered = rs.getInt("qty_ordered");

                //Display values
                System.out.print("ordernum: " + ordernum);
                System.out.print(", partnum: " + partnum);
                System.out.print(", unit_price: " + unit_price);
                System.out.println(", qty_ordered: " + qty_ordered);
            }
            //STEP 6: Clean-up environment
            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException se){
            //Handle errors for JDBC
            se.printStackTrace();
        }catch(Exception e){
            //Handle errors for Class.forName
            e.printStackTrace();
        }finally{
            //finally block used to close resources
            try{
                if(stmt!=null)
                    stmt.close();
            }catch(SQLException se2){
            }// nothing we can do
            try{
                if(conn!=null)
                    conn.close();
            }catch(SQLException se){
                se.printStackTrace();
            }//end finally try
        }//end try
        System.out.println("Goodbye!");
    }//end main
}//end FirstExample
```
