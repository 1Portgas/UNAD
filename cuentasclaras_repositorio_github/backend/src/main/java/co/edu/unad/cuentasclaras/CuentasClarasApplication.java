package co.edu.unad.cuentasclaras;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class CuentasClarasApplication {
    public static void main(String[] args) {
        SpringApplication.run(CuentasClarasApplication.class, args);
    }
}
