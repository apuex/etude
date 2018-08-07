package com.sample.app;

import java.security.Principal;

public class UserPrincipal implements Principal {
    private final String username;
    public UserPrincipal(String username) {
        this.username = username;
    }

    @Override
    public String getName() {
        return username;
    }
}
