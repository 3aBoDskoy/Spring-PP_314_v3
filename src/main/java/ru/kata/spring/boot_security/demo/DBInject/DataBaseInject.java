package ru.kata.spring.boot_security.demo.DBInject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.kata.spring.boot_security.demo.models.Role;
import ru.kata.spring.boot_security.demo.models.User;
import ru.kata.spring.boot_security.demo.repositories.RoleRepository;
import ru.kata.spring.boot_security.demo.repositories.UserRepository;
import javax.annotation.PostConstruct;
import java.util.Set;


@Configuration
public class DataBaseInject {
    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;

    @Autowired
    public DataBaseInject(UserRepository userRepository,
                                 RoleRepository roleRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @PostConstruct
    public void init() {
        Role adminRole = new Role("ROLE_ADMIN");
        roleRepository.save(adminRole);
        Role userRole = new Role("ROLE_USER");
        roleRepository.save(userRole);

        User admin = new User("admin", "admin", 33, "admin@mail.ru", passwordEncoder.encode("101"));
        admin.setRoles(Set.of(adminRole, userRole));
        userRepository.save(admin);

        User user = new User("user", "user", 22, "user@mail.ru", passwordEncoder.encode("101"));
        user.setRoles(Set.of(userRole));
        userRepository.save(user);
    }
}